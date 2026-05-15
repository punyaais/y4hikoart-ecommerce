<div class="flex flex-wrap gap-3">
    @php
        $images = $getState() ?? [];
    @endphp

    @foreach ($images as $image)
        <img
            src="{{ asset($image['image_url']) }}"
            style="
                width: 140px;
                height: 140px;
                object-fit: cover;
                border-radius: 12px;
                border: 1px solid #e5e7eb;
            "
        >
    @endforeach
</div>