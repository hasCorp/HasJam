<script lang="ts">
    import { Loader5Line } from "svelte-remixicon";

    export let loading = false;
    export let active = false;
    export let disabled = false;
    export let loadingText = 'Loading...';
    export let type = 'button';
    export let kind: 'primary' | 'normal' = 'normal';
    export let title = '';
    export let asLink = false;
    export let href = '/';

    let isDisabled: boolean;
    $: isDisabled = disabled || loading;
</script>

{#if asLink}
    <a
            class:primary={kind === 'primary'}
            class:active={active}
            tabindex="0"
            {title}
            {href}
    >
        {#if loading}
            <Loader5Line class="button-icon animate-spin" />
            <span class="button-text">{loadingText}</span>
        {:else}
            <slot />
        {/if}
    </a>
{:else}
    <button
            {type}
            class:primary={kind === 'primary'}
            class:active={active}
            {title}
            class:disabled
            disabled={isDisabled}
            tabindex="0"
            on:click
    >
        {#if loading}
            <Loader5Line class="button-icon animate-spin" />
            <span class="button-text">{loadingText}</span>
        {:else}
            <slot />
        {/if}
    </button>
{/if}

<style lang="scss">
  button, a {
    @apply flex items-center p-2 transition transform focus:ring-0 m-0 text-sm rounded-lg select-none font-medium;
    &.primary,
    &.active {
      @apply text-white bg-orange-600;
      &:hover {
        @apply bg-orange-700;
      }
    }
    &.primary.active {
      @apply text-white bg-orange-300;
    }
    &.disabled {
      @apply text-zinc-500 cursor-not-allowed;
      &:hover,
      &:active {
        background: transparent;
        text-decoration: none;
        @apply scale-100;
      }
    }
    &.primary.disabled {
      @apply cursor-not-allowed text-orange-900;
      &:hover,
      &:active {
        @apply text-orange-900 bg-orange-600;
        text-decoration: none;
        @apply scale-100;
      }
    }
    &:hover {
      @apply text-white bg-orange-600;
      text-decoration: none;
      @apply scale-105;
    }
    &:active {
      @apply text-white scale-100 cursor-pointer shadow-inner bg-orange-900;
    }
    :global(svg.button-icon) {
      @apply mr-1.5 relative w-[18px] h-[18px];
    }
    :global(svg.button-icon.no-text) {
      @apply mr-0;
    }
    :global(span.button-text) {
      @apply relative;
    }
  }
</style>