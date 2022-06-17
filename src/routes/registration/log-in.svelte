<script lang="ts">
    import { createForm } from "felte";
    import { Container, Button } from "../../lib/ui/util";
    import { TextField, RadioButton } from "../../lib/ui/forms";
    import {LoginBoxLine} from "svelte-remixicon";

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

<div class="w-11/12 mx-auto max-w-xl">
    <Container>
        <form use:form>
            <h1 class="text-4xl">Log In</h1>
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
            <RadioButton
                bind:value={$data.rememberMe}
            >
                Remember Me
            </RadioButton>
            <div class="mt-4 flex items-center">
                <div class="flex-1"></div>
                <Button kind="primary">
                    <LoginBoxLine class="button-icon" />
                    <span class="button-text">Log In</span>
                </Button>
            </div>
        </form>
    </Container>
</div>
