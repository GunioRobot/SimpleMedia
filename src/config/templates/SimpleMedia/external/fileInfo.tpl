{* Purpose of this template: Display several file information for previewing from other modules *}
<dl id="medium{$medium.id}">
    <dt>{$medium.title|notifyfilters:'simplemedia.filter_hooks.media.filter'|htmlentities}</dt>
    <dd>{getinlinesnippet medium=$medium externalPreview=1}</dd>
    <dd>{if $medium.description ne ''}{$medium.description}{/if}
    <dd>{assignedcategorieslist categories=$medium.categories doctrine2=true}</dd>
</dl>
