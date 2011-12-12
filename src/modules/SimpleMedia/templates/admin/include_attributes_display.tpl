{* purpose of this template: reusable display of entity attributes *}
{if isset($obj.attributes)}
<h3 class="attributes">{gt text='Attributes'}</h3>
<dl class="propertylist">
{foreach key='fieldName' item='fieldInfo' from=$obj.attributes}
    <dt>{$fieldName|safetext}</dt>
    <dd>{$fieldInfo.value|default:''|safetext}</dd>
{/foreach}
</dl>
{/if}
