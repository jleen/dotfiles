" Vim syntax file
" Language:	C
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 May 17

"syn keyword cStatement         break nextgroup=cUserLabel skipwhite
"syn keyword csKeyword           event const out ref is fixed
"syn keyword csStatement         default
"syn keyword csType              Boolean Byte Char Decimal Double Enum Guid
"syn keyword csType              Int16 Int32 Int64 IntPtr SByte Single UInt16
"syn keyword csType              UInt32 Uint64 UIntPtr Void
"syn keyword csType              object

"syn keyword csStatement         sizeof typeof

syn keyword csharpTodo		contained BUGBUG


"if exists("cs_highlight_lang_classes")
"  syn keyword csSystemClass IAsyncResult ICloneable IComparable IConvertible
"  syn keyword csSystemClass ICustomFormatter IDisposable IFormatProvider
"  syn keyword csSystemClass IFormattable IServiceProvider
"
"attributes
"  syn keyword csSystemClass Attribute AttributeUsage CLSCompliant
"  syn keyword csSystemClass ContextStatic Flags LoaderOptimization
"  syn keyword csSystemClass MTAThread NonSerialized Obsolete ParamArray
"  syn keyword csSystemClass Serializable STAThread 
"
"  syn keyword csSystemClass BitConverter Buffer Console Convert AsyncCallback
"  syn keyword csSystemClass EventHandler UnhandledExceptionEventArgs
"  syn keyword csSystemClass GC Math RAndom StringEnumerator TimeZone 
"  syn keyword csSystemClass UriBuilder ArgIterator UriHostNameType TypeCode
"  syn keyword csSystemClass UriPartial TimeSpan Version Type
"
"Exceptions
"  syn keyword csSystemClass Exception ApplicationException SystemException
"  syn keyword csSystemClass ArgumentException ArgumentNullException 
"  syn keyword csSystemClass ArgumentOutOfRangeException ArithmeticException
"  syn keyword csSystemClass DivideByZeroException OverflowException 
"  syn keyword csSystemClass NonFiniteNumberException ArrayTypeMismatchException
"  syn keyword csSystemClass CoreException ExecutionEngineException 
"  syn keyword csSystemClass IndexOutOfRangeException FormatException
"  syn keyword csSystemClass InvalidCastException InvalidOperationException
"  syn keyword csSystemClass MemberAccessException FieldAccessException
"  syn keyword csSystemClass MethodAccessException MissingMemberException
"  syn keyword csSystemClass MissingFieldException MissingMethodException
"  syn keyword csSystemClass NotImplementedException NotSupportedException
"  syn keyword csSystemClass PlatformNotSupportedException SocketException
"  syn keyword csSystemClass NullReferenceException OutOfMemoryException
"  syn keyword csSystemClass RankException TypeLoadException UriFormatException
"
"  syn keyword csSystemObject Equals Finalize GetType HashCode ToString
"  syn keyword csDebugObject Debug BCLDebug Assert assert WriteLine
"endif

"bugbug
"I should make it (<access control><modifier>*)? <return type> make the
"preamble optional, but require a modifier if you use "new".
"
"Destructors don't have access modifiers, so this doesn't work
"
"Gray out the args to an exception?
"
"Figure out why the <include> tag doesn't work.
syn region csFunctionDef start=+^\s\+\(\(public\|protected\|private\|internal\|static\|abstract\|extern\|virtual\|override\|sealed\)\s\+\)\+\(\(\(void\|boolean\|byte\|sbyte\|char\|short\|ushort\|int\|uint\|float\|long\|ulong\|double\|decimal\)\|\([A-Za-z_][A-Za-z0-9$\.]*\)\)\(\s*\[\s*\]\s*\)*\s\+\)\?\(\~\?[A-Za-z_][A-Za-z0-9_$]*\)\s*(+ end=+)+ contains=csComment
"contains=csKeyword,csType,csSystemClass,csComment
hi def link csharpNumber        Number
syn region  csString		start=+"+ end=+"+ end=+$+ contains=csSpecialChar,csSpecialError,@Spell
hi def link csString		String
syn match csharpOperator        "!"
syn match csharpOperator        "@"


"syn region csFunctionDef start=+^\s\+\(\(public\|protected\|private\|static\|abstract\|extern\|virtual\|new\|override\)\s\+\)\+\(\(\(void\|boolean\|byte\|sbyte\|char\|short\|ushort\|int\|uint\|float\|long\|ulong\|double\|decimal\)\|\([A-Za-z_][A-Za-z0-9$\.]*\)\)\(\s*\[\s*\]\s*\)\*\s\*\)\?\([A-Za-z_][A-Za-z0-9_$]*\)\s*(+ end=+)+ contains=csKeyword,csType,csSystemClass,csComment,@cOperator

"if exists("cs_highlight_operators")
"        :runtime! syntax/c-op.vim
"endif

" vim: ts=8
