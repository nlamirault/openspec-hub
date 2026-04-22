import React from 'react';

interface Property {
  description?: string;
  type?: string | string[];
  $ref?: string;
  format?: string;
  items?: any;
  properties?: Record<string, Property>;
  required?: string[] | boolean;
  default?: any;
}

interface Schema {
  title?: string;
  description?: string;
  properties?: Record<string, Property>;
  required?: string[];
}

interface TableRow {
  path: string;
  depth: number;
  type: string;
  required: boolean;
  default?: any;
  description?: string;
}

interface Props {
  initialSchema: Schema;
}

function getType(prop: Property): string {
  if (prop.type) {
    if (Array.isArray(prop.type)) return prop.type.join(' | ');
    return prop.type;
  }
  if (prop.$ref) {
    return prop.$ref.split('/').pop() || 'object';
  }
  return 'string';
}

function flattenSchema(
  properties: Record<string, Property>,
  required: string[] | undefined,
  prefix: string,
  depth: number,
  rows: TableRow[]
): void {
  for (const [name, prop] of Object.entries(properties)) {
    const path = prefix ? `${prefix}.${name}` : name;
    const isRequired = Array.isArray(required) ? required.includes(name) : false;

    // Determine display type; arrays of objects get [] suffix
    let type = getType(prop);
    if (prop.type === 'array' && prop.items) {
      const itemType = prop.items.type || (prop.items.$ref ? prop.items.$ref.split('/').pop() : 'object');
      type = `${itemType}[]`;
    }

    rows.push({
      path,
      depth,
      type,
      required: isRequired,
      default: prop.default,
      description: prop.description,
    });

    // Recurse into inline object properties
    if (prop.properties && Object.keys(prop.properties).length > 0) {
      flattenSchema(
        prop.properties,
        Array.isArray(prop.required) ? prop.required : undefined,
        path,
        depth + 1,
        rows
      );
    }

    // Recurse into array items that have properties
    if (prop.type === 'array' && prop.items?.properties) {
      const itemsRequired = Array.isArray(prop.items.required) ? prop.items.required : undefined;
      flattenSchema(prop.items.properties, itemsRequired, `${path}[]`, depth + 1, rows);
    }
  }
}

export default function SchemaTable({ initialSchema }: Props) {
  if (!initialSchema.properties) {
    return <div className="p-8 text-center text-gray-500 italic">No properties defined.</div>;
  }

  const rows: TableRow[] = [];
  flattenSchema(initialSchema.properties, initialSchema.required, '', 0, rows);

  return (
    <div className="border border-gray-200 dark:border-slate-700 rounded-xl overflow-hidden shadow-sm bg-white dark:bg-slate-900">
      <div className="overflow-x-auto">
        <table className="w-full text-xs">
          <thead>
            <tr className="bg-gray-50 dark:bg-slate-800 border-b border-gray-200 dark:border-slate-700">
              <th className="text-left px-4 py-3 font-black text-gray-400 dark:text-slate-500 uppercase tracking-[0.15em] w-2/5">Field</th>
              <th className="text-left px-4 py-3 font-black text-gray-400 dark:text-slate-500 uppercase tracking-[0.15em] w-24">Type</th>
              <th className="text-left px-4 py-3 font-black text-gray-400 dark:text-slate-500 uppercase tracking-[0.15em] w-20">Required</th>
              <th className="text-left px-4 py-3 font-black text-gray-400 dark:text-slate-500 uppercase tracking-[0.15em] w-24">Default</th>
              <th className="text-left px-4 py-3 font-black text-gray-400 dark:text-slate-500 uppercase tracking-[0.15em]">Description</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((row, i) => (
              <tr
                key={row.path}
                className={`border-b border-gray-100 dark:border-slate-800 hover:bg-blue-50/40 dark:hover:bg-slate-800/60 transition-colors ${
                  row.required ? 'bg-red-50/20 dark:bg-red-900/10' : ''
                } ${i === rows.length - 1 ? 'border-b-0' : ''}`}
              >
                <td className="px-4 py-3 font-mono">
                  <span style={{ paddingLeft: `${row.depth * 16}px` }} className="inline-block">
                    <code className={`px-1.5 py-0.5 rounded text-xs ${
                      row.required
                        ? 'text-blue-700 dark:text-blue-300 font-bold bg-blue-50 dark:bg-blue-900/30'
                        : 'text-blue-600 dark:text-blue-400 bg-blue-50/70 dark:bg-blue-900/20'
                    }`}>
                      {row.path}
                    </code>
                  </span>
                </td>
                <td className="px-4 py-3">
                  <span className="text-[10px] font-medium text-gray-500 dark:text-slate-400 bg-gray-100 dark:bg-slate-700 px-1.5 py-0.5 rounded border border-gray-200 dark:border-slate-600 whitespace-nowrap">
                    {row.type}
                  </span>
                </td>
                <td className="px-4 py-3">
                  {row.required && (
                    <span className="text-[9px] font-bold text-red-500 dark:text-red-400 uppercase tracking-tighter">
                      Required
                    </span>
                  )}
                </td>
                <td className="px-4 py-3">
                  {row.default !== undefined && (
                    <code className="text-[10px] text-emerald-700 dark:text-emerald-400 bg-emerald-50 dark:bg-emerald-900/20 px-1.5 py-0.5 rounded">
                      {JSON.stringify(row.default)}
                    </code>
                  )}
                </td>
                <td className="px-4 py-3 text-gray-500 dark:text-slate-400 leading-relaxed">
                  {row.description && (
                    <span
                      className="block max-w-prose truncate"
                      title={row.description}
                    >
                      {row.description}
                    </span>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <div className="px-4 py-2 bg-gray-50 dark:bg-slate-800 border-t border-gray-100 dark:border-slate-700 text-[10px] text-gray-400 dark:text-slate-500 font-bold">
        {rows.length} field{rows.length !== 1 ? 's' : ''}
      </div>
    </div>
  );
}
