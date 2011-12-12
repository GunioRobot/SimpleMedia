{* Purpose of this template: Shows a plain text file *}
<br />
<br />
{assign var='typehtml' value=''}
<iframe src="{$medium.theFileFullPathURL}"{$typehtml} id="sm{$idprefix}doc{$medium.id}" name="smdoc{$medium.id}" width="350" height="200">
   <p>{gt text='Your browser does not support embedded frames unfortunately.'}</p>
</iframe>
