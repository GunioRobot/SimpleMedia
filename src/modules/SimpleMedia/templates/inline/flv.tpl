{* Purpose of this template: Shows flv-files within the jw-flv-player inline *}
{assign var='playerWidth' value='200'}
{assign var='playerHeight' value='113'}
{php}
    $medium = $this->get_template_vars('medium');
    $fileInfo = @getimagesize($medium);
    if (is_array($fileInfo)) {
        $this->assign('playerWidth', $fileInfo[0]);
        $this->assign('playerHeight', $fileInfo[1]);
    }
{/php}
<!--[if !IE]> -->
    <object id="sm{$idprefix}media{$medium.id}"
            width="{$playerWidth}" 
            height="{$playerHeight+20}" 
            type="application/x-shockwave-flash" 
            data="{$baseurl}modules/SimpleMedia/lib/vendor/flvplayer/player.swf">
<!-- <![endif]-->
<!--[if IE]>
    <object id="sm{$idprefix}media{$medium.id}" 
            width="{$playerWidth}" 
            height="{$playerHeight+20}"
            classid="clsid:D27CDB6E-AE6D-11CF-96B8-444553540000"
            codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0">
        <param name="movie" value="{$baseurl}modules/SimpleMedia/lib/vendor/flvplayer/player.swf" />
<!--><!---->
        <param name="flashvars" value="file={$medium.theFileFullPathURL|urlencode}&amp;type=flv&amp;description={$medium.description}" />
        <param name="type" value="flv" />
        <param name="width" value="{$playerWidth}" />
        <param name="height" value="{$playerHeight+20}" />
        <param name="allowfullscreen" value="true" />
        <param name="shownavigation" value="true" />
        <p>
            Your browser does not support embedded flash files.<br />
            Please click <a href="{$medium.theFileFullPathURL}">here</a> to download the file you requested.<br />
            <a href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" title="Download Flash Player" target="_blank">
                {img src='logo_flash.png' alt='Download Flash Player'}
            </a>
        </p>
</object>
<!-- <![endif]-->