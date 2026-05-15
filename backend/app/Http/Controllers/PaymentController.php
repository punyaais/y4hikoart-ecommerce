<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Xendit\Configuration;
use Xendit\Invoice\InvoiceApi;
use App\Models\Payment;
use App\Models\Order;

class PaymentController extends Controller
{
    public function createInvoice(Request $request)
{
    // 🔥 SET API KEY (CARA BARU)
    Configuration::setXenditKey(config('services.xendit.secret_key'));

    $orderIds = $request->order_ids;

    if (!$orderIds || !is_array($orderIds)) {
        return response()->json([
            'error' => 'Order tidak valid'
        ], 400);
    }

    $orders = Order::whereIn('order_id', $orderIds)->get();

    if ($orders->isEmpty()) {
        return response()->json([
            'error' => 'Order tidak ditemukan'
        ], 404);
    }

    $totalAmount = $orders->sum('total_price');

    $externalId = 'order-' . implode('-', $orderIds);

    $frontendUrl = env('FRONTEND_URL');

    try {
        $apiInstance = new InvoiceApi();

        $invoice = $apiInstance->createInvoice([
            'external_id' => $externalId,
            'amount' => $totalAmount,
            'payer_email' => $request->email,
            'description' => 'Payment for orders',
            'success_redirect_url' =>
                $frontendUrl . '/receipt?orders=' .
                implode(',', $orderIds) .
                '&from_payment=1',

            'failure_redirect_url' =>
                $frontendUrl . '/receipt?orders=' .
                implode(',', $orderIds),
        ]);
    } catch (\Exception $e) {
        return response()->json([
            'error' => 'Gagal membuat invoice',
            'message' => $e->getMessage()
        ], 500);
    }

    foreach ($orders as $order) {

        $payment = Payment::where(
            'order_id',
            $order->order_id
        )->first();

        if ($payment) {

            $payment->update([
                'payment_method' => 'xendit',
                'transaction_id' => $invoice['id'],
                'external_id' => $externalId,
                'payment_url' => $invoice['invoice_url']
            ]);
        }
    }

    return response()->json([
        'invoice_url' => $invoice['invoice_url']
    ]);
}
public function webhook(Request $request)
{
    \Log::info('WEBHOOK MASUK');
    \Log::info($request->all());

    $callbackToken = $request->header('x-callback-token');

    if ($callbackToken !== env('XENDIT_CALLBACK_TOKEN')) {
        return response()->json([
            'error' => 'Invalid callback token'
        ], 403);
    }

    $externalId = $request->external_id;
    $invoiceId = $request->id;
    $status = $request->status;

    \Log::info('STATUS DARI XENDIT: ' . $status);

    $payments = Payment::where(
        'external_id',
        $externalId
    )->get();

    \Log::info($payments);

    if ($payments->isEmpty()) {

        \Log::info('PAYMENT TIDAK DITEMUKAN');

        return response()->json([
            'error' => 'Payment not found'
        ], 404);
    }

    if (strtoupper($status) === 'PAID') {

        foreach ($payments as $payment) {

            $payment->update([
                'payment_status' => 'paid',
                'paid_at' => now(),
                'transaction_id' => $invoiceId
            ]);

            $payment->order->update([
                'progress_stage' => 'Payment Receive',
                'status' => 'wip'
            ]);
        }

        \Log::info('PAYMENT BERHASIL DIUPDATE');
    }

    elseif (strtoupper($status) === 'EXPIRED') {

        foreach ($payments as $payment) {

            $payment->update([
                'payment_status' => 'expired'
            ]);
        }
    }

    return response()->json([
        'success' => true
    ]);
}
}