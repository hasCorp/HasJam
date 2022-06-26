import { supabase } from '../supabase';
import { writable } from 'svelte/store';

export const userStore = writable(supabase.auth.user());

supabase.auth.onAuthStateChange((event, session) => {
	if (event === 'SIGNED_IN') {
		userStore.set(session ? session.user : null);
	} else if (event === 'SIGNED_OUT') {
		userStore.set(null);
	}
});

export async function signUpWithEmail(email: string, password: string) {
	const { user, error } = await supabase.auth.signUp({
		email,
		password,
	});

	// TODO: Replace console logs with error alerts clientside
	if (error) {
		console.log(error);
	} else {
		userStore.set(user);
	}
}

export async function signInWithEmail(email: string, password: string) {
	const { user, error } = await supabase.auth.signIn({
		email,
		password,
	});

	// TODO: Replace console logs with error alerts clientside
	if (error) {
		console.log(error);
	} else {
		userStore.set(user);
	}
}

export async function signInWithDiscord() {
	const { user, error } = await supabase.auth.signIn({
		provider: 'discord',
	});

	// TODO: Replace console logs with error alerts clientside
	if (error) {
		console.log(error);
	} else {
		userStore.set(user);
	}
}

export async function signInWithApple() {
	const { user, error } = await supabase.auth.signIn({
		provider: 'apple',
	});

	// TODO: Replace console logs with error alerts clientside
	if (error) {
		console.log(error);
	} else {
		userStore.set(user);
	}
}

export async function signInWithGithub() {
	const { user, error } = await supabase.auth.signIn({
		provider: 'github',
	});

	// TODO: Replace console logs with error alerts clientside
	if (error) {
		console.log(error);
	} else {
		userStore.set(user);
	}
}

export async function signInWithTwitch() {
	const { user, error } = await supabase.auth.signIn({
		provider: 'twitch',
	});

	// TODO: Replace console logs with error alerts clientside
	if (error) {
		console.log(error);
	} else {
		userStore.set(user);
	}
}

export async function signOut() {
	const { error } = await supabase.auth.signOut();

	// TODO: Replace console logs with error alerts clientside
	if (error) {
		console.log(error);
	}
}
