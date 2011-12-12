{* purpose of this template: reusable editing of meta data fields *}
<fieldset style="display: none">
    <legend>{gt text='Metadata'}</legend>

    <div class="z-formrow">
        {formlabel for='metadataTitle' __text='Title'}
        {formtextinput group='meta' id='metadataTitle' dataField='title' maxLength=80}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataAuthor' __text='Author'}
        {formtextinput group='meta' id='metadataAuthor' dataField='author' maxLength=80}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataSubject' __text='Subject'}
        {formtextinput group='meta' id='metadataSubject' dataField='subject' maxLength=255}
    </div>
    
    <div class="z-formrow">
        {formlabel for='metadataKeywords' __text='Keywords'}
        {formtextinput group='meta' id='metadataKeywords' dataField='keywords' maxLength=128}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataDescription' __text='Description'}
        {formtextinput group='meta' id='metadataDescription' dataField='description' maxLength=255}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataPublisher' __text='Publisher'}
        {formtextinput group='meta' id='metadataPublisher' dataField='publisher' maxLength=128}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataContributor' __text='Contributor'}
        {formtextinput group='meta' id='metadataContributor' dataField='contributor' maxLength=80}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataStartdate' __text='Start date'}
    {if $mode ne 'create'}
        {formdateinput group='meta' id='metadataStartdate' dataField='startdate' mandatory=false includeTime=true}
    {else}
        {formdateinput group='meta' id='metadataStartdate' dataField='startdate' mandatory=false includeTime=true defaultValue='now'}
    {/if}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataEnddate' __text='End date'}
    {if $mode ne 'create'}
        {formdateinput group='meta' id='metadataEnddate' dataField='enddate' mandatory=false includeTime=true}
    {else}
        {formdateinput group='meta' id='metadataEnddate' dataField='enddate' mandatory=false includeTime=true defaultValue='now'}
    {/if}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataType' __text='Type'}
        {formtextinput group='meta' id='metadataType' dataField='type' maxLength=128}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataFormat' __text='Format'}
        {formtextinput group='meta' id='metadataFormat' dataField='format' maxLength=128}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataUri' __text='Uri'}
        {formtextinput group='meta' id='metadataUri' dataField='uri' maxLength=255}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataSource' __text='Source'}
        {formtextinput group='meta' id='metadataSource' dataField='source' maxLength=128}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataLanguage' __text='Language'}
        {formlanguageselector group='meta' id='metadataLanguage' mandatory=false __title='Choose a language' dataField='language'}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataRelation' __text='Relation'}
        {formtextinput group='meta' id='metadataRelation' dataField='relation' maxLength=255}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataCoverage' __text='Coverage'}
        {formtextinput group='meta' id='metadataCoverage' dataField='coverage' maxLength=64}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataComment' __text='Comment'}
        {formtextinput group='meta' id='metadataComment' dataField='comment' maxLength=255}
    </div>

    <div class="z-formrow">
        {formlabel for='metadataExtra' __text='Extra'}
        {formtextinput group='meta' id='metadataExtra' dataField='extra' maxLength=255}
    </div>
</fieldset>
