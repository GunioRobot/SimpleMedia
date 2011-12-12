{* Purpose of this template: Shows an image inline *}
{if !isset($zoomMode) || $zoomMode ne 'nozoom'}
{pageaddvar name='javascript' value='zikula.ui'}
{pageaddvar name='javascript' value='zikula.imageviewer'}
<a href="{$medium.theFileFullPathURL}" title="{$medium.title|replace:"\"":""}"{if $externalPreview || $thumbnr ne 'original'} rel="imageviewer[medium]"{/if}>
{/if}
{if $externalPreview || $thumbnr ne 'original'}
    {assign var='thumbSizes' value=$modvars.SimpleMedia.thumbDimensions}
    {assign var='thumbIndex' value=$thumbnr-1}
    {assign var='thumbSize' value=$thumbSizes[$thumbIndex]}
    {assign var='thumbWidth' value=$thumbSize.width}
    {assign var='thumbHeight' value=$thumbSize.height}
    <img id="sm{$idprefix}img{$medium.id}" src="{$medium.theFile|simplemediaImageThumb:$medium.theFileFullPath:$thumbWidth:$thumbHeight}" width="{$thumbWidth}" height="{$thumbHeight}" alt="{$medium.title|replace:"\"":""}" />
{elseif $thumbnr eq 'original'}
    <img id="sm{$idprefix}img{$medium.id}" src="{$medium.theFileFullPath}" alt="{$medium.title|replace:"\"":""}" />
{/if}
{if !isset($zoomMode) || $zoomMode ne 'nozoom'}
</a>
{/if}
