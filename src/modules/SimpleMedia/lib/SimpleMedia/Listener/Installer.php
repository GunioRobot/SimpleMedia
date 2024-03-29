<?php
/**
 * SimpleMedia.
 *
 * @copyright Axel Guckelsberger
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SimpleMedia
 * @author Axel Guckelsberger <info@guite.de>.
 * @link http://zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.5.4 (http://modulestudio.de) at Mon Nov 28 12:34:51 CET 2011.
 */

/**
 * Event handler implementation class for module installer events.
 */
class SimpleMedia_Listener_Installer
{
    /**
     * Listener for the `installer.module.installed` event.
     *
     * Called after a module is successfully installed.
     * Receives `$modinfo` as args.
     */
    public static function moduleInstalled(Zikula_Event $event)
    {
    }

    /**
     * Listener for the `installer.module.upgraded` event.
     *
     * Called after a module is successfully upgraded.
     * Receives `$modinfo` as args.
     */
    public static function moduleUpgraded(Zikula_Event $event)
    {
    }

    /**
     * Listener for the `installer.module.uninstalled` event.
     *
     * Called after a module is successfully uninstalled.
     * Receives `$modinfo` as args.
     */
    public static function moduleUninstalled(Zikula_Event $event)
    {
    }

    /**
     * Listener for the `installer.subscriberarea.uninstalled` event.
     *
     * Called after a hook subscriber area is unregistered.
     * Receives args['areaid'] as the areaId.  Use this to remove orphan data associated with this area.
     */
    public static function subscriberAreaUninstalled(Zikula_Event $event)
    {
    }
}
