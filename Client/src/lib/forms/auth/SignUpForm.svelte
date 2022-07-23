<script lang="ts">
    import { createForm } from 'felte';
    import { Button } from '../../ui/util';
    import { TextField, Toggle } from '../../ui/forms';
    import { UserAddLine, CloseLine, GithubFill, AppleFill, TwitchFill } from 'svelte-remixicon';
    import { close } from '../../ui/modal';

    const { form, data, isSubmitting } = createForm({
        onSubmit: async (values) => {
            console.log(values);
        },
        validate: (values) => {
            // TODO: perform more validation on form values
            const errors = {
                email: '',
                password: '',
                repeatPassword: '',
                ageCheck: '',
            };

            if (values.email === '' || values.email === null) {
                errors.email = 'You must provide a valid email.';
            }

            if (values.password === '' || values.password === null){
                errors.password = 'You must provide a password.';
            }

            if (values.password !== values.repeatPassword) {
                errors.repeatPassword = 'Passwords must match.';
            }

            if (values.ageCheck === false) {
                errors.ageCheck = 'You must be at least 18 to sign up for this site.';
            }
        },
        initialValues: {
            email: null,
            password: null,
            repeatPassword: null,
            ageCheck: false,
        }
    });
</script>

<div class="flex items-center mb-4">
    <h1 class="text-4xl mb-0">Sign Up</h1>
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
    <TextField
            name="repeatPassword"
            type="password"
            title="Repeat Password"
            placeholder="••••••••••"
    />
    <div class="my-4"></div>
    <Toggle bind:value={$data.ageCheck}>
        I am at least 18 years of age or older.
    </Toggle>
    <div class="mt-4 flex items-center">
        <div class="flex-1"></div>
        <Button kind="primary" type="submit" loading={$isSubmitting}>
            <UserAddLine class="button-icon" />
            <span class="button-text">Sign Up</span>
        </Button>
    </div>
</form>
