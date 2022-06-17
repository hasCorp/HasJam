<script lang="ts">
    import { page } from '$app/stores';
    import { LoginBoxLine, UserAddLine } from "svelte-remixicon";
    import { Button } from "../util";
    import { open } from "../modal";
    import { LoginForm } from "../../forms/auth";
</script>

<nav class="flex items-center h-16 sticky top-0 z-50 border-l-8 border-orange-600 px-4 drop-shadow-lg mb-6">
    <a href="/" class="home-icon" class:active={$page.url.pathname === '/'}>hasJAM</a>
    <div class="mx-2"></div>
    <a href="/jams" class="nav-link first" class:active={$page.url.pathname.includes('/jams')}>Jams</a>
    <a href="/rankings" class="nav-link" class:active={$page.url.pathname.includes('/rankings')}>Rankings</a>
    <a href="/about" class="nav-link" class:active={$page.url.pathname.includes('/about')}>About</a>
    <div class="flex-1"></div>
    <div class="flex items-center">
        <Button on:click={() => open(LoginForm)}>
            <LoginBoxLine class="button-icon" />
            <span class="button-text">Log In</span>
        </Button>
        <div class="mx-1"></div>
        <Button kind="primary">
            <UserAddLine class="button-icon" />
            <span class="button-text">Sign Up</span>
        </Button>
    </div>
</nav>

<style lang="scss">
    nav {
      background-color: #f3f3fa;
      a.home-icon {
        @apply text-xl relative top-0.5 font-medium border-b-2 border-transparent;
        &:hover {
          @apply border-orange-600;
        }
      }
      a.nav-link {
        @apply mx-2 relative top-[0.1625rem];
        &.first {
          @apply ml-0;
        }
      }
      a.home-icon, a.nav-link {
        @apply border-b-2 border-transparent transition transform;
        font-family: 'Fira Code', serif;
        &:hover {
          @apply border-orange-600;
        }
        &.active {
          @apply border-orange-600;
        }
      }
    }
</style>