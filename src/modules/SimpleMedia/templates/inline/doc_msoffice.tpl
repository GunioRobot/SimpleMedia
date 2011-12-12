{* Purpose of this template: Shows a word, excel or powerpoint file *}
{*if $medium.theFileMeta.extension eq 'doc' || $medium.theFileMeta.extension eq 'docx'*}
{if $medium.theFileMeta.extension eq 'doc'}
{*    Download your word document <a href="{$medium.theFileFullPathURL}">here</a>.<br /> *}
    {assign var='typehtml' value=' type="application/msword"'}
{*elseif $file.extension eq 'xls' || $file.extension eq 'xlsx'*}
{elseif $file.extension eq 'xls'}
{*
    Download your excel sheet <a href="{$medium.theFileFullPathURL}">here</a>.<br />

    http://mysite.verizon.net/vzep00rh/excel_php.html
    http://www.adp-gmbh.ch/win/misc/ie/owc/chart.html
*}
    {assign var='typehtml' value=' type="application/msexcel"'}
{*elseif $file.extension eq 'ppt' || $file.extension eq 'pptx'*}
{elseif $file.extension eq 'ppt'}
{*    Download your powerpoint presentation <a href="{$medium.theFileFullPathURL}">here</a>.<br /> *}
{/if}
{*  application/rtf        rtf  *}
{*
<iframe src="{$medium.theFileFullPathURL}"{$typehtml} id="sm{$idprefix}doc{$medium.id}" name="smdoc{$medium.id}" width="350" height="200">
   <p>{gt text='Your browser does not support embedded frames unfortunately.'}</p>
</iframe>
*}
<a href="{$medium.theFileFullPathURL}">{gt text='Download'}</a> ({$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false})