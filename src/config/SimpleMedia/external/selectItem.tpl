{* Purpose of this template: popup selector for Forms and Content integration *}
{assign var='baseID' value='medium'}
<div id="{$baseID}_preview" style="float: right; width: 300px; border: 1px dotted #a3a3a3; padding: .2em .5em; margin-right: 1em">
    <p><strong>{gt text='File information'}</strong></p>
    {img id='ajax_indicator' modname='core' set='ajax' src='indicator_circle.gif' alt='' style='display: none'}
    <div id="{$baseID}_previewcontainer">&nbsp;</div>
</div>
<br />
<br />
{assign var='leftSide' value=' style="float: left; width: 10em"'}
{assign var='rightSide' value=' style="float: left"'}
{assign var='break' value=' style="clear: left"'}
<p>
    <label for="{$baseID}_catid"{$leftSide}>{gt text='Category'}:</label>
    {gt text='All' assign='lblDef'}
    {selector_category category=$mainCategory name="`$baseID`_catid" field='id' defaultText=$lblDef editLink=false selectedValue=$catID}
    <br{$break} />
</p>
<p>
    <label for="{$baseID}_id"{$leftSide}>{gt text='File'}:</label>
    <select id="{$baseID}_id" name="id" {$rightSide}>
        {foreach item='medium' from=$items}{strip}
            <option value="{$medium.id}"{if $selectedId eq $medium.id} selected="selected"{/if}>
                {$medium.title} ({$medium.theFileMeta.extension})
            </option>{/strip}
        {foreachelse}
            <option value="0">{gt text='No entries found.'}</option>
        {/foreach}
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}_onlyimages"{$leftSide}>{gt text='Only images'}:</label>
    <input type="checkbox" id="{$baseID}_onlyimages" name="onlyimages" value="1"{if $onlyImages eq 1} checked="checked"{/if}{$rightSide} />
    <br{$break} />
</p>
<p>
    <label for="{$baseID}_sort"{$leftSide}>{gt text='Sort by'}:</label>
    <select id="{$baseID}_sort" name="sort" {$rightSide}>
        <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
        <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
        <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
        <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
        <option value="theFile"{if $sort eq 'theFile'} selected="selected"{/if}>{gt text='The file'}</option>
    </select>
    <select id="{$baseID}_sortdir" name="sortdir">
        <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
        <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}_keyword"{$leftSide}>{gt text='Search for'}:</label>
    <input type="text" id="{$baseID}_keyword" name="searchfor"{$rightSide} />
    <input type="button" id="SimpleMedia_gosearch" name="gosearch" value="{gt text='Search'}" />
    <br{$break} />
</p>

<br />
<br />

<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        simpleMedia.itemSelector.onLoad('{{$baseID}}', {{$selectedId|default:0}});
    });
/* ]]> */
</script>
