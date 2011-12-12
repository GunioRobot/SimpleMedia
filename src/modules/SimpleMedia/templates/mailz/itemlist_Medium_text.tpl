{* Purpose of this template: Display media in text mailings *}
{foreach item='item' from=$items}
        {$item.title}
        {modurl modname='SimpleMedia' type='user' func='display' ot=$objectType id=$item.id fqurl=true}
-----
{foreachelse}
    {gt text='No media found.'}
{/foreach}
