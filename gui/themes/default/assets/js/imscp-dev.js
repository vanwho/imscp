/**
 * i-MSCP - internet Multi Server Control Panel
 *
 * @copyright   2001-2006 by moleSoftware GmbH
 * @copyright   2006-2010 by ispCP | http://isp-control.net
 * @copyright   2010-2014 by i-MSCP | http://i-mscp.net
 * @link        http://i-mscp.net
 * @author      ispCP Team
 * @author      i-MSCP Team
 *
 * @license
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Original Code is "VHCS - Virtual Hosting Control System".
 *
 * The Initial Developer of the Original Code is moleSoftware GmbH.
 * Portions created by Initial Developer are Copyright (C) 2001-2006
 * by moleSoftware GmbH. All Rights Reserved.
 *
 * Portions created by the ispCP Team are Copyright (C) 2006-2010 by
 * isp Control Panel. All Rights Reserved.
 *
 * Portions created by the i-MSCP Team are Copyright (C) 2010-2014 by
 * i-MSCP - internet Multi Server Control Panel. All Rights Reserved.
 */

/**
 * test/validate JavaScript code with JSLint - The JavaScript Verifier
 * see http://www.jslint.com/
 *
 * to remove comments and unnecessary whitespace use jsmin
 * see http://crockford.com/javascript/jsmin
 * try to add a hint/link to the full JS code in the compressed file, sth. like:
 * // see ispcp_full.js for full JS code & license
 *
 * This JavaScript code minimum needs support of JavaScript 1.2.
 *
 * @todo these functions need more doumentation (description/param/return)
 */


/**
 * @todo try to merge this function with function sbmt_details()
 */
function sbmt(form, uaction) {
	form.uaction.value = uaction;
	form.submit();

	return false;
}


/**
 * @todo try to merge this function with function sbmt()
 */
function sbmt_details(form, uaction) {
	form.details.value = uaction;
	form.submit();

	return false;
}

/**
 * Display dialog box allowing to choose ftp directory
 *
 * @return false
 */
function chooseFtpDir() {
		var dialog1 = $('<div id="dial_ftp_dir" style="overflow: hidden;"/>').append($('<iframe scrolling="auto" height="100%"/>').
			attr("src", "ftp_choose_dir.php")).dialog(
			{
				hide: 'blind',
				show:'slide',
				focus: false,
				width: 650,
				height:650,
				autoOpen: false,
				modal: true,
				title: js_i18n_tr_ftp_directories,
				buttons: [ {text: js_i18n_tr_close, click: function(){ $(this).dialog('close'); } } ],
				close: function (e, ui) {
					$(this).remove();
				}
			}
		);

		$(window).resize(function() {
        	dialog1.dialog("option", "position", { my: "center", at: "center", of: window });
        });

		$(window).scroll(function() {
			dialog1.dialog("option", "position", { my: "center", at: "center", of: window });
		});

    dialog1.dialog('open');

    return false;
}

/*******************************************************************************
*
* Ajax related functions
*
* Note: require JQUERY
*/

/**
* Jquery XMLHttpRequest Error Handling
*/

/**
* Must be documented
*
* Note: Should be used as error callback funct of the jquery ajax request
* @since r2587
*/
function iMSCPajxError(xhr, settings, exception) {

	switch (xhr.status) {
		// We receive this status when the session is expired
		case 403:
			window.location = '/index.php';
		break;
		default:
			alert('HTTP ERROR: An Unexpected HTTP Error occurred during the request');
	}
}


// Override some built-in jQuery method to trigger the i-MSCP updateTable event
(function($) {
	var origShow = $.fn.show;
	var origHide = $.fn.hide;
	var origAppendTo = $.fn.appendTo;
	var origPrependTo = $.fn.prependTo;
	var origHtml = $.fn.html;
	$.fn.show = function () { return origShow.apply(this, arguments).trigger("updateTable");};
	$.fn.hide = function () { return origHide.apply(this, arguments).trigger("updateTable");};
	$.fn.appendTo = function () { return origAppendTo.apply(this, arguments).trigger("updateTable");};
	$.fn.prependTo = function () { return origPrependTo.apply(this, arguments).trigger("updateTable");};
	$.fn.html = function () { var ret = origHtml.apply(this, arguments); $('tbody').trigger("updateTable"); return ret;};
})(jQuery);

// decode html entities
function html_entity_decode(str)
{
	return $("<div/>").html(str).text();
}
