<script lang="ts">
    import { createForm } from "felte";
    import { Button } from "../../ui/util"
    import { TextField } from "../../ui/forms";
    import { LoginBoxLine, CloseLine, GithubFill, DiscordFill } from 'svelte-remixicon';
    import { close } from '../../ui/modal';
    import { signInWithEmail, signInWithGithub, signInWithDiscord } from '../../db/auth';

    const { form, isSubmitting } = createForm({
        onSubmit: async (values) => {
            await signInWithEmail(values.email, values.password);
        },
        validate: (values) => {
            // TODO: perform more validation on form values
            const errors = {
                email: '',
                password: '',
            };

            if (values.email === '' || values.email === null) {
                errors.email = 'You must provide a valid email.';
            }

            if (values.password === '' || values.password === null){
                errors.password = 'You must provide a password.';
            }
        },
        initialValues: {
            email: null,
            password: null,
        }
    })
</script>

<div class="flex items-center mb-4">
    <h1 class="text-4xl mb-0">Log In</h1>
    <div class="flex-1"></div>
    <Button on:click={close}>
        <CloseLine class="button-icon no-text" />
    </Button>
</div>

<form use:form>
    <TextField
        name="email"
        type="email"
        title="Email Address"
        placeholder="somebody@example.com"
    />
    <TextField
        name="password"
        type="password"
        title="Password"
        placeholder="••••••••••"
    />
    <div class="mt-4 flex items-center">
        <div class="flex-1"></div>
        <Button kind="primary" type="submit" loading={$isSubmitting}>
            <LoginBoxLine class="button-icon" />
            <span class="button-text">Log In</span>
        </Button>
    </div>
</form>

<div class="border-t border-zinc-300 pt-4 mt-4">
    <button class="alt-auth bg-white hover:bg-zinc-100" on:click={signInWithGithub}>
        <GithubFill size="24px" />
        <span>Sign in with GitHub</span>
    </button>
    <!--<button class="alt-auth text-white bg-indigo-600 hover:bg-indigo-500" on:click={signInWithDiscord}>
        <DiscordFill size="24px" />
        <span>Sign in with Discord</span>
    </button>
    <button class="alt-auth text-white bg-black hover:bg-zinc-800">
		<span class="under-construction">
			<span class="relative -top-0.5 text-black">Under Construction</span>
		</span>
        <AppleFill size="24px" />
        <span>Sign in with Apple</span>
    </button>
    <button class="alt-auth text-white bg-purple-800 hover:bg-purple-700">
		<span class="under-construction">
			<span class="relative -top-0.5 text-black">Under Construction</span>
		</span>
        <TwitchFill size="24px" />
        <span>Sign in with Twitch</span>
    </button>-->
</div>

<style lang="scss">
    button.alt-auth {
        @apply w-96 overflow-hidden relative flex items-center justify-center p-4 border drop-shadow-md rounded-lg mb-2 last:mb-0 transition transform;
        span {
            @apply ml-2.5;
        }
    }
    span.under-construction {
        @apply absolute font-bold all-small-caps bg-yellow-500 w-[26rem] -translate-y-1/2 top-1/2 -rotate-12 border-dashed border-4 border-red-600;
    }
</style>
