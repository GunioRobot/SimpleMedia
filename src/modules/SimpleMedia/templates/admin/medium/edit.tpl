{* purpose of this template: build the Form to edit an instance of medium *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/SimpleMedia/javascript/SimpleMedia_editFunctions.js'}
{pageaddvar name='javascript' value='modules/SimpleMedia/javascript/SimpleMedia_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit medium' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create medium' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit medium' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="simplemedia-medium simplemedia-edit">
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type=$adminPageIcon size='small' alt=$templateTitle}
    <h3>{$templateTitle}</h3>
</div>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {simplemediaFormFrame}
    {formsetinitialfocus inputId='title'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        <div class="z-formrow">
            {formlabel for='title' __text='Title' mandatorysym='1'}
            {formtextinput group='medium' id='title' mandatory=true readOnly=false __title='Enter the title of the medium' textMode='singleline' maxLength=255 cssClass='required'}
            {simplemediaValidationError id='title' class='required'}
        </div>
        <div class="z-formrow">
            {assign var='mandatorySym' value='1'}
            {if $mode ne 'create'}
                {assign var='mandatorySym' value='0'}
            {/if}
            {formlabel for='theFile' __text='The file' mandatorysym=$mandatorySym}<br />{* break required for Google Chrome *}
{if $mode eq 'create'}
            {formuploadinput group='medium' id='theFile' mandatory=true readOnly=false cssClass='required'}
{else}
            {formuploadinput group='medium' id='theFile' mandatory=false readOnly=false cssClass=''}
{/if}

            <div class="z-formnote">{gt text='Allowed file extensions:'} gif, jpeg, jpg, png, pdf, doc, xls, ppt, docx, xlsx, pptx, odt, ods, odp, arj, zip, rar, tar, tgz, gz, bz2, txt, rtf, swf, flv, mp3, mp4, avi, mpg, mpeg, mov</div>
            {if $mode ne 'create'}
                  <div class="z-formnote">
                      {gt text='Current file'}:
                      <a href="{$medium.theFileFullPathUrl}" title="{$medium.title|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[medium]"{/if}>
                      {if $medium.theFileMeta.isImage}
                          <img src="{$medium.theFile|simplemediaImageThumb:$medium.theFileFullPath:80:50}" width="80" height="50" alt="{$medium.title|replace:"\"":""}" />
                      {else}
                          {gt text='Download'} ({$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false})
                      {/if}
                      </a>
                  </div>
            {/if}
            {simplemediaValidationError id='theFile' class='required'}
        </div>
        <div class="z-formrow">
            {formlabel for='description' __text='Description'}
            {formtextinput group='medium' id='description' mandatory=false __title='Enter the description of the medium' textMode='multiline' rows='6' cols='50' cssClass=''}
        </div>
    </fieldset>

    {include file='admin/include_attributes_edit.tpl' obj=$medium}
    {include file='admin/include_categories_edit.tpl' obj=$medium groupName='mediumObj'}
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$medium}
    {/if}
    {include file='admin/include_metadata_edit.tpl' obj=$medium}

    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.media.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.media.form_edit' id=$medium.id assign='hooks'}
    {/if}
    {if is_array($hooks) && isset($hooks[0])}
        <fieldset>
            <legend>{gt text='Hooks'}</legend>
            {foreach key='hookName' item='hook' from=$hooks}
            <div class="z-formrow">
                {$hook}
            </div>
            {/foreach}
        </fieldset>
    {/if}

    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatcreation' __text='Create another item after save'}
                {formcheckbox group='medium' id='repeatcreation' readOnly=false}
            </div>
        </fieldset>
    {/if}

    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {if $mode eq 'edit'}
        {formbutton id='btnUpdate' commandName='update' __text='Update medium' class='z-bt-save'}
      {if !$inlineUsage}
        {gt text='Really delete this medium?' assign='deleteConfirmMsg'}
        {formbutton id='btnDelete' commandName='delete' __text='Delete medium' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
      {/if}
    {elseif $mode eq 'create'}
        {formbutton id='btnCreate' commandName='create' __text='Create medium' class='z-bt-ok'}
    {else}
        {formbutton id='btnUpdate' commandName='update' __text='OK' class='z-bt-ok'}
    {/if}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
  {/simplemediaFormFrame}
{/form}

</div>
{include file='admin/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='deleteImageArray'}

<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */
    var editImage = '<img src="{{$editImageArray.src}}" width="16" height="16" alt="" />';
    var removeImage = '<img src="{{$deleteImageArray.src}}" width="16" height="16" alt="" />';

    document.observe('dom:loaded', function() {

        simmedAddCommonValidationRules('medium', '{{if $mode eq 'create'}}{{else}}{{$medium.id}}{{/if}}');

        // observe button events instead of form submit
        var valid = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = valid.validate();
        {{/if}}

        $('{{if $mode eq 'create'}}btnCreate{{else}}btnUpdate{{/if}}').observe('click', function(event) {
            var result = valid.validate();
            if (!result) {
                // validation error, abort form submit
                Event.stop(event);
            } else {
                // hide form buttons to prevent double submits by accident
                $$('div.z-formbuttons input').each(function(btn) {
                    btn.hide();
                });
            }
            return result;
        });

        Zikula.UI.Tooltips($$('.simplemediaFormTooltips'));
    });

/* ]]> */
</script>
