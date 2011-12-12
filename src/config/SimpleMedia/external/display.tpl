{* Purpose of this template: Display one particular file within an external context *}
<div id="medium{$medium.id}" class="smextmed">
{if $displayMode eq 'link'}
    <p class="smextlink">
        <a href="{*modurl modname='SimpleMedia' type='user' func='display' id=$medium.id*}{$item.theFileFullPathURL}" title="{$medium.title|replace:"\"":""}" class="dt{$medium.theFileMeta.extension}">
            {*icon type='display' size='extrasmall' alt=$medium.title style='padding-right: 5px'*}
            {$medium.title|notifyfilters:'simplemedia.filter_hooks.media.filter'}
        </a>
    </p>
{/if}
    {checkpermissionblock component='SimpleMedia::' instance='.*' level='ACCESS_EDIT'}
{if $displayMode eq 'embed'}
    <p class="smexttitle">
        <strong>{$medium.title|notifyfilters:'simplemedia.filter_hooks.media.filter'}</strong>
{/if}
{*            <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='medium' id=$medium.id}" title="{gt text='Edit'}">
                {icon type='edit' size='extrasmall' __alt='Edit'}
            </a>*}
{if $displayMode eq 'embed'}
        {if $medium.theFileMeta.isImage && $modvars.SimpleMedia.useThumbCropper eq true}
            <a href="{modurl modname='SimpleMedia' type='admin' func='editthumb' id=$medium.id thumbnr=$thumbnr returnTo='adminView'}" title="{gt text='Crop thumbnail image'}">
                {img src='cropthumb.png' modname='SimpleMedia' __alt='Crop thumbnail image'}
            </a>
        {/if}
{/if}
{*            <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='medium' astemplate=$medium.id}" title="{gt text='Reuse for new item'}">
                {icon type='saveas' size='extrasmall' __alt='Reuse'}
            </a>*}
    </p>
    {/checkpermissionblock}

    {if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="smextsnippet">
        {getinlinesnippet medium=$medium thumbnr=$thumbnr zoomMode=$zoomMode}
    </div>

    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}
{*
    <p class="smextdesc">
        {if $medium.description ne ''}{$medium.description}<br />{/if}
        {assignedcategorieslist categories=$medium.categories doctrine2=true}
    </p>
*}
{/if}
</div>
