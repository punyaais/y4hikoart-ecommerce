<?php

namespace App\Filament\Widgets;

use App\Models\Order;
use App\Models\Product;
use App\Models\Testimonial;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsOverview extends BaseWidget
{
    protected function getStats(): array
    {
        $totalRevenue = Order::where('status', 'done')->sum('total_price');

        return [

            Stat::make('Total Orders', Order::count())
                ->description('All customer orders')
                ->descriptionIcon('heroicon-m-shopping-bag')
                ->color('primary'),

            Stat::make('Completed Orders', Order::where('status', 'done')->count())
                ->description('Finished commissions')
                ->descriptionIcon('heroicon-m-check-circle')
                ->color('success'),

            Stat::make('WIP Orders', Order::where('status', 'wip')->count())
                ->description('Orders in progress')
                ->descriptionIcon('heroicon-m-clock')
                ->color('warning'),

            Stat::make(
                'Total Revenue',
                'Rp ' . number_format($totalRevenue, 0, ',', '.')
            )
                ->description('Revenue from completed orders')
                ->descriptionIcon('heroicon-m-banknotes')
                ->color('success'),

            Stat::make('Products', Product::count())
                ->description('Available commission products')
                ->descriptionIcon('heroicon-m-photo')
                ->color('info'),

            Stat::make('Testimonials', Testimonial::count())
                ->description('Customer reviews')
                ->descriptionIcon('heroicon-m-star')
                ->color('danger'),

        ];
    }
}