import { get, writable } from "svelte/store";
import type { SvelteComponent } from "svelte";

interface ModalState {
    isOpen: boolean;
    showBackdrop: boolean;
    components: SvelteComponent[];
    currPage: number;
    data: unknown;
}

export const modal = writable<ModalState>({
    isOpen: false,
    showBackdrop: true,
    components: [],
    currPage: 0,
    data: null,
});

export function open(component: SvelteComponent, data = null): void {
    modal.update((state) => ({
        ...state,
        isOpen: true,
        components: [component],
        currPage: 0,
        data,
    }));
}

export function close(): void {
    modal.update((state) => ({
        ...state,
        isOpen: false,
        components: [],
    }));
}

export function nextPage(component: SvelteComponent): void {
    modal.update((state) => {
        const newLength = state.components.push(component);
        state.currPage = newLength - 1;
        return state;
    });
}

export function prevPage(): void {
    modal.update((state) => {
        state.components.pop();
        state.currPage = state.components.length - 1;
        return state;
    });
}

export function getData() {
    return get(modal).data ?? null;
}
