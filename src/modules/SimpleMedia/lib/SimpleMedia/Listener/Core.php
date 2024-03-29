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
 * Event handler implementation class for core events.
 */
class SimpleMedia_Listener_Core
{
    /**
     * Listener for the `api.method_not_found` event.
     *
     * Called in instances of Zikula_Api from __call().
     * Receives arguments from __call($method, argument) as $args.
     *     $event['method'] is the method which didn't exist in the main class.
     *     $event['args'] is the arguments that were passed.
     * The event subject is the class where the method was not found.
     * Must exit if $event['method'] does not match whatever the handler expects.
     * Modify $event->data and $event->stop().
     */
    public static function apiMethodNotFound(Zikula_Event $event)
    {
    }

    /**
     * Listener for the `core.preinit` event.
     *
     * Occurs after the config.php is loaded.
     */
    public static function preInit(Zikula_Event $event)
    {
    }

    /**
     * Listener for the `core.init` event.
     *
     * Occurs after each `System::init()` stage, `$event['stage']` contains the stage.
     * To check if the handler should execute, do `if($event['stage'] & System::CORE_STAGES_*)`.
     */
    public static function init(Zikula_Event $event)
    {
    }

    /**
     * Listener for the `core.postinit` event.
     *
     * Occurs just before System::init() exits from normal execution.
     */
    public static function postInit(Zikula_Event $event)
    {
    }

    /**
     * Listener for the `controller.method_not_found` event.
     *
     * Called in instances of `Zikula_Controller` from `__call()`.
     * Receives arguments from `__call($method, argument)` as `$args`.
     *    `$event['method']` is the method which didn't exist in the main class.
     *    `$event['args']` is the arguments that were passed.
     * The event subject is the class where the method was not found.
     * Must exit if `$event['method']` does not match whatever the handler expects.
     * Modify `$event->data` and `$event->stop()`.
     */
    public static function controllerMethodNotFound(Zikula_Event $event)
    {
        // You can have multiple of these methods.
        // See system/Extensions/lib/Extensions/HookUI.php for an example.
    }
}
