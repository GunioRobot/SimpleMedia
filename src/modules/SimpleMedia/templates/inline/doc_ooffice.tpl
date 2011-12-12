{* Purpose of this template: Shows open office files (writer, calc, ...) *}
{if $medium.theFileMeta.extension eq 'odt'}
{*    Download your open writer document <a href="{$medium.theFileFullPathURL}">here</a>.<br /> *}
{elseif $medium.theFileMeta.extension eq 'ods'}
{*    Download your open calc sheet <a href="{$medium.theFileFullPathURL}">here</a>.<br /> *}
{elseif $medium.theFileMeta.extension eq 'odp'}
{*    Download your open impress presentation <a href="{$medium.theFileFullPathURL}">here</a>.<br /> *}
{/if}
{*
{assign var='typehtml' value=''}
<iframe src="{$medium.theFileFullPathURL}"{$typehtml} id="sm{$idprefix}doc{$medium.id}" name="smdoc{$medium.id}" width="350" height="200">
   <p>{gt text='Your browser does not support embedded frames unfortunately.'}</p>
</iframe>
*}
<a href="{$medium.theFileFullPathURL}">{gt text='Download'}</a> ({$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false})