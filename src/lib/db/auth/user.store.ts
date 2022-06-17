import { supabase } from '../index';
import { writable } from 'svelte/store';

const userStore = writable(supabase.auth.user());

supabase.auth.onAuthStateChange((event, session) => {
	if (event === 'SIGNED_IN') {
		userStore.set(session ? session.user : null);
	} else if (event === 'SIGNED_OUT') {
		userStore.set(null);
	}
});
