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
    <dd>  <a href="{$medium.theFileFullPathURL}" title="{$medium.title|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[medium]"{/if}>
  {if $medium.theFileMeta.isImage}
      <img src="{$medium.theFile|simplemediaImageThumb:$medium.theFileFullPath:250:150}" width="250" height="150" alt="{$medium.title|replace:"\"":""}" />
  {else}
      {gt text='Download'} ({$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false})
  {/if}
  </a>
</dd>
    <dt>{gt text='Description'}</dt>
    <dd>{$medium.description}</dd>
</dl>
    {include file='user/include_attributes_display.tpl' obj=$medium}
    {include file='user/include_categories_display.tpl' obj=$medium}
    {include file='user/include_standardfields_display.tpl' obj=$medium}
    {include file='user/include_metadata_display.tpl' obj=$medium}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{if count($medium._actions) gt 0}
    <p>{strip}
    {foreach item='option' from=$medium._actions}
        <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
            {$option.linkText|safetext}
        </a>
    {/foreach}
    {/strip}</p>
{/if}

{* include display hooks *}
{notifydisplayhooks eventname='simplemedia.ui_hooks.media.display_view' id=$medium.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

{/if}

</div>
</div>
{include file='user/footer.tpl'}

