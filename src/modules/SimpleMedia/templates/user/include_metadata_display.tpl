{* purpose of this template: reusable display of meta data fields *}
{if isset($obj.metadata)}
<h3 class="metadata">{gt text='Metadata'}</h3>
<dl class="propertylist">
{if $obj.metadata.title ne ''}
    <dt>{gt text='Title'}</dt>
    <dd>{$obj.metadata.title|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.author ne ''}
    <dt>{gt text='Author'}</dt>
    <dd>{$obj.metadata.author|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.subject ne ''}
    <dt>{gt text='Subject'}</dt>
    <dd>{$obj.metadata.subject|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.keywords ne ''}
    <dt>{gt text='Keywords'}</dt>
    <dd>{$obj.metadata.keywords|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.description ne ''}
    <dt>{gt text='Description'}</dt>
    <dd>{$obj.metadata.description|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.publisher ne ''}
    <dt>{gt text='Publisher'}</dt>
    <dd>{$obj.metadata.publisher|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.contributor ne ''}
    <dt>{gt text='Contributor'}</dt>
    <dd>{$obj.metadata.contributor|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.startdate ne ''}
    <dt>{gt text='Start date'}</dt>
    <dd>{$obj.metadata.startdate|dateformat}</dd>
{/if}
{if $obj.metadata.enddate ne ''}
    <dt>{gt text='End date'}</dt>
    <dd>{$obj.metadata.enddate|dateformat}</dd>
{/if}
{if $obj.metadata.type ne ''}
    <dt>{gt text='Type'}</dt>
    <dd>{$obj.metadata.type|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.format ne ''}
    <dt>{gt text='Format'}</dt>
    <dd>{$obj.metadata.format|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.uri ne ''}
    <dt>{gt text='Uri'}</dt>
    <dd>{$obj.metadata.uri|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.source ne ''}
    <dt>{gt text='Source'}</dt>
    <dd>{$obj.metadata.source|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.language ne ''}
    <dt>{gt text='Language'}</dt>
    <dd>{$obj.metadata.language|getlanguagename|safehtml}</dd>
{/if}
{if $obj.metadata.relation ne ''}
    <dt>{gt text='Relation'}</dt>
    <dd>{$obj.metadata.relation|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.coverage ne ''}
    <dt>{gt text='Coverage'}</dt>
    <dd>{$obj.metadata.coverage|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.comment ne ''}
    <dt>{gt text='Comment'}</dt>
    <dd>{$obj.metadata.comment|default:'-'|safetext}</dd>
{/if}
{if $obj.metadata.extra ne ''}
    <dt>{gt text='Extra'}</dt>
    <dd>{$obj.metadata.extra|default:'-'|safetext}</dd>
{/if}
</dl>
{/if}
