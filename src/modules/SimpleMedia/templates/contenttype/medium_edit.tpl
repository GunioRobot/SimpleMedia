{* Purpose of this template: edit view of content type for specific file inclusion *}

<div style="margin-left: 80px">
<div{* class="z-formrow"*}>
    {simplemediaSelectorMedium id='id' group='data'}
</div>

<div{* class="z-formrow"*}>
    {formradiobutton id='linkButton' value='link' dataField='displayMode' group='data' mandatory=1}
    {formlabel for='linkButton' __text='Insert link to file'}
    {formradiobutton id='embedButton' value='embed' dataField='displayMode' group='data' mandatory=1}
    {formlabel for='embedButton' __text='Embed file'}
</div>

<div id="imgArea">
    <br />
    <br />
    <p>{gt text='Only for images:'}</p>
    <div{* class="z-formrow"*} style="margin-left: 40px">
        {formradiobutton id='nozoomButton' value='nozoom' dataField='zoomMode' group='data' mandatory='1'} 
        {formlabel for='nozoomButton' __text='No zoom'}
        {formradiobutton id='normalZoomButton' value='normalzoom' dataField='zoomMode' group='data' mandatory=1} 
        {formlabel for='normalZoomButton' __text='Normal zoom'}
        {formradiobutton id='innerZoomButton' value='innerzoom' dataField='zoomMode' group='data' mandatory=1} 
        {formlabel for='innerZoomButton' __text='Inner zoom'}
    </div>

    <div{* class="z-formrow"*} style="margin-left: 40px" id="thumbSizeRow">
        {foreach name='thumbLoop' item='thumbSize' from=$modvars.SimpleMedia.thumbDimensions}
            {formradiobutton id="thumbnr`$smarty.foreach.thumbLoop.iteration`" value=$smarty.foreach.thumbLoop.iteration dataField='thumbnr' group='data' mandatory=1} 
            {formlabel for="thumbnr`$smarty.foreach.thumbLoop.iteration`" text="`$thumbSize.width` x `$thumbSize.height` px"}
        {/foreach}
        {formradiobutton id='originalSize' value='original' dataField='thumbnr' group='data' mandatory=1} 
        {formlabel for='originalSize' __text='Original'}
    </div>
    <br />
    <br />
</div>
</div>
