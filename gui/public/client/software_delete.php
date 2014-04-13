<?php
/**
 * i-MSCP - internet Multi Server Control Panel
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 * @category    iMSCP
 * @package     iMSCP_Core
 * @subpackage  Client
 * @copyright   2010-2014 by i-MSCP team
 * @author      Sacha Bay <sascha.bay@i-mscp.net>
 * @author      iMSCP Team
 * @link        http://www.i-mscp.net i-MSCP Home Site
 * @license     http://www.gnu.org/licenses/gpl-2.0.txt GPL v2
 */

// Include core library
require_once 'imscp-lib.php';

iMSCP_Events_Aggregator::getInstance()->dispatch(iMSCP_Events::onClientScriptStart);

check_login('user');

customerHasFeature('aps') or showBadRequestErrorPage();

if (isset($_GET['id'])) {
	$softwareId = intval($_GET['id']);
	$domainProps = get_domain_default_props($_SESSION['user_id']);
	$dmnId = $domainProps['domain_id'];

	$stmt = exec_query(
		'SELECT software_id, software_res_del FROM web_software_inst WHERE software_id = ? AND domain_id = ?',
		array($softwareId, $dmnId)
	);

	if (!$stmt->rowCount()) {
		showBadRequestErrorPage();
	} else {
		$row = $stmt->fetchRow(PDO::FETCH_ASSOC);

		if ($row['software_res_del'] === '1') {
			exec_query(
				'DELETE FROM web_software_inst WHERE software_id = ? AND domain_id = ?', array($softwareId, $dmnId)
			);

			set_page_message(tr('Software deleted.'), 'success');
		} else {
			exec_query(
				'UPDATE web_software_inst SET software_status = ? WHERE software_id = ? AND domain_id = ?',
				array('todelete', $softwareId, $dmnId)
			);

			send_request();
			set_page_message(tr('Software scheduled for deletion.'), 'success');
		}

		redirectTo('software.php');
	}
}

showBadRequestErrorPage();
