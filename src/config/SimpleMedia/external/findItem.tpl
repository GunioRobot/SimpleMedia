{* Purpose of this template: popup selector for scribite integration *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{lang}" lang="{lang}">
<head>
    <title>{gt text='Search and select a file'}</title>
    <link type="text/css" rel="stylesheet" href="{$baseurl}style/core.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/SimpleMedia/style/style.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/SimpleMedia/style/findItem.css" />
    {assign var='ourEntry' value=$modvars.ZConfig.entrypoint}
    <script type="text/javascript">/* <![CDATA[ */
        if (typeof(Zikula) == 'undefined') {var Zikula = {};}
        Zikula.Config = {'entrypoint': '{{$ourEntry|default:'index.php'}}', 'baseURL': '{{$baseurl}}'}; /* ]]> */</script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/prototype.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/scriptaculous.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/dragdrop.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/effects.js"></script>
    <script type="text/javascript" src="{$baseurl}modules/SimpleMedia/javascript/findItem.js"></script>
{if $editorName eq 'tinymce'}
    <script type="text/javascript" src="{$baseurl}modules/Scribite/includes/tinymce/tiny_mce_popup.js"></script>
{/if}
</head>

<body>
<form action="{$ourEntry|default:'index.php'}" id="selectorForm" method="get" class="z-form">
    <input type="hidden" name="module" value="{modgetinfo module='SimpleMedia' info='displayname'}" />
    <input type="hidden" name="type" value="external" />
    <input type="hidden" name="func" value="findItem" />
    <input type="hidden" name="editor" id="editorName" value="{$editorName}" />

    <fieldset>
        <legend>{gt text='Search and select a file'}</legend>

        <div class="z-formrow">
            <label for="SimpleMedia_onlyimages">{gt text='Only images'}</label>
            <input type="checkbox" id="SimpleMedia_onlyimages" name="onlyimages" value="1"{if $onlyimages eq 1} checked="checked"{/if}/>
        </div>
{if $onlyimages}
        <div class="z-formrow">
            <label for="SimpleMedia_thumbnr">{gt text='Thumbnail size'}</label>
            <select id="SimpleMedia_thumbnr" name="thumbnr" style="width: 100px">
                {foreach name='thumbLoop' item='thumbSize' from=$modvars.SimpleMedia.thumbDimensions}
                    <option value="{$smarty.foreach.thumbLoop.iteration}"{if $smarty.foreach.thumbLoop.iteration eq $thumbnr} selected="selected"{/if}>{$thumbSize.width} x {$thumbSize.height} px&nbsp;</option>
                {/foreach}
            </select>
        </div>
{/if}
{*        <div class="z-formrow">
            <label for="SimpleMedia_cid">{gt text='Category'}:</label>
            {gt text='All' assign='lblDef'}
            {selector_category category=$mainCategory name='cat_id' field='id' defaultText=$lblDef editLink=false submit=true selectedValue=$catID}
        </div>*}

        <div class="z-formrow">
            <label for="SimpleMedia_pasteas">{gt text='Paste as'}:</label>
        {if $onlyimages eq 1}
            <select id="SimpleMedia_pasteas" name="pasteas">
                <option value="1" selected="selected">{gt text='Thumbnail with link to original image'}</option>
                <option value="2">{gt text='Thumbnail with link to detail page'}</option>
                <option value="3">{gt text='Thumbnail'}</option>
                <option value="4">{gt text='Original image'}</option>
                <option value="5">{gt text='Link to thumbnail'}</option>
                <option value="6">{gt text='Link to original image'}</option>
                <option value="7">{gt text='ID of medium'}</option>
                <option value="8">{gt text='Original with link to itself'}</option>
            </select>
        {else}
            <select id="SimpleMedia_pasteas" name="pasteas">
                <option value="5">{gt text='Link to the file'}</option>
                <option value="6">{gt text='ID of medium'}</option>
            </select>
        {/if}
        </div>
        <br />

        <div class="z-formrow">
            <label for="SimpleMedia_objectid">{gt text='File'}:</label>
            {if $onlyimages eq 1}
                {assign var='thumbWidth' value=$modvars.SimpleMedia.thumbDimensions[$thumbnr].width}
                {assign var='thumbHeight' value=$modvars.SimpleMedia.thumbDimensions[$thumbnr].height}
            {/if}
            <div id="filecontainer">
                {if $onlyimages ne 1}
                    <ul>
                {else}
                {/if}
                {foreach item='medium' from=$objectData}
                    {if $onlyimages ne 1}
                        <li>
                    {else}
                    {/if}
                    <a href="#" onclick="simpleMedia.find.selectItem({$medium.id})" onkeypress="simpleMedia.find.selectItem({$medium.id})">
                        {if $onlyimages ne 1}
                            {$medium.title} ({$medium.theFileMeta.extension})
                        {else}
                            {getinlinesnippet medium=$medium thumbnr=$thumbnr zoomMode='nozoom'}
                        {/if}
                    </a>
                    <input type="hidden" id="fileurl{$medium.id}" value="{$medium.theFileFullPathURL}" />
                    {if $onlyimages eq 1}
                    {assign var='thumbIter' value=$thumbnr-1}
                    {assign var='thumbSize' value=$modvars.SimpleMedia.thumbDimensions[$thumbIter]}
                    {assign var='thumbWidth' value=$thumbSize.width}
                    {assign var='thumbHeight' value=$thumbSize.height}
                    <input type="hidden" id="thumburl{$medium.id}" value="{$baseurl}{$medium.theFile|simplemediaImageThumb:$medium.theFileFullPath:$thumbWidth:$thumbHeight}" />
                    <input type="hidden" id="detailurl{$medium.id}" value="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$medium.id}" />
                    {/if}
                    <input type="hidden" id="imgtitle{$medium.id}" value="{$medium.title|replace:"\"":""}" />
                    <input type="hidden" id="imgdesc{$medium.id}" value="{$medium.description|strip_tags|replace:"\"":""}" />
                    {if $onlyimages ne 1}
                        </li>
                    {else}
                    {/if}
                {foreachelse}
                    {if $onlyimages ne 1}
                        <li>
                    {else}
                    {/if}
                    {gt text='No entries found.'}
                    {if $onlyimages ne 1}
                        </li>
                    {else}
                    {/if}
                {/foreach}
                {if $onlyimages ne 1}
                    </ul>
                {else}
                {/if}
            </div>
        </div>

        <div class="z-formrow">
            <label for="SimpleMedia_sort">{gt text='Sort by'}:</label>
            <select id="SimpleMedia_sort" name="sort" style="width: 150px" class="z-floatleft" style="margin-right: 10px">
                <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
                <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
                <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
                <option value="theFile"{if $sort eq 'theFile'} selected="selected"{/if}>{gt text='The file'}</option>
            </select>
            <select id="SimpleMedia_sortdir" name="sortdir" style="width: 100px">
                <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
            </select>
        </div>

        <div class="z-formrow">
            <label for="SimpleMedia_pagesize">{gt text='Page size'}:</label>
            <select id="SimpleMedia_pagesize" name="num" style="width: 50px; text-align: right">
                <option value="5"{if $pager.numitems eq 5} selected="selected"{/if}>5</option>
                <option value="10"{if $pager.numitems eq 10} selected="selected"{/if}>10</option>
                <option value="15"{if $pager.numitems eq 15} selected="selected"{/if}>15</option>
                <option value="20"{if $pager.numitems eq 20} selected="selected"{/if}>20</option>
                <option value="30"{if $pager.numitems eq 30} selected="selected"{/if}>30</option>
                <option value="50"{if $pager.numitems eq 50} selected="selected"{/if}>50</option>
                <option value="100"{if $pager.numitems eq 100} selected="selected"{/if}>100</option>
            </select>
        </div>

        <div class="z-formrow">
            <label for="SimpleMedia_keyword">{gt text='Search for'}:</label>
            <input type="text" id="SimpleMedia_keyword" name="keyword" style="width: 150px" class="z-floatleft" style="margin-right: 10px" />
            <input type="button" id="SimpleMedia_gosearch" name="gosearch" value="{gt text='Filter'}" style="width: 80px" />
        </div>

        <div style="margin-left: 6em">
            {pager show='page' rowcount=$pager.numitems limit=$pager.itemsperpage posvar='startnum' template='pagercss.html' maxpages='10'}
        </div>
        <input type="button" id="SimpleMedia_cancel" name="cancelButton" value="{gt text='Cancel'}" />
        <br />
    </fieldset>
</form>

<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        simpleMedia.find.onLoad();
    });
/* ]]> */
</script>

{*
<div class="smform">
    <fieldset>
    {modfunc modname='SimpleMedia' type='admin' func='edit'}
    </fieldset>
</div>
*}
</body>
</html>