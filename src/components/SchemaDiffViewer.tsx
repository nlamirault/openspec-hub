import React, { useState, useEffect } from 'react';

interface Property {
    description?: string;
    type?: string;
    $ref?: string;
    format?: string;
    items?: any;
    properties?: Record<string, Property>;
    required?: string[];
    enum?: any[];
    [key: string]: any;
}

interface Schema {
    title?: string;
    description?: string;
    properties?: Record<string, Property>;
    required?: string[];
}

type ChangeType = 'added' | 'removed' | 'modified' | 'unchanged';

interface DiffEntry {
    name: string;
    changeType: ChangeType;
    fromProp?: Property;
    toProp?: Property;
    fromRequired: boolean;
    toRequired: boolean;
    modifiedFields?: string[];
}

export interface VersionInfo {
    version: string;
    file: string;
    slug: string;
}

interface Props {
    currentVersion: string;
    versions: VersionInfo[];
}

function sortVersions(versions: VersionInfo[]): VersionInfo[] {
    return [...versions].sort((a, b) => {
        const parse = (v: string) => {
            const alpha = v.match(/^v(\d+)alpha(\d+)$/);
            const beta = v.match(/^v(\d+)beta(\d+)$/);
            const ga = v.match(/^v(\d+)$/);
            if (alpha) return { tier: 0, major: parseInt(alpha[1]), minor: parseInt(alpha[2]) };
            if (beta) return { tier: 1, major: parseInt(beta[1]), minor: parseInt(beta[2]) };
            if (ga) return { tier: 2, major: parseInt(ga[1]), minor: 0 };
            return { tier: -1, major: 0, minor: 0 };
        };
        const pa = parse(a.version);
        const pb = parse(b.version);
        if (pa.tier !== pb.tier) return pa.tier - pb.tier;
        if (pa.major !== pb.major) return pa.major - pb.major;
        return pa.minor - pb.minor;
    });
}

function getModifiedFields(from: Property, to: Property): string[] {
    const fields: string[] = [];
    if (from.type !== to.type) fields.push('type');
    if (from.description !== to.description) fields.push('description');
    if (from.format !== to.format) fields.push('format');
    if (from.$ref !== to.$ref) fields.push('$ref');
    if (JSON.stringify(from.enum) !== JSON.stringify(to.enum)) fields.push('enum');
    return fields;
}

function diffSchemas(fromSchema: Schema | null, toSchema: Schema | null): DiffEntry[] {
    const fromProps = fromSchema?.properties ?? {};
    const toProps = toSchema?.properties ?? {};
    const fromRequired = fromSchema?.required ?? [];
    const toRequired = toSchema?.required ?? [];

    const allKeys = new Set([...Object.keys(fromProps), ...Object.keys(toProps)]);
    const entries: DiffEntry[] = [];

    for (const key of allKeys) {
        const fromProp = fromProps[key];
        const toProp = toProps[key];
        const isFromRequired = fromRequired.includes(key);
        const isToRequired = toRequired.includes(key);

        if (!fromProp) {
            entries.push({ name: key, changeType: 'added', toProp, fromRequired: false, toRequired: isToRequired });
        } else if (!toProp) {
            entries.push({ name: key, changeType: 'removed', fromProp, fromRequired: isFromRequired, toRequired: false });
        } else {
            const modifiedFields = getModifiedFields(fromProp, toProp);
            const requiredChanged = isFromRequired !== isToRequired;
            if (modifiedFields.length > 0 || requiredChanged) {
                entries.push({ name: key, changeType: 'modified', fromProp, toProp, fromRequired: isFromRequired, toRequired: isToRequired, modifiedFields });
            } else {
                entries.push({ name: key, changeType: 'unchanged', fromProp, toProp, fromRequired: isFromRequired, toRequired: isToRequired });
            }
        }
    }

    const order: Record<ChangeType, number> = { added: 0, removed: 1, modified: 2, unchanged: 3 };
    return entries.sort((a, b) => order[a.changeType] - order[b.changeType]);
}

async function loadSchema(file: string): Promise<Schema | null> {
    try {
        const response = await fetch(`/data/schemas/${file}`);
        if (!response.ok) return null;
        const content = await response.text();
        return JSON.parse(content.split('}\n{')[0] + (content.includes('}\n{') ? '}' : ''));
    } catch {
        return null;
    }
}

function DiffRow({ entry }: { entry: DiffEntry }) {
    const { changeType, name, fromProp, toProp, fromRequired, toRequired, modifiedFields } = entry;

    const bgClass = {
        added: 'bg-emerald-50/60 dark:bg-emerald-900/10 border-l-2 border-emerald-400',
        removed: 'bg-red-50/60 dark:bg-red-900/10 border-l-2 border-red-400',
        modified: 'bg-amber-50/60 dark:bg-amber-900/10 border-l-2 border-amber-400',
        unchanged: 'bg-white dark:bg-slate-900 border-l-2 border-transparent',
    }[changeType];

    const indicator = {
        added: <span className="text-[11px] font-black text-emerald-600 dark:text-emerald-400 w-4 flex-shrink-0">+</span>,
        removed: <span className="text-[11px] font-black text-red-500 dark:text-red-400 w-4 flex-shrink-0">−</span>,
        modified: <span className="text-[11px] font-black text-amber-600 dark:text-amber-400 w-4 flex-shrink-0">~</span>,
        unchanged: <span className="text-[11px] font-black text-gray-300 dark:text-slate-600 w-4 flex-shrink-0">&nbsp;</span>,
    }[changeType];

    const prop = toProp ?? fromProp;
    const fromType = fromProp?.type ?? (fromProp?.$ref ? 'object' : undefined);
    const toType = toProp?.type ?? (toProp?.$ref ? 'object' : undefined);
    const typeChanged = modifiedFields?.includes('type');
    const otherModified = modifiedFields?.filter(f => f !== 'type') ?? [];

    return (
        <div className={`flex items-start px-4 py-3 border-b border-gray-100 dark:border-slate-800 last:border-0 ${bgClass}`}>
            <div className="mr-2 mt-0.5">{indicator}</div>
            <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 flex-wrap">
                    <code className="text-blue-700 dark:text-blue-400 font-bold bg-blue-50 dark:bg-blue-900/20 px-1.5 py-0.5 rounded text-xs">
                        {name}
                    </code>

                    {changeType === 'modified' && typeChanged ? (
                        <span className="flex items-center gap-1 text-[10px] font-medium">
                            <span className="text-gray-400 dark:text-slate-500 bg-gray-100 dark:bg-slate-800 px-1 rounded line-through">
                                {fromType ?? '?'}
                            </span>
                            <span className="text-gray-300 dark:text-slate-600">→</span>
                            <span className="text-amber-700 dark:text-amber-300 bg-amber-100 dark:bg-amber-900/30 px-1 rounded">
                                {toType ?? '?'}
                            </span>
                        </span>
                    ) : (
                        prop?.type && (
                            <span className="text-[10px] font-medium text-gray-500 dark:text-slate-400 bg-gray-100 dark:bg-slate-800 px-1 rounded border border-gray-200 dark:border-slate-700">
                                {prop.type}
                            </span>
                        )
                    )}

                    {changeType === 'modified' && fromRequired !== toRequired ? (
                        toRequired
                            ? <span className="text-[9px] font-bold text-emerald-600 dark:text-emerald-400 uppercase">now required</span>
                            : <span className="text-[9px] font-bold text-gray-400 dark:text-slate-500 uppercase line-through">required</span>
                    ) : (
                        (fromRequired || toRequired) && (
                            <span className="text-[9px] font-bold text-red-500 dark:text-red-400 uppercase tracking-tighter">Required</span>
                        )
                    )}

                    {otherModified.length > 0 && (
                        <span className="text-[9px] text-amber-600 dark:text-amber-400 italic">
                            {otherModified.join(', ')} changed
                        </span>
                    )}
                </div>

                {prop?.description && (
                    <p className="text-xs text-gray-400 dark:text-slate-500 mt-1 truncate">
                        {prop.description}
                    </p>
                )}
            </div>
        </div>
    );
}

export default function SchemaDiffViewer({ currentVersion, versions }: Props) {
    const sorted = sortVersions(versions);

    const defaultFrom = sorted[0]?.version ?? '';
    const defaultTo = sorted[sorted.length - 1]?.version ?? '';

    const [fromVersion, setFromVersion] = useState(defaultFrom);
    const [toVersion, setToVersion] = useState(defaultTo);
    const [fromSchema, setFromSchema] = useState<Schema | null>(null);
    const [toSchema, setToSchema] = useState<Schema | null>(null);
    const [loading, setLoading] = useState(false);
    const [showUnchanged, setShowUnchanged] = useState(false);

    const getFile = (version: string) => sorted.find(v => v.version === version)?.file ?? '';

    useEffect(() => {
        if (!fromVersion || !toVersion || fromVersion === toVersion) return;
        setLoading(true);
        setFromSchema(null);
        setToSchema(null);
        Promise.all([loadSchema(getFile(fromVersion)), loadSchema(getFile(toVersion))]).then(([from, to]) => {
            setFromSchema(from);
            setToSchema(to);
            setLoading(false);
        });
    }, [fromVersion, toVersion]);

    if (sorted.length < 2) return null;

    const diff = fromVersion !== toVersion ? diffSchemas(fromSchema, toSchema) : [];
    const stats = {
        added: diff.filter(d => d.changeType === 'added').length,
        removed: diff.filter(d => d.changeType === 'removed').length,
        modified: diff.filter(d => d.changeType === 'modified').length,
        unchanged: diff.filter(d => d.changeType === 'unchanged').length,
    };
    const displayDiff = showUnchanged ? diff : diff.filter(d => d.changeType !== 'unchanged');

    return (
        <div className="mt-12">
            <div className="flex items-center gap-3 mb-6">
                <h2 className="text-xs font-black text-gray-400 dark:text-slate-500 uppercase tracking-[0.2em]">
                    Version Diff
                </h2>
            </div>

            {/* Version selector */}
            <div className="flex items-center gap-3 mb-6 flex-wrap">
                <span className="text-xs text-gray-500 dark:text-slate-400 font-medium">Compare:</span>
                <select
                    value={fromVersion}
                    onChange={e => setFromVersion(e.target.value)}
                    className="text-xs border border-gray-200 dark:border-slate-700 rounded-lg px-3 py-1.5 bg-white dark:bg-slate-900 text-gray-700 dark:text-slate-300 font-mono focus:outline-none focus:ring-2 focus:ring-blue-300 dark:focus:ring-blue-700 cursor-pointer"
                >
                    {sorted.map(v => (
                        <option key={v.version} value={v.version}>{v.version}</option>
                    ))}
                </select>
                <span className="text-gray-400 dark:text-slate-500 font-mono text-sm">→</span>
                <select
                    value={toVersion}
                    onChange={e => setToVersion(e.target.value)}
                    className="text-xs border border-gray-200 dark:border-slate-700 rounded-lg px-3 py-1.5 bg-white dark:bg-slate-900 text-gray-700 dark:text-slate-300 font-mono focus:outline-none focus:ring-2 focus:ring-blue-300 dark:focus:ring-blue-700 cursor-pointer"
                >
                    {sorted.map(v => (
                        <option key={v.version} value={v.version}>{v.version}</option>
                    ))}
                </select>
            </div>

            {fromVersion === toVersion && (
                <div className="p-8 text-center text-gray-400 dark:text-slate-500 text-sm italic border border-dashed border-gray-200 dark:border-slate-700 rounded-xl">
                    Select two different versions to compare.
                </div>
            )}

            {fromVersion !== toVersion && loading && (
                <div className="p-8 text-center text-blue-400 dark:text-blue-500 animate-pulse text-sm">
                    Loading schemas…
                </div>
            )}

            {fromVersion !== toVersion && !loading && fromSchema && toSchema && diff.length === 0 && (
                <div className="p-8 text-center text-gray-400 dark:text-slate-500 text-sm italic border border-dashed border-gray-200 dark:border-slate-700 rounded-xl">
                    No differences found between these versions.
                </div>
            )}

            {fromVersion !== toVersion && !loading && diff.length > 0 && (
                <>
                    {/* Stats badges */}
                    <div className="flex items-center gap-2 mb-4 flex-wrap">
                        {stats.added > 0 && (
                            <span className="text-[11px] font-bold text-emerald-600 dark:text-emerald-400 bg-emerald-50 dark:bg-emerald-900/20 px-2 py-1 rounded-full border border-emerald-200 dark:border-emerald-800">
                                +{stats.added} added
                            </span>
                        )}
                        {stats.removed > 0 && (
                            <span className="text-[11px] font-bold text-red-500 dark:text-red-400 bg-red-50 dark:bg-red-900/20 px-2 py-1 rounded-full border border-red-200 dark:border-red-800">
                                −{stats.removed} removed
                            </span>
                        )}
                        {stats.modified > 0 && (
                            <span className="text-[11px] font-bold text-amber-600 dark:text-amber-400 bg-amber-50 dark:bg-amber-900/20 px-2 py-1 rounded-full border border-amber-200 dark:border-amber-800">
                                ~{stats.modified} modified
                            </span>
                        )}
                        {stats.unchanged > 0 && (
                            <button
                                onClick={() => setShowUnchanged(v => !v)}
                                className="text-[11px] font-bold text-gray-400 dark:text-slate-500 bg-gray-50 dark:bg-slate-800 px-2 py-1 rounded-full border border-gray-200 dark:border-slate-700 hover:border-gray-300 dark:hover:border-slate-600 transition-colors"
                            >
                                {showUnchanged ? '▾' : '▸'} {stats.unchanged} unchanged
                            </button>
                        )}
                    </div>

                    {/* Diff rows */}
                    <div className="border border-gray-200 dark:border-slate-700 rounded-xl overflow-hidden shadow-sm">
                        {displayDiff.map(entry => (
                            <DiffRow key={entry.name} entry={entry} />
                        ))}
                    </div>
                </>
            )}
        </div>
    );
}
