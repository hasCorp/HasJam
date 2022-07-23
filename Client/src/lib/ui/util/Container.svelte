<div class="container">
    <slot />
</div>

<style lang="scss">
  div.container {
    @apply rounded-xl border-b-4 border-b-orange-600 drop-shadow-lg w-full p-6;
    background-color: #f3f3fa;
  }
</style>
