import { get, writable } from "svelte/store";
import type { SvelteComponent } from "svelte";

interface ModalState {
    isOpen: boolean;
    showBackdrop: boolean;
    component: SvelteComponent | null;
    data: unknown;
}

export const modal = writable<ModalState>({
    isOpen: false,
    showBackdrop: true,
    component: null,
    data: null,
});

export function open(component: SvelteComponent, data = null): void {
    modal.update((state) => ({
        ...state,
        isOpen: true,
        component,
        data,
    }));
}

export function close(): void {
    modal.update((state) => ({
        ...state,
        isOpen: false,
        component: null,
    }));
}

export function getData() {
    return get(modal).data ?? null;
}
