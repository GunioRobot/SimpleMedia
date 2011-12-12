{* purpose of this template: inclusion template for display of related Media in user area *}

{if isset($items) && $items ne null}
<ul class="relatedItemList Medium">
{foreach name='relLoop' item='item' from=$items}
    <li>
    <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$item.id}">
        {$item.title}
    </a>
    <a id="mediumItem{$item.id}Display" href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$item.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" style="display: none">
        {icon type='view' size='extrasmall' __alt='Quick view'}
    </a>
    <script type="text/javascript" charset="utf-8">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            simmedInitInlineWindow($('mediumItem{{$item.id}}Display'), '{{$item.title|replace:"'":""}}');
        });
    /* ]]> */
    </script>

    </li>
{/foreach}
</ul>
{/if}

