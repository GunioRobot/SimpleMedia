{* Purpose of this template: Shows mp3-files within the jw-media-player inline *}
<object id="sm{$idprefix}media{$medium.id}" type="application/x-shockwave-flash" data="{$baseurl}modules/SimpleMedia/lib/vendor/mp3/player.swf" width="200" height="20">
    <param name="movie" value="{$baseurl}modules/SimpleMedia/lib/vendor/mp3/player.swf" />
    <param name="bgcolor" value="#ffffff" />
    <param name="FlashVars" value="mp3={$medium.theFileFullPathURL}&amp;autoload=1&amp;showvolume=1&amp;showloading=always" />
    <p>
        Your browser does not support embedded flash files.<br />
        Please click <a href="{$medium.theFileFullPathURL}">here</a> to download the file you requested.<br />
        <a href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" title="Download Flash Player" target="_blank">
            {img src='logo_flash.png' alt='Download Flash Player'}
        </a>
    </p>
</object>
