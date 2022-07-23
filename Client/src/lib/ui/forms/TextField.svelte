<script lang="ts">
    import { fade } from "svelte/transition";

    export let name = 'text';
    export let type = 'text';
    export let title = 'Text Input';
    export let placeholder = 'Text Input';
    export let value = null;
    export let errorMessage;
</script>

<div class="text-field">
    <label
            for={name}
            class="text-[0.625rem] relative z-20 top-[0.15rem] left-1 py-0.5 px-1 rounded-t-lg font-semibold tracking-wider uppercase"
    >
        {title}
    </label>
    <input
            id={name}
            {type}
            {name}
            {title}
            {placeholder}
            {value}
            class:error={!!errorMessage}
            on:change
            on:keypress
    />
    {#if !!errorMessage && errorMessage !== ''}
        <span
                class="text-[0.625rem] text-red-500 relative -top-1 left-2"
                transition:fade|local={{ delay: 0, duration: 350 }}>{errorMessage}</span
        >
    {/if}
</div>

<style lang="scss">
  div.text-field {
    @apply w-full my-2;
    input {
      @apply w-full relative z-10 rounded-lg px-3 pt-3 pb-2.5 border-b-2 border-transparent transition drop-shadow-md;
      &:focus {
        @apply ring-0 shadow-md border-b-2 border-b-orange-600;
      }
      &.error {
        @apply border-b-2 border-red-500;
      }
    }
  }
</style>