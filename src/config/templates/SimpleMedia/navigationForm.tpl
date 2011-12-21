{* Purpose of this template: navigation form *}
{checkpermissionblock component='SimpleMedia::' instance='.*' level='ACCESS_EDIT'}
<form action="{$modvars.ZConfig.entrypoint|default:'index.php'}" method="get" id="smNavForm">
    <fieldset>
{if !isset($smarty.get.type) || $smarty.get.type ne 'admin'}
<h3 style="margin-top: 0">Navigation für Redakteure</h3>
{/if}
        <input type="hidden" name="module" value="{modgetinfo modname='SimpleMedia' info='displayname'}" />
        <input type="hidden" name="type" value="{if isset($smarty.get.type) && $smarty.get.type eq 'admin'}admin{else}user{/if}" />
        <input type="hidden" name="func" value="view" />

{if $showCatFilter eq true}
        <label for="catid">{gt text='Category'}</label>
        &nbsp;
        {modapifunc modname='SimpleMedia' type='category' func='getMainCat' assign='mainCategory'}
        {assign var='catID' value=0}
        {if isset($smarty.get.catid)}
            {assign var='catID' value=$smarty.get.catid}
        {/if}
        {gt text='All' assign='lblDef'}
        {selector_category category=$mainCategory name='catid' field='id' defaultText=$lblDef editLink=false selectedValue=$catID}
{/if}

{if $showSorting eq true}
        <label for="SimpleMedia_sortby">{gt text='Sort by' assign='dummy'}Sortieren nach</label>
        &nbsp;
        <select id="SimpleMedia_sortby" name="sort">
            <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
            <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date' assign='dummy'}Erstellungsdatum</option>
            <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator' assign='dummy'}Ersteller</option>
            <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date' assign='dummy'}Änderungsdatum</option>
            <option value="theFile"{if $sort eq 'theFile'} selected="selected"{/if}>{gt text='The file'}</option>
        </select>
        <select id="SimpleMedia_sortdir" name="sortdir">
            <option value="asc"{if $sdir eq 'asc'} selected="selected"{/if}>{gt text='ascending' assign='dummy'}aufsteigend</option>
            <option value="desc"{if $sdir eq 'desc'} selected="selected"{/if}>{gt text='descending' assign='dummy'}absteigend</option>
        </select>
{/if}

{if $showPageSize eq true}
    {assign var='pagesize' value=$modvars.SimpleMedia.pageSize}
    {if isset($smarty.get.num)}
        {assign var='pagesize' value=$smarty.get.num}
    {/if}
        <label for="SimpleMedia_num">{gt text='Page size'}</label>
        &nbsp;
        <select id="SimpleMedia_num" name="num">
            <option value="5"{if $pagesize eq 5} selected="selected"{/if}>5</option>
            <option value="10"{if $pagesize eq 10} selected="selected"{/if}>10</option>
            <option value="15"{if $pagesize eq 15} selected="selected"{/if}>15</option>
            <option value="20"{if $pagesize eq 20} selected="selected"{/if}>20</option>
            <option value="30"{if $pagesize eq 30} selected="selected"{/if}>30</option>
            <option value="50"{if $pagesize eq 50} selected="selected"{/if}>50</option>
            <option value="100"{if $pagesize eq 100} selected="selected"{/if}>100</option>
        </select>
{/if}

        <input type="checkbox" id="SimpleMedia_onlyimages" name="onlyimages" value="1"{if isset($smarty.get.onlyimages) && $smarty.get.onlyimages eq 1} checked="checked"{/if} />
        <label for="SimpleMedia_onlyimages">{gt text='Only images' assign='dummy'}Nur Bilder</label>

{if isset($smarty.get.onlyimages) && $smarty.get.onlyimages eq 1}
    {assign var='thumbnr' value=$modvars.SimpleMedia.defaultThumbNumber}
    {if isset($smarty.get.thumbnr)}
        {assign var='thumbnr' value=$smarty.get.thumbnr}
    {/if}
        <select id="SimpleMedia_thumbnr" name="thumbnr">
            {foreach name='thumbLoop' item='thumbSize' from=$modvars.SimpleMedia.thumbDimensions}
                <option value="{$smarty.foreach.thumbLoop.iteration}"{if $smarty.foreach.thumbLoop.iteration eq $thumbnr} selected="selected"{/if}>{$thumbSize.width} x {$thumbSize.height} px&nbsp;</option>
            {/foreach}
        </select>
{/if}

        <input type="submit" name="changenow" id="SimpleMedia_submit" value="{gt text='OK'}" />
    </fieldset>
</form>

<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{if $showCatFilter eq true}}
        $('catid').observe('change', smSubmitNaviForm);
    {{/if}}
    {{if $showSorting eq true}}
        $('SimpleMedia_sortby').observe('change', smSubmitNaviForm);
        $('SimpleMedia_sortdir').observe('change', smSubmitNaviForm);
    {{/if}}
    {{if $showPageSize eq true}}
        $('SimpleMedia_num').observe('change', smSubmitNaviForm);
    {{/if}}
        $('SimpleMedia_onlyimages').observe('click', smSubmitNaviForm)
                                   .observe('keypress', smSubmitNaviForm);
    {{if isset($smarty.get.onlyimages) && $smarty.get.onlyimages eq 1}}
        $('SimpleMedia_thumbnr').observe('change', smSubmitNaviForm);
    {{/if}}
        //$('SimpleMedia_submit').hide();
    });

    function smSubmitNaviForm()
    {
        $('smNavForm').submit();
    }
/* ]]> */
</script>
{/checkpermissionblock}
