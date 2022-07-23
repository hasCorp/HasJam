<script lang="ts">
    import { createForm } from "felte";
    import { Button } from "../../ui/util"
    import { TextField } from "../../ui/forms";
    import { LoginBoxLine, CloseLine, GithubFill, AppleFill, TwitchFill } from 'svelte-remixicon';
    import { close } from '../../ui/modal';

    const { form, isSubmitting } = createForm({
        onSubmit: async (values) => {
            console.log(values);
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
    <h1 class="text-4xl mb-0">Sign In</h1>
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
            <span class="button-text">Sign In</span>
        </Button>
    </div>
</form>
