// DRF error payloads, flattened for display. The shape varies by field: a plain field gives
// {"name": ["This field is required."]}, but a ListField gives per-index errors nested a level
// deeper — {"factions": {"0": ["This field may not be blank."]}} — so anything that isn't a
// string gets stringified rather than rendered as "[object Object]".

/**
 * Every error message in `errors`, as "field: message" lines, minus the fields the form already
 * shows inline. Without this a 400 on an unhandled field renders nothing and the form looks like
 * it silently did nothing.
 */
export function flattenErrors(errors: Record<string, unknown>, skip: string[] = []): string[] {
    return Object.entries(errors)
        .filter(([field]) => !skip.includes(field))
        .flatMap(([field, val]) => {
            const list = Array.isArray(val) ? val : [val];
            return list.map((m) => `${field}: ${typeof m === 'string' ? m : JSON.stringify(m)}`);
        });
}
