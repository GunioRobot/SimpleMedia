{* purpose of this template: media view view in user area *}
<div class="simplemedia-medium simplemedia-view">
{include file='user/header.tpl'}
{gt text='Medium list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>



    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='medium'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='medium' all=1}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
    {/if}

{include file='navigationForm.tpl' showCatFilter=true showSorting=true showPageSize=true}

<table class="z-datatable">
    <colgroup>
        <col id="ctitle" />
        <col id="cthefile" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="htitle" scope="col" class="z-left">{gt text='Title'}</th>
        <th id="hthefile" scope="col" class="z-left">{gt text='The file'}</th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

    {foreach item='medium' from=$items}
    <tr class="{cycle values='z-odd, z-even'}" title="{$medium.description|replace:"\"":""}">
        <td headers="htitle" class="z-left">
            {$medium.title|notifyfilters:'simplemedia.filterhook.media'}
        </td>
        <td headers="hthefile" class="z-left">
            {getinlinesnippet medium=$medium}
        </td>
        <td headers="hitemactions" class="z-right z-nowrap z-w02">
            {*if count($medium._actions) gt 0}
            {strip}
                {foreach item='option' from=$medium._actions}
                    <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>
                        {icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}
                    </a>
                {/foreach}
            {/strip}
            {/if*}
            <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$medium.id}">
                {icon type='display' size='extrasmall' __alt='Details'}
            </a>
    {checkpermissionblock component='SimpleMedia::' instance='.*' level='ACCESS_EDIT'}
            <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='medium' id=$medium.id returnTo='userView'}" title="{gt text='Edit'}">
                {icon type='edit' size='extrasmall' __alt='Edit'}
            </a>
        {if $medium.theFileMeta.isImage && $modvars.SimpleMedia.useThumbCropper eq true}
            {assign var='thumbnr' value=$modvars.SimpleMedia.defaultThumbNumber}
            {if isset($smarty.get.thumbnr) && $smarty.get.thumbnr ne 0}
                {assign var='thumbnr' value=$smarty.get.thumbnr}
            {/if}
            <a href="{modurl modname='SimpleMedia' type='admin' func='editthumb' id=$medium.id thumbnr=$thumbnr returnTo='userView'}" title="{gt text='Crop thumbnail image'}">
                {img src='cropthumb.png' modname='SimpleMedia' __alt='Crop thumbnail image'}
            </a>
        {/if}
{*            <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='medium' astemplate=$medium.id}" title="{gt text='Reuse for new item'}">
                {icon type='saveas' size='extrasmall' __alt='Reuse'}
            </a>*}
    {/checkpermissionblock}
        </td>
    </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="3">
            {gt text='No media found.'}
          </td>
        </tr>
    {/foreach}

    </tbody>
</table>

    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
    {/if}

    {notifydisplayhooks eventname='simplemedia.ui_hooks.media.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='hookname' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
</div>
{include file='user/footer.tpl'}

