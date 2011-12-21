{* Purpose of this template: Display image gallery *}
{pageaddvar name='javascript' value='zikula.imageviewer'}
<p class="smgallery">
{foreach item='item' from=$items}
{if $item.theFileMeta.isImage}
    <a href="{$item.theFileFullPathURL}" title="{$item.title|replace:"\"":""}{if $item.description} - {$item.description|safetext|replace:"\"":""}{/if}" rel="imageviewer[medium]">
        <img src="{$item.theFile|simplemediaImageThumb:$item.theFileFullPath:60:60}" width="60" height="60" alt="{$item.title|replace:"\"":""}" />
    </a>
{*getinlinesnippet medium=$item thumbnr=$thumbnr*}
{*<a href="{modurl modname='SimpleMedia' type='user' func='display' ot=$objectType id=$item.id}">{gt text='Read more'}</a>*}
{/if}
{/foreach}
&nbsp;</p>
