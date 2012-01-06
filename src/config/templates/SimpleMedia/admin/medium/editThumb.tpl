{* purpose of this template: media display view in admin area *}
{pageaddvar name='javascript' value='modules/SimpleMedia/javascript/jsCropperUI-1.2.2/cropper.js'}
{include file='admin/header.tpl'}
<div class="simplemedia-medium simplemedia-editthumb">
{gt text='Thumbnail cropping' assign='templateTitle'}
{assign var='templateTitle' value=$medium.title|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-admin-content-pagetitle">
    {icon type='edit' size='small' __alt='Details'}
    <h3>{$templateTitle}</h3>
</div>

{assign var='showPreview' value=true}
{if $cropSizeMode eq SIMPLEMEDIA_CROPPINGMODE_VARIABLE_SIZE_VARIABLE_PROPORTIONS}
{assign var='showPreview' value=false}
{/if}

<form id="cropform" action="{modurl modname='SimpleMedia' type='admin' func='updatethumb'}" method="post">
{if $showPreview eq true}
    <fieldset class="z-floatright z-w49">
        <legend>{gt text='Preview'}</legend>
        <div id="previewWrap"></div>
    </fieldset>
{/if}
    <fieldset{if $showPreview eq true} class="z-floatleft z-w49"{/if}>
        <legend>{gt text='Action'}</legend>
        <h4>{gt text='Crob your thumbnail image here'}</h4>
    {if $cropSizeMode eq SIMPLEMEDIA_CROPPINGMODE_ENFORCED_SIZE_ENFORCED_PROPORTIONS}
        <p>{gt text='Simply move the selection area to your desired section. Size and proportions are fixed.'}</p>
    {elseif $cropSizeMode eq SIMPLEMEDIA_CROPPINGMODE_VARIABLE_SIZE_ENFORCED_PROPORTIONS}
        <p>{gt text='Simply move the selection area to your desired section. You may increase the size, but proportions are fixed.'}</p>
    {elseif $cropSizeMode eq SIMPLEMEDIA_CROPPINGMODE_VARIABLE_SIZE_VARIABLE_PROPORTIONS}
        <p>{gt text='Simply move the selection area to your desired section. You may increase the size and change proportions as desired.'}</p>
    {/if}
        <input type="hidden" id="id" name="id" value="{$medium.id}" />
        <input type="hidden" name="thumbnr" value="{$thumbnr}" />
        <input type="hidden" name="returnTo" value="{$returnTo}" />

        <input type="hidden" name="x1" id="x1" size="4" />
        <input type="hidden" name="y1" id="y1" size="4" />
        <input type="hidden" name="x2" id="x2" size="4" />
        <input type="hidden" name="y2" id="y2" size="4" />
        <input type="hidden" name="width" id="width" size="4" />
        <input type="hidden" name="height" id="height" size="4" />

        <ul style="list-style-type: none">
            <li><a href="#" id="saveThumb" title="{gt text='Save'}">{img src='cropthumb.png' modname='SimpleMedia'} {gt text='Save'}</a></li>
            <li><a href="{$returnUrl|safetext}" title="{gt text='Cancel editing'}">{icon type='cancel' size='extrasmall' __alt='Cancel'} {gt text='Cancel'}</a></li>
        </ul>
    </fieldset>
{if $showPreview eq true}
    <br style="clear: both" />
{/if}
</form>
<p><img src="{$medium.theFileFullPath}" alt="{$medium.title|safetext}" id="smcropimg" width="{$medium.theFileMeta.width}" height="{$medium.theFileMeta.height}" /></p>
</div>
{include file='admin/footer.tpl'}

<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        new Cropper.ImgWithPreview(
            'smcropimg',
            {
{{if $cropSizeMode ne SIMPLEMEDIA_CROPPINGMODE_VARIABLE_SIZE_VARIABLE_PROPORTIONS}}
                ratioDim: {
                    x: {{$thumbDimension.width}},
                    y: {{$thumbDimension.height}}
                },
{{/if}}
                minWidth: {{$thumbDimension.width}},
                minHeight: {{$thumbDimension.height}},
{{if $cropSizeMode eq SIMPLEMEDIA_CROPPINGMODE_ENFORCED_SIZE_ENFORCED_PROPORTIONS}}
                maxWidth: {{$thumbDimension.width}},
                maxHeight: {{$thumbDimension.height}},
{{/if}}
{{if $cropSizeMode ne SIMPLEMEDIA_CROPPINGMODE_VARIABLE_SIZE_VARIABLE_PROPORTIONS}}
                previewWrap: 'previewWrap',
{{/if}}
                captureKeys: false,         // disable keyboard capturing, as this can cause some problems at the moment
                onEndCrop: smOnEndCrop      // callback function to provide the crop details to on end of a crop
            }
        );
    } );

    $('saveThumb').observe('click', smStartThumbUpdate)
                  .observe('keyup', smStartThumbUpdate);

    function smStartThumbUpdate() {
        $('cropform').submit();
    }

    /**
     * Callback function to capture the crop co-ordinates
     */
    function smOnEndCrop(coords, dimensions) {
        $('x1').value = coords.x1;
        $('y1').value = coords.y1;
        $('x2').value = coords.x2;
        $('y2').value = coords.y2;
        $('width').value = dimensions.width;
        $('height').value = dimensions.height;
    }
/* ]]> */
</script>
<noscript><p>{gt text='Unfortunately the cropping tool requires JavaScript enabled for working properly.'}</p></noscript>
