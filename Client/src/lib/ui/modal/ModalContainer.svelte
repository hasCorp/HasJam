<script lang="ts">
    import { scale, fade, fly } from 'svelte/transition';
    import { modal, close } from './modal.state';
    import Container from '../util/Container.svelte';
</script>

{#if $modal.isOpen}
    <div
            class="absolute z-[100] w-full h-screen"
            transition:fade={{ delay: 0, duration: 150 }}
            on:dragover|preventDefault
    >
        <div class="click-to-close" on:click={close}>
            {#if $modal.showBackdrop}
                <div class="bg-zinc-800 backdrop-blur opacity-75 w-screen h-screen"></div>
            {/if}
        </div>
        <div class="popup-container" transition:scale={{ delay: 0, duration: 200 }}>
            {#key $modal.currPage}
                <div in:fly={{ delay: 0, duration: 200, x: -200 }}>
                    <Container>
                        <svelte:component this={$modal.components[$modal.currPage]} />
                    </Container>
                </div>
            {/key}
        </div>
    </div>
{/if}

<style lang="scss">
  div.popup-container {
    @apply relative z-[110] w-fit;
    margin: 50vh auto 0;
    transform: translateY(-50%);
  }
  div.click-to-close {
    @apply absolute z-[100] w-full h-screen;
  }
</style>