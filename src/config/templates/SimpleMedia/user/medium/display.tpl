{* purpose of this template: media display view in user area *}
{include file='user/header.tpl'}
<div class="simplemedia-medium simplemedia-display">
{gt text='Medium' assign='templateTitle'}
{assign var='templateTitle' value=$medium.title|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-frontendcontainer">
    <h2>{$templateTitle|notifyfilters:'simplemedia.filter_hooks.media.filter'}</h2>


<dl id="SimpleMedia_body">
    <dt>{gt text='The file'}</dt>
    <dd>{getinlinesnippet medium=$medium}</dd>
    <dt>{gt text='Description'}</dt>
    <dd>{$medium.description}</dd>
</dl>
    {include file='user/include_attributes_display.tpl' obj=$medium}
    {include file='user/include_categories_display.tpl' obj=$medium}
    {include file='user/include_standardfields_display.tpl' obj=$medium}
    {include file='user/include_metadata_display.tpl' obj=$medium}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{*if count($medium._actions) gt 0}
    <p>{strip}
    {foreach item='option' from=$medium._actions}
        <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
            {$option.linkText|safetext}
        </a>
    {/foreach}
    {/strip}</p>
{/if*}
<p>
    {checkpermissionblock component='SimpleMedia::' instance='.*' level='ACCESS_EDIT'}

        <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='medium' id=$medium.id returnTo='userDisplay'}" title="{gt text='Edit'}" class="z-icon-es-edit">
            {gt text='Edit'}
        </a>
{*        <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='medium' astemplate=$medium.id}" title="{gt text='Reuse for new item'}" class="z-icon-es-saveas">
            {gt text='Reuse'}
        </a>*}
    {if $medium.theFileMeta.isImage && $modvars.SimpleMedia.useThumbCropper eq true}
        {assign var='thumbnr' value=$modvars.SimpleMedia.defaultThumbNumber}
        {if isset($smarty.get.thumbnr) && $smarty.get.thumbnr ne 0}
            {assign var='thumbnr' value=$smarty.get.thumbnr}
        {/if}
        <a href="{modurl modname='SimpleMedia' type='admin' func='editthumb' id=$medium.id thumbnr=$thumbnr returnTo='userDisplay'}" title="{gt text='Crop thumbnail image'}">
            {img src='cropthumb.png' modname='SimpleMedia' __alt='Crop thumbnail image'} {gt text='Crop thumbnail image'}
        </a>
    {/if}
    {/checkpermissionblock}
    <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='medium'}" title="{gt text='Back to overview'}" class="z-icon-es-back">
        {gt text='Back to overview'}
    </a>
</p>

{* include display hooks *}
{notifydisplayhooks eventname='simplemedia.ui_hooks.media.display_view' id=$medium.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

{/if}

</div>
</div>
{include file='user/footer.tpl'}

