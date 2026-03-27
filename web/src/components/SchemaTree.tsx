import React, { useState, useEffect } from 'react';
import { ChevronRight, ChevronDown, ExternalLink } from 'lucide-react';

interface Property {
  description?: string;
  type?: string;
  $ref?: string;
  format?: string;
  items?: any;
  required?: boolean;
}

interface Schema {
  title?: string;
  description?: string;
  properties?: Record<string, Property>;
  required?: string[];
}

interface Props {
  initialSchema: Schema;
  titles: Record<string, string>;
}

const PropertyItem = ({ name, prop, isRequired, titles, depth = 0 }: { 
    name: string; 
    prop: Property; 
    isRequired: boolean; 
    titles: Record<string, string>;
    depth?: number;
}) => {
    const [isOpen, setIsOpen] = useState(false);
    const [nestedSchema, setNestedSchema] = useState<Schema | null>(null);
    const [loading, setLoading] = useState(false);

    const getRefTitle = (ref: string) => {
        if (!ref) return null;
        // Handle #/definitions/title or just title
        return ref.split('/').pop() || null;
    };

    const refTitle = prop.$ref ? getRefTitle(prop.$ref) : null;
    const slug = refTitle ? titles[refTitle] : null;
    
    // It's expandable if it has a ref we can resolve OR if it already has nested properties
    const isExpandable = !!slug || (!!prop.properties && Object.keys(prop.properties).length > 0);

    const toggleOpen = async (e: React.MouseEvent) => {
        e.stopPropagation();
        if (!isExpandable) return;
        
        if (!isOpen && !nestedSchema) {
            if (slug) {
                setLoading(true);
                try {
                    const response = await fetch(`/data/schemas/${slug}`);
                    if (!response.ok) {
                        throw new Error(`Failed to fetch: ${response.statusText}`);
                    }
                    const content = await response.text();
                    const data = JSON.parse(content.split('}\n{')[0] + (content.includes('}\n{') ? '}' : ''));
                    setNestedSchema(data);
                } catch (e) {
                    console.error("Failed to fetch nested schema", e);
                } finally {
                    setLoading(false);
                }
            } else if (prop.properties) {
                // If it already has properties (inline definition)
                setNestedSchema({ properties: prop.properties, required: prop.required as any });
            }
        }
        setIsOpen(!isOpen);
    };

    return (
        <div className={`border-l border-gray-100 pl-${depth > 0 ? '4' : '0'}`}>
            <div 
                className={`flex items-start p-4 hover:bg-gray-50 transition-colors group ${isExpandable ? 'cursor-pointer' : ''}`}
                onClick={toggleOpen}
            >
                <div className="mr-2 mt-1">
                    {isExpandable ? (
                        isOpen ? <ChevronDown size={14} className="text-blue-500" /> : <ChevronRight size={14} className="text-gray-400 group-hover:text-blue-400" />
                    ) : (
                        <div className="w-3" />
                    )}
                </div>
                
                <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1">
                        <code className="text-blue-700 font-bold bg-blue-50 px-1.5 py-0.5 rounded text-xs">{name}</code>
                        <span className="text-[10px] font-medium text-gray-500 bg-gray-100 px-1 rounded border border-gray-200">
                            {prop.type || (prop.$ref ? 'object' : 'string')}
                        </span>
                        {isRequired && (
                            <span className="text-[9px] font-bold text-red-500 uppercase tracking-tighter">Required</span>
                        )}
                        {slug && (
                            <a 
                                href={`/schemas/${slug}`} 
                                onClick={(e) => e.stopPropagation()}
                                className="opacity-0 group-hover:opacity-100 text-gray-400 hover:text-blue-500"
                                title="Go to resource page"
                            >
                                <ExternalLink size={12} />
                            </a>
                        )}
                    </div>
                    
                    {!isOpen && prop.description && (
                        <div className="text-xs text-gray-500 line-clamp-1 group-hover:line-clamp-none transition-all">
                            {prop.description}
                        </div>
                    )}

                    {isOpen && prop.description && (
                        <div className="text-xs text-gray-600 bg-blue-50/30 p-2 rounded mt-2 border-l-2 border-blue-200 mb-3 whitespace-pre-wrap">
                            {prop.description}
                        </div>
                    )}

                    {isOpen && nestedSchema && (
                        <div className="mt-4 border-t border-gray-100 pt-2">
                            {nestedSchema.properties ? Object.entries(nestedSchema.properties).map(([n, p]) => (
                                <PropertyItem 
                                    key={n} 
                                    name={n} 
                                    prop={p} 
                                    isRequired={nestedSchema.required?.includes(n) || false} 
                                    titles={titles}
                                    depth={depth + 1}
                                />
                            )) : <div className="p-4 text-xs text-gray-400 italic">No properties</div>}
                        </div>
                    )}

                    {isOpen && loading && <div className="text-xs text-blue-400 animate-pulse p-4">Loading definition...</div>}
                </div>
            </div>
        </div>
    );
};

export default function SchemaTree({ initialSchema, titles }: Props) {
    if (!initialSchema.properties) {
        return <div className="p-8 text-center text-gray-500 italic">No properties defined.</div>;
    }

    return (
        <div className="border border-gray-200 rounded-xl overflow-hidden shadow-sm bg-white">
            {Object.entries(initialSchema.properties).map(([name, prop]) => (
                <PropertyItem 
                    key={name} 
                    name={name} 
                    prop={prop} 
                    isRequired={initialSchema.required?.includes(name) || false} 
                    titles={titles}
                />
            ))}
        </div>
    );
}
