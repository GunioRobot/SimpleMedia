{* purpose of this template: media view json view in admin area *}
{simplemediaTemplateHeaders contentType='application/json'}
[
{foreach item='item' from=$items name='media'}
    {if not $smarty.foreach.media.first},{/if}
    {$item->toJson()}
{/foreach}
]
