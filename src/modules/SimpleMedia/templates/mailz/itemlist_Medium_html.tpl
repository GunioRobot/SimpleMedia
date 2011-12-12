{* Purpose of this template: Display media in html mailings *}
{*
<ul>
{foreach item='item' from=$items}
    <li>
        <a href="{modurl modname='SimpleMedia' type='user' func='display' ot=$objectType id=$item.id fqurl=true}
">{$item.title}
</a>
    </li>
{foreachelse}
    <li>{gt text='No media found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_Medium_display_description.tpl'}
