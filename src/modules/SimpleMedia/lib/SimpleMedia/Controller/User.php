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
 * This is the User controller class providing navigation and interaction functionality.
 */
class SimpleMedia_Controller_User extends SimpleMedia_Controller_Base_User
{
    public function view($args)
    {
// DEBUG: permission check aspect starts
        $this->throwForbiddenUnless(SecurityUtil::checkPermission('SimpleMedia:UserView:', '::', ACCESS_EDIT));
// DEBUG: permission check aspect ends
        return parent::view($args);
    }

    public function display($args)
    {
// DEBUG: permission check aspect starts
        $this->throwForbiddenUnless(SecurityUtil::checkPermission('SimpleMedia:UserView:', '::', ACCESS_EDIT));
// DEBUG: permission check aspect ends
        return parent::display($args);
    }
}
