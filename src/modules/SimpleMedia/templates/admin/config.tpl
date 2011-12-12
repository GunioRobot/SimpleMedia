{* purpose of this template: module configuration *}
{include file='admin/header.tpl'}
<div class="simplemedia-config">
{gt text='Settings' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='config' size='small' __alt='Settings'}
    <h3>{$templateTitle}</h3>
</div>

    {form cssClass='z-form'}


        {* add validation summary and a <div> element for styling the form *}
        {simplemediaFormFrame}
        {formsetinitialfocus inputId='pageSize'}
            <fieldset>
                <legend>{gt text='Here you can manage all basic settings for this application.'}</legend>

                <div class="z-formrow">
                    {formlabel for='pageSize' __text='Page size'}
                    {formintinput id='pageSize' group='config' maxLength=255 width=20em __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='thumbDimensions' __text='Thumb dimensions'}
                    {formtextinput id='thumbDimensions' group='config' maxLength=255 width=20em __title='Enter this setting.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='defaultThumbNumber' __text='Default thumb number'}
                    {formintinput id='defaultThumbNumber' group='config' maxLength=255 width=20em __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='enableShrinking' __text='Enable shrinking'}
                    {formcheckbox id='enableShrinking' group='config'}
                </div>
                <div class="z-formrow">
                    {formlabel for='shrinkDimensions' __text='Shrink dimensions'}
                    {formtextinput id='shrinkDimensions' group='config' maxLength=255 width=20em __title='Enter this setting.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='useThumbCropper' __text='Use thumb cropper'}
                    {formcheckbox id='useThumbCropper' group='config'}
                </div>
                <div class="z-formrow">
                    {formlabel for='cropSizeMode' __text='Crop size mode'}
                    {formintinput id='cropSizeMode' group='config' maxLength=255 width=20em __title='Enter this setting. Only digits are allowed.'}
                </div>
            </fieldset>

            <div class="z-buttons z-formbuttons">
                {formbutton commandName='save' __text='Update configuration' class='z-bt-save'}
                {formbutton commandName='cancel' __text='Cancel' class='z-bt-cancel'}
            </div>
        {/simplemediaFormFrame}
    {/form}
</div>
{include file='admin/footer.tpl'}
