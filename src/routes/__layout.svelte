<script lang="ts">
	import '../app.scss';

    import { Nav } from '../lib/ui/nav';
    import ModalContainer from "../lib/ui/modal/ModalContainer.svelte";
</script>

<main class="w-full h-full relative">
    <ModalContainer />
    <Nav />
    <slot />
</main>

<style lang="scss">
    main {
      height: 100%;
      width: 100%;
      background-color: #e5e5f7;
      opacity: 0.8;
      background-image:  linear-gradient(lightgrey 1px, transparent 1px), linear-gradient(to right, lightgrey 1px, #e5e5f7 1px);
      background-size: 20px 20px;
    }
</style>
