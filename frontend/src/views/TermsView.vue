<template>
  <div class="min-h-screen terms-shell flex justify-center">

    <!-- PAGE CONTAINER -->
    <div
      class="
        mx-auto
        flex
        w-full
        max-w-6xl
        flex-col
        gap-5
        px-6
        pt-32
        pb-24
      "
    >

      <!-- HERO -->
      <section class="mb-14">

        <!-- SMALL LABEL -->
        <p
          class="
            mb-4
            text-xl
            font-bold
            uppercase
            tracking-[0.35em]
            text-[var(--color-primary)]
          "
        >
          Commission Information
        </p>

        <!-- TITLE -->
        <h1
          class="
            text-5xl
            2xl:text-6xl
            font-black
            leading-none
            tracking-tight
            text-[var(--color-dark)]
          "
        >
          Terms & Conditions
        </h1>

        <!-- DESCRIPTION -->
        <p
          class="
            mt-6
            text-xl
            leading-9
            text-[var(--color-dark)]/70
          "
        >
          Please read all information carefully before placing an order.
          These terms are made to keep the commission process clear,
          comfortable, and fair for both client and artist.
        </p>
      </section>

      <!-- IMPORTANT NOTES -->
      <section
        class="
          mb-10
          rounded-[32px]
          border
          border-[var(--color-primary)]/10
          bg-[var(--color-cream)]/45
          p-8
          shadow-[0_10px_30px_rgba(0,0,0,0.05)]
          backdrop-blur-xl
        "
      >
        <h2
          class="
            text-2xl
            font-black
            text-[var(--color-dark)]
          "
        >
          Important Notes
        </h2>

        <ul
          class="
            mt-5
            grid
            gap-4
            2xl:grid-cols-3
            text-2xl
            leading-8
            text-[var(--color-dark)]/75
          "
        >
          <li
            class="
              rounded-2xl
              bg-[var(--color-light)]/40
              px-5
              py-4
            "
          >
            Personal use only unless commercial rights are purchased.
          </li>

          <li
            class="
              rounded-2xl
              bg-[var(--color-light)]/40
              px-5
              py-4
            "
          >
            Major revisions are not accepted after sketch approval.
          </li>

          <li
            class="
              rounded-2xl
              bg-[var(--color-light)]/40
              px-5
              py-4
            "
          >
            Refunds are unavailable once the artwork process has started.
          </li>
        </ul>
      </section>

      <!-- TERMS LIST -->
      <section class="space-y-7 flex flex-col gap-5">

        <div
          v-for="(section, index) in termsSections"
          :key="index"
          class="
            rounded-[34px]
            border
            border-[var(--color-light)]/30
            bg-[var(--color-light)]/60
            p-9
            shadow-[0_12px_32px_rgba(0,0,0,0.05)]
            backdrop-blur-xl
            transition-all
            duration-300
            hover:-translate-y-1
            hover:shadow-[0_18px_45px_rgba(0,0,0,0.08)]
          "
        >
          <div class="flex flex-col gap-6 2xl:flex-row">

            <!-- NUMBER -->
            <div
              class="
                flex
                h-14
                w-14
                shrink-0
                items-center
                justify-center
                rounded-2xl
                bg-[var(--color-primary)]
                text-3xl
                pb-2
                font-black
                text-[var(--color-light)]
                shadow-lg
              "
            >
              {{ String(index + 1).padStart(2, '0') }}
            </div>

            <!-- CONTENT -->
            <div class="flex-1">

              <!-- TITLE -->
              <h2
                class="
                  text-3xl
                  font-black
                  tracking-tight
                  text-[var(--color-dark)]
                "
              >
                {{ section.title }}
              </h2>

              <!-- LIST -->
              <ol
                class="
                  mt-6
                  space-y-5
                  text-2xl
                  leading-8
                  text-[var(--color-dark)]/75
                "
              >
                <li
                  v-for="(item, itemIndex) in section.items"
                  :key="itemIndex"
                  class="flex gap-4"
                >
                  <span
                    class="
                      mt-[2px]
                      font-black
                      text-[var(--color-primary)]
                    "
                  >
                    {{ itemIndex + 1 }}.
                  </span>

                  <span class="flex-1">
                    {{ item }}
                  </span>
                </li>
              </ol>

            </div>
          </div>
        </div>

      </section>
    </div>
  </div>
</template>

<script setup lang="ts">

const termsSections = [
  {
    title: 'General',
    items: [
      'By commissioning me, you agree to all the terms and conditions listed below.',
      'These terms may be updated at any time, so please review them before placing an order.',
      'All commissions are for personal use only unless commercial rights are purchased.'
    ]
  },

  {
    title: 'Process',
    items: [
      'The commission process will be done in stages: Sketch → Coloring → Finalization.',
      'You will receive a sketch preview for approval before continuing to the next stage.',
      'Once the sketch is approved, major revisions are no longer accepted.'
    ]
  },

  {
    title: 'Payment',
    items: [
      'Full payment or minimum deposit is required after the sketch is approved.',
      'Orders will be automatically cancelled if payment is not completed within 2 days.',
      'Available payment methods and additional fees will be shown during checkout.'
    ]
  },

  {
    title: 'Revisions',
    items: [
      'Minor changes are allowed during the sketch phase.',
      'Additional revisions after final delivery may incur extra charges.',
      'Revisions caused by unclear instructions are not free of charge.'
    ]
  },

  {
    title: 'Delivery',
    items: [
      'Final artwork will be delivered digitally via email in PNG or JPG format.',
      'Delivery time depends on complexity and current workload.',
      'Please check your email regularly for updates and final delivery.'
    ]
  },

  {
    title: 'Usage & Copyright',
    items: [
      'The artist retains all rights to the artwork unless stated otherwise.',
      'Clients may use the artwork for personal and non-commercial purposes only.',
      'Do not claim, resell, or commercially use the artwork without permission.',
      'The artist may post the artwork on portfolio or social media unless requested otherwise.'
    ]
  },

  {
    title: 'Refunds & Cancellations',
    items: [
      'Full refunds are only available before the sketching process begins.',
      'No full refund will be issued after work has started or sketch has been approved.',
      'If the artist cancels the commission, a full refund will be provided.'
    ]
  },

  {
    title: 'Feedback & Testimonials',
    items: [
      'Clients are welcome to leave ratings or testimonials after receiving the artwork.',
      'Usernames can be hidden upon request for public testimonials.'
    ]
  },

  {
    title: 'Contact',
    items: [
      'For questions, updates, or special requests, please contact me directly.'
    ]
  }
]
</script>