{* Purpose of this template: edit view of generic item list content type *}

<div class="z-formrow" style="display: none">
    {formlabel for='SimpleMedia_objecttype' __text='Object type'}
    {simplemediaSelectorObjectTypes assign='allObjectTypes'}
    {formdropdownlist id='SimpleMedia_objecttype' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
</div>

<div class="z-formrow">
    <label for="catid">{gt text='Category'}</label>
    {modapifunc modname='SimpleMedia' type='category' func='getMainCat' assign='mainCategory'}
    {formcategoryselector category=$mainCategory id='catid' group='data' mandatory=true editLink=false}
</div>

<div class="z-formrow" style="display: none">
    {formlabel __text='Sorting'}
    <div>
        {*formradiobutton id='SimpleMedia_srandom' value='random' dataField='sorting' group='data' mandatory=true}
        {formlabel for='SimpleMedia_srandom' __text='Random'*}
        {formradiobutton id='SimpleMedia_snewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {formlabel for='SimpleMedia_snewest' __text='Newest'}
        {formradiobutton id='SimpleMedia_sdefault' value='default' dataField='sorting' group='data' mandatory=true}
        {formlabel for='SimpleMedia_sdefault' __text='Default'}
    </div>
</div>

<div class="z-formrow">
    {formlabel for='SimpleMedia_amount' text='Menge'}
    {formtextinput id='SimpleMedia_amount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {formlabel for='SimpleMedia_template' text='Vorlage'}
    {simplemediaSelectorTemplates assign='allTemplates'}
    {formdropdownlist id='SimpleMedia_template' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div class="z-formrow" style="display: none">
    {formlabel for='SimpleMedia_filter' __text='Filter (expert option)'}
    {formtextinput id='SimpleMedia_filter' dataField='filter' group='data' mandatory=false maxLength=255}
    <div class="z-formnote">({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)</div>
</div>
