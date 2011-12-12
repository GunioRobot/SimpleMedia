{* purpose of this template: reusable editing of entity attributes *}
<fieldset>
    <legend>{gt text='Attributes'}</legend>
    {formvolatile}
    {foreach key='fieldName' item='fieldValue' from=$attributes}
    <div class="z-formrow">
        {formlabel for="attributes`$fieldName`"' text=$fieldName}
        {formtextinput id="attributes`$fieldName`" group='attributes' dataField=$fieldName maxLength=255}
    </div>
    {/foreach}
    {/formvolatile}
</fieldset>
