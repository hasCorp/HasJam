<script lang="ts">
    import { createForm } from "felte";
    import { Container, Button } from "../../ui/util"
    import { TextField, Toggle } from "../../ui/forms";
    import { LoginBoxLine, CloseLine } from "svelte-remixicon";
    import { close } from "../../ui/modal";

    const { form, data } = createForm({
        onSubmit: (values) => {
            console.log(values);
        },
        initialValues: {
            email: null,
            password: null,
            rememberMe: false,
        }
    })
</script>

<Container>
    <form use:form>
        <div class="flex items-center mb-4">
            <h1 class="text-4xl mb-0">Log In</h1>
            <div class="flex-1"></div>
            <Button on:click={close}>
                <CloseLine class="button-icon no-text" />
            </Button>
        </div>
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
        <div class="my-4"></div>
        <Toggle
            bind:value={$data.rememberMe}
        >
            Remember Me
        </Toggle>
        <div class="mt-4 flex items-center">
            <div class="flex-1"></div>
            <Button kind="primary">
                <LoginBoxLine class="button-icon" />
                <span class="button-text">Log In</span>
            </Button>
        </div>
    </form>
</Container>
