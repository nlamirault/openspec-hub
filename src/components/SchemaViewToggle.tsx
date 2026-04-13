import React, { useState, useEffect } from 'react';
import SchemaTree from './SchemaTree';
import SchemaTable from './SchemaTable';

type ViewMode = 'tree' | 'table';
const STORAGE_KEY = 'openspec-schema-view';

interface Schema {
  title?: string;
  description?: string;
  properties?: Record<string, any>;
  required?: string[];
}

interface Props {
  initialSchema: Schema;
  titles: Record<string, string>;
  schemaJson?: string;
  schemaFile?: string;
}

type CopyState = 'idle' | 'copied' | 'failed';

export default function SchemaViewToggle({ initialSchema, titles, schemaJson = '', schemaFile = '' }: Props) {
  const [view, setView] = useState<ViewMode>('tree');
  const [yamlCopy, setYamlCopy] = useState<CopyState>('idle');
  const [jsonCopy, setJsonCopy] = useState<CopyState>('idle');

  useEffect(() => {
    try {
      const saved = localStorage.getItem(STORAGE_KEY) as ViewMode | null;
      if (saved === 'tree' || saved === 'table') {
        setView(saved);
      }
    } catch {
      // localStorage unavailable (e.g. private browsing restrictions)
    }
  }, []);

  const switchView = (next: ViewMode) => {
    setView(next);
    try {
      localStorage.setItem(STORAGE_KEY, next);
    } catch {
      // ignore write failures
    }
  };

  const copyYamlDirective = async () => {
    const directive = `# yaml-language-server: $schema=https://raw.githubusercontent.com/nlamirault/openspec-hub/main/schemas/${schemaFile}`;
    try {
      await navigator.clipboard.writeText(directive);
      setYamlCopy('copied');
    } catch {
      setYamlCopy('failed');
    }
    setTimeout(() => setYamlCopy('idle'), 2000);
  };

  const copyJson = async () => {
    try {
      await navigator.clipboard.writeText(schemaJson);
      setJsonCopy('copied');
    } catch {
      setJsonCopy('failed');
    }
    setTimeout(() => setJsonCopy('idle'), 2000);
  };

  const btnBase =
    'flex items-center gap-1.5 text-[10px] px-3 py-1.5 rounded-full font-bold border transition-colors';
  const activeBtn =
    'bg-blue-600 text-white border-blue-600 dark:bg-blue-500 dark:border-blue-500';
  const inactiveBtn =
    'bg-white dark:bg-slate-900 text-gray-500 dark:text-slate-400 border-gray-200 dark:border-slate-700 hover:border-blue-300 dark:hover:border-blue-600 hover:text-blue-600 dark:hover:text-blue-400';

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-xs font-black text-gray-400 dark:text-slate-500 uppercase tracking-[0.2em]">
          Resource Structure
        </h2>
        <div className="flex items-center gap-2">
          <button
            onClick={copyYamlDirective}
            className={`text-[10px] bg-white dark:bg-slate-900 px-3 py-1.5 rounded-full font-bold border transition-colors flex items-center gap-1.5 ${
              yamlCopy === 'copied'
                ? 'border-purple-300 text-purple-600 dark:border-purple-600 dark:text-purple-400'
                : 'text-gray-500 dark:text-slate-400 border-gray-200 dark:border-slate-700 hover:border-purple-300 dark:hover:border-purple-600 hover:text-purple-600 dark:hover:text-purple-400'
            }`}
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
              <polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/>
            </svg>
            {yamlCopy === 'copied' ? 'Copied!' : yamlCopy === 'failed' ? 'Failed' : 'Copy YAML directive'}
          </button>
          <button
            onClick={copyJson}
            className={`text-[10px] bg-white dark:bg-slate-900 px-3 py-1.5 rounded-full font-bold border transition-colors flex items-center gap-1.5 ${
              jsonCopy === 'copied'
                ? 'border-green-300 text-green-600 dark:border-green-600 dark:text-green-400'
                : 'text-gray-500 dark:text-slate-400 border-gray-200 dark:border-slate-700 hover:border-blue-300 dark:hover:border-blue-600 hover:text-blue-600 dark:hover:text-blue-400'
            }`}
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
              <rect width="14" height="14" x="8" y="8" rx="2" ry="2"/><path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"/>
            </svg>
            {jsonCopy === 'copied' ? 'Copied!' : jsonCopy === 'failed' ? 'Failed' : 'Copy JSON'}
          </button>

          {/* View toggle */}
          <div className="flex items-center gap-1 bg-gray-100 dark:bg-slate-800 rounded-full p-0.5 border border-gray-200 dark:border-slate-700">
            <button
              onClick={() => switchView('tree')}
              className={`${btnBase} ${view === 'tree' ? activeBtn : inactiveBtn}`}
              aria-pressed={view === 'tree'}
              title="Tree view"
            >
              <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                <path d="M21 12V7H5a2 2 0 0 1 0-4h14v4"/><path d="M3 5v14"/><path d="M21 19v-4H9a2 2 0 0 0 0 4h12v-4"/>
              </svg>
              Tree
            </button>
            <button
              onClick={() => switchView('table')}
              className={`${btnBase} ${view === 'table' ? activeBtn : inactiveBtn}`}
              aria-pressed={view === 'table'}
              title="Table view"
            >
              <svg xmlns="http://www.w3.org/2000/svg" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                <rect width="18" height="18" x="3" y="3" rx="2"/><path d="M3 9h18M3 15h18M9 3v18"/>
              </svg>
              Table
            </button>
          </div>
        </div>
      </div>

      {view === 'tree' ? (
        <SchemaTree initialSchema={initialSchema} titles={titles} />
      ) : (
        <SchemaTable initialSchema={initialSchema} />
      )}
    </div>
  );
}
