{* Purpose of this template: Shows a flash file inline *}
{assign var='playerWidth' value=''}
{assign var='playerHeight' value=''}
{php}
    $medium = $this->get_template_vars('medium');
    $fileInfo = @getimagesize($medium);
    if (is_array($fileInfo)) {
        $this->assign('playerWidth', ' width="' . $fileInfo[0] . '"');
        $this->assign('playerHeight', ' height="' . $fileInfo[1] . '"');
    }
{/php}
{*if $file.fileInfo.swf && $file.fileInfo.swf.bgcolor}
    {assign var='bgcolor' value="#`$file.fileInfo.swf.bgcolor`"}
{else*}
    {assign var='bgcolor' value='#FFFFFF'}
{*/if*}
<!--[if !IE]> -->
    <object id="sm{$idprefix}media{$medium.id}"
            type="application/x-shockwave-flash"
            data="{$medium.theFileFullPathURL}"
            {$playerWidth}{$playerHeight}>
        <param name="pluginurl" value="http://www.macromedia.com/go/getflashplayer" />
<!-- <![endif]-->
<!--[if IE]>
    <object id="sm{$idprefix}media{$medium.id}"
            classid="clsid:D27CDB6E-AE6D-11CF-96B8-444553540000"
            codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
            {$playerWidth}{$playerHeight}>
        <param name="movie" value="{$medium.theFileFullPathURL}" />
<!--><!---->
        <param name="quality" value="high" />
        <param name="menu" value="0" />
        <param name="scale" value="showall" />
        <param name="bgcolor" value="{$bgcolor}" />
        <param name="salign" value="TL" />
        <param name="FlashVars" value="playerMode=embedded" />
        <param name="allowScriptAcess" value="sameDomain" />
        {* we are not using the following param tag because it breaks Opera compatibility *}
        {* <param name="wmode" value="transparent" /> *}
        {* <param name="wmode" value="opaque" /> *}
        <p>
            Your browser does not support embedded flash files.<br />
            Please click <a href="{$medium.theFileFullPathURL}">here</a> to download the file you requested.<br />
            <a href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" title="Download Flash Player" target="_blank">
                {img src='logo_flash.png' alt='Download Flash Player'}
            </a>
        </p>
    </object>
<!-- <![endif]-->