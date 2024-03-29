
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
 * Configuration handler implementation class
 */
class SimpleMedia_Form_Handler_Admin_Config extends SimpleMedia_Form_Handler_Admin_Base_Config
{
    /**
     * Initialise custom additions.
     */
    protected function initializeAdditions()
    {
        $helper = new SimpleMedia_Util_Manual();
        $config = $this->view->get_template_vars('config');

        if (!is_array($config['thumbDimensions'])) {
            // no thumb dimensions stored yet, so we set some default values
            $thumbSizes = $this->getDefaultThumbDimensions();
            $this->setVar('thumbDimensions', $thumbSizes);
            $config['thumbDimensions'] = $thumbSizes;
        }

        $config['cropSizeModeItems'] = $helper->getCropSizeModes();

        $this->view->assign('config', $config);

        return parent::initializeAdditions();
    }

    private function getDefaultThumbDimensions()
    {
        $thumbSizes = array();
        $thumbSizes[] = array('width' => 80, 'height' => 60);
        $thumbSizes[] = array('width' => 150, 'height' => 113);
        $thumbSizes[] = array('width' => 200, 'height' => 150);
        return $thumbSizes;
    }

    /**
     * Command event handler.
     */
    public function handleCommand(Zikula_Form_View $view, &$args)
    {
        if ($args['commandName'] == 'save') {
            // check if all fields are valid
            if (!$this->view->isValid()) {
                return false;
            }

            // retrieve form data
            $data = $this->view->getValues();

            $thumbSizeData = $data['thumbSizes'];
            $thumbSizes = array();
            $i = 1;
            while (!empty($thumbSizeData['thumb' . $i . 'width']) && !empty($thumbSizeData['thumb' . $i . 'height'])
                && is_numeric($thumbSizeData['thumb' . $i . 'width']) && is_numeric($thumbSizeData['thumb' . $i . 'width'])) {
                $thumbSizes[] = array('width' => $thumbSizeData['thumb' . $i . 'width'], 'height' => $thumbSizeData['thumb' . $i . 'height']);
                $i++;
            }
            if (!count($thumbSizes)) {
                $thumbSizes = $this->getDefaultThumbDimensions();
            }
            $data['config']['thumbDimensions'] = $thumbSizes;

            if ($data['config']['defaultThumbNumber'] > count($thumbSizes)) {
                $data['config']['defaultThumbNumber'] = 1;
            }


            // old from MA due to usage of formvolatile, not sure yet if this is still needed
            //$this->assign('thumbsizes', $thumbsizes);


            $maxSize = array('width' => 0, 'height' => 0);
            if ($data['config']['enableShrinking']) {
                $maxSize['width'] = $data['maxSize']['shrinkWidth'];
                $maxSize['height'] = $data['maxSize']['shrinkHeight'];
            }
            $data['config']['shrinkDimensions'] = $maxSize;

            // update all module vars
            if (!ModUtil::setVars('SimpleMedia', $data['config'])) {
                return $this->view->setErrorMsg($this->__('Error! Failed to set configuration variables.'));
            }

            LogUtil::registerStatus($this->__('Done! Module configuration updated.'));
        } else if ($args['commandName'] == 'cancel') {
            // nothing to do there
        }

        // redirect back to the config page
        $url = ModUtil::url('SimpleMedia', 'admin', 'config');
        return $this->view->redirect($url);
    }
}
