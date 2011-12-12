{* Purpose of this template: Shows files within the windows media player inline *}
{assign var='playerWidth' value=' width="320"'}
{assign var='playerHeight' value=' height="260"'}
{*if $file.fileInfo.video.resolution_x ne ''}
    {assign var='playerWidth' value=" width=\"`$file.fileInfo.video.resolution_x`\""}
{/if}
{if $file.fileInfo.video.resolution_y ne ''}
    {* consider 45px additional height for the control toolbar * }
    {assign var='playerHeight' value=" height=\"`$file.fileInfo.video.resolution_y + 45`\""}
{/if*}
<!--[if !IE]> -->
    <object id="sm{$idprefix}media{$medium.id}"
            type="video/x-ms-wmv"
            data="{$medium.theFileFullPathURL}"
            {$playerWidth}{$playerHeight}>
        <param name="src" value="{$medium.theFileFullPathURL}" />
        <param name="controller" value="1" />
<!-- <![endif]-->
<!--[if IE]>
    <object id="sm{$idprefix}media{$medium.id}"
            classid="clsid:6BF52A52-394A-11d3-B153-00C04F79FAA6"
            codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,4,7,1112{* 6,4,5,715 *}"
            standby="Loading Microsoft Windows Media Player components..."
            type="application/x-oleobject"
            {$playerWidth}{$playerHeight}>
        <param name="url" value="{$medium.theFileFullPathURL}" />
        <param name="uimode" value="mini" />{* full, mini, none, invisible *}
        <param name="showcontrols" value="1" />
        <param name="showstatusbar" value="0" />
        <param name="autosize" Value="0" />
        <param name="displaysize" Value="0" />
        <param name="animationatstart" value="0" />
        <param name="transparentatstart" value="1" />
<!--><!---->
        <param name="autostart" value="1" />
{*        <param name="volume" value="-200" />*}
        <p>
            Your browser does not support embedded windows media files.<br />
            Please click <a href="{$medium.theFileFullPathURL}">here</a> to download the file you requested.<br />
            <a href="http://www.microsoft.com/windows/windowsmedia/" title="Download Windows Media Player" target="_blank">
                {img src='logo_wmp.png' alt='Download Windows Media Player'}
            </a>
        </p>
    </object>
<!-- <![endif]-->