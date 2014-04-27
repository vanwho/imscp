<?php
/**
 * i-MSCP - internet Multi Server Control Panel
 *
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
 *
 * @copyright   2001-2006 by moleSoftware GmbH
 * @copyright   2006-2010 by ispCP | http://isp-control.net
 * @copyright   2010-2014 by i-MSCP | http://i-mscp.net
 * @link        http://i-mscp.net
 * @author      ispCP Team
 * @author      i-MSCP Team
 */

require_once 'php-gettext/gettext.inc';

/**
 * Translates the given message into the selected language, if exists and apply the tohtml() method to it
 *
 * @author Laurent Declercq (nuxwin) <l.declercq@nuxwin.com>
 * @param string $msgid string to translate
 * @internal param mixed $substitution Substitution value(s)
 * @return string Translated or original message
 */
function tr($msgid)
{
	$msgid = T_($msgid);

	$argv = func_get_args();

	if(func_num_args() > 1) {
		unset($argv[0]);

		if(!empty($argv) && is_bool($argv[1])) { // Ensure backward compatibility with plugins
			unset($argv[1]);
		}

		return vsprintf($msgid, $argv);
	}

	return replace_html(tohtml($msgid));
}

function tr_e($msgid)
{
	$msgid = T_($msgid);

	$argv = func_get_args();

	if(func_num_args() > 1) {
		unset($argv[0]);

		if(!empty($argv) && is_bool($argv[1])) { // Ensure backward compatibility with plugins
			unset($argv[1]);
		}

		return vsprintf($msgid, $argv);
	}

	echo replace_html(tohtml($msgid));
}

/**
 * Get language name
 *
 * @param string $lang language
 * @return string
 */
function i18n_languageName($lang)
{
	switch ($lang) {
		case 'af':
			return 'Afrikaans - Afrikaans';
		case 'ar':
			return 'Arabic - &#1575;&#1604;&#1593;&#1585;&#1576;&#1610;&#1577; &nbsp;';
		case 'az':
			return 'Azerbaijani - Azərbaycan dili';
		case 'be':
			return 'Belarusian - Беларуская';
		case 'bg_BG':
			return 'Bulgarian - български език';
		case 'bn':
			return 'Bengali - বাংলা';
		case 'br':
			return 'Breton - Brezhoneg';
		case 'bs':
			return 'Bosnian - Bosanski jezik';
		case 'ca_ES':
			return 'Catalan - Català';
		case 'cs_CZ':
			return 'Czech - Čeština';
		case 'cy':
			return 'Welsh - Cymraeg';
		case 'da_DK':
			return 'Danish - Dansk';
		case 'de_DE':
			return 'German - Deutsch';
		case 'el':
			return 'Greek - Ελληνικά';
		case 'en':
			return 'English';
		case 'en_GB':
			return 'English (United Kingdom)';
		case 'es_AR':
			return 'Spanish (Argentina) - Español (Argentina)';
		case 'es_ES':
			return 'Spanish - Español';
		case 'et':
			return 'Estonian - Eesti keel';
		case 'eu_ES':
			return 'Basque - Euskara';
		case 'fa_IR':
			return 'Persian - &#1601;&#1575;&#1585;&#1587;&#1740; &nbsp;';
		case 'fi_FI':
			return 'Finnish - Suomen kieli';
		case 'fr_FR':
			return 'French - Français';
		case 'gl_ES':
			return 'Galician - Galego';
		case 'he':
			return 'Hebrew - ‫עברית';
		case 'hi':
			return 'Hindi - हिन्दी ; हिंदी';
		case 'hr':
			return 'Croatian - Hrvatski';
		case 'hu_HU':
			return 'Hungarian - Magyar';
		case 'hy':
			return 'Armenian - Հայերէն';
		case 'ia':
			return 'Interlingua - Interlingua';
		case 'id':
			return 'Indonesian - Bahasa Indonesia';
		case 'it_IT':
			return 'Italian - Italiano';
		case 'ja_JP':
			return 'Japanese - 日本語 (にほんご)';
		case 'ko':
			return 'Korean - 한국어 (韓國語)';
		case 'ka':
			return 'Georgian - ქართული';
		case 'kk':
			return 'Kazakh - Қазақ тілі';
		case 'kn':
			return 'Kannada - ಕನ್ನಡ';
		case 'ky':
			return 'Kirghiz - кыргыз тили';
		case 'lt_LT':
			return 'Lithuanian - Lietuvių kalba';
		case 'lv':
			return 'Latvian - Latviešu valoda';
		case 'mk':
			return 'Macedonian - македонски јазик';
		case 'ml':
			return 'Malayalam - മലയാളം';
		case 'mn':
			return 'Mongolian - Монгол';
		case 'ms':
			return 'Malay - بهاس ملايو';
		case 'nb_NO':
			return 'Norwegian - Norsk bokmål';
		case 'nl_NL':
			return 'Dutch - Nederlands';
		case 'pa':
			return 'Panjabi - ਪੰਜਾਬੀ';
		case 'pl_PL':
			return 'Polish - Polski';
		case 'pt_BR':
			return 'Brazilian Portuguese - Brazilian Português';
		case 'pt_PT':
			return 'Portuguese - Português';
		case 'ro_RO':
			return 'Romanian - Română';
		case 'ru_RU':
			return 'Russian - русский язык';
		case 'si':
			return 'Sinhalese - සිංහල';
		case 'sk_SK':
			return 'Slovak - Slovenčina';
		case 'sl':
			return 'Slovene - Slovenščina';
		case 'sq':
			return 'Albanian - Shqip';
		case 'sr':
			return 'Serbian - српски језик';
		case 'sv_SE':
			return 'Swedish - Svenska';
		case 'ta':
			return 'Tamil - தமிழ்';
		case 'te':
			return 'Telugu - తెలుగు';
		case 'th_TH':
			return 'Thai - ไทย';
		case 'tk':
			return 'Turkmen - Türkmen';
		case 'tr_TR':
			return 'Turkish - Türkçe';
		case 'tt':
			return 'Tatar - татарча';
		case 'ug':
			return 'Uighur - Uyƣurqə';
		case 'uk_UA':
			return 'Ukrainian - українська мова';
		case 'ur':
			return 'Urdu - ‫اردو';
		case 'uz':
			return 'Uzbek - أۇزبېك';
		case 'vi':
			return 'Viêt Namese - Tiếng Việt';
		case 'zh_HK':
				return 'Chinese (Hong Kong) - 中國（香港）';
		case 'zh_TW':
			return 'Chinese (Taiwan) - 中国（台湾）';
		case 'zh_CN':
			return 'Chinese (China) - 中文（中国）';
	}

	return "Unknown - $lang";
}

/**
 * Build languages index from machine object files.
 *
 * @author Laurent Declercq <l.declercq@nuxwin.com>
 * @return void
 */
function i18n_buildLanguageIndex()
{
	/** @var $cfg iMSCP_Config_Handler_File */
	$cfg = iMSCP_Registry::get('config');

	$languageDir = new RecursiveIteratorIterator(
		new RecursiveDirectoryIterator($cfg['GUI_ROOT_DIR'] . '/i18n/locales/', FilesystemIterator::SKIP_DOTS)
	);

	$availableLanguages = array();

	/** @var $languageFile SplFileInfo */
	foreach ($languageDir as $languageFile) {
		if (strlen($basename = $languageFile->getBasename()) > 8) {
			continue;
		}

		if ($languageFile->isReadable()) {
			$parser = new iMSCP_I18n_Parser_Mo($languageFile->getPathname());
			$translationTable = $parser->getTranslationTable();

			if(!empty($translationTable)) {
				$poRevisionDate = DateTime::createFromFormat('Y-m-d H:i O', $parser->getPotCreationDate());

				$locale = $parser->getLanguage();

				$availableLanguages[$basename] = array(
					'locale' => $locale,
					'revision' => $poRevisionDate->format('Y-m-d H:i'),
					'translatedStrings' => $parser->getNumberOfTranslatedStrings(),
					'lastTranslator' => $parser->getLastTranslator()
				);

				$availableLanguages[$basename]['language'] =  i18n_languageName($locale);
			}
		}
	}

	/** @var $dbConfig iMSCP_Config_Handler_Db */
	$dbConfig = iMSCP_Registry::get('dbConfig');

	sort($availableLanguages);
	$serializedData = serialize($availableLanguages);
	$dbConfig->AVAILABLE_LANGUAGES = $serializedData;
	$cfg->AVAILABLE_LANGUAGES = $serializedData;
}

/**
 * Returns list of available languages with some informations
 *
 * Note: For safe reasons, only the files that are readable will be indexed.
 *
 * @author Laurent Declercq <l.declercq@nuxwin.com>
 * @return array Array that contains information about available languages
 */
function i18n_getAvailableLanguages()
{
	/** @var $cfg iMSCP_Config_Handler_File */
	$cfg = iMSCP_Registry::get('config');

	if (!isset($cfg->AVAILABLE_LANGUAGES) || !isSerialized($cfg->AVAILABLE_LANGUAGES)) {
		i18n_buildLanguageIndex();
	}

	return unserialize($cfg->AVAILABLE_LANGUAGES);
}

/**
 * Returns name of domain being used
 *
 * Note: See #130 for further explaination.
 *
 * @author Laurent Declercq <l.declercq@nuxwin.com>
 * @throws iMSCP_Exception
 * @param string $upstreamDomain Upstream domain name
 * @return string Domain being used
 */
function i18n_getDomain($upstreamDomain)
{
	/** @var $cfg iMSCP_Config_Handler_File */
	$cfg = iMSCP_Registry::get('config');

	$domainDirectory = $cfg->GUI_ROOT_DIR . "/i18n/locales/$upstreamDomain/LC_MESSAGES";

	if (file_exists($domainDirectory . "/$upstreamDomain.mo")) {
		$upstreamFileModificationTime = filemtime($domainDirectory . "/$upstreamDomain.mo");
		$domain = $upstreamDomain . '_' . $upstreamFileModificationTime;
	} else {
		return $upstreamDomain;
	}

	if (!file_exists($domainDirectory . "/$domain.mo")) {
		if (!@copy($domainDirectory . "/$upstreamDomain.mo", $domainDirectory . "/$domain.mo")) {
			write_log("i18n: Unable to create $domainDirectory/$domain.mo domain file for production", E_USER_ERROR);
		} else {
			write_log("i18n: Created new machine object file $domainDirectory/$domain.mo for production.", E_USER_NOTICE);
			i18n_domainsGarbageCollector($domainDirectory, $domain . '.mo');
		}
	}

	return $domain;
}

/**
 * Garbage collector for domains translation files
 *
 * Note: See #130 for further explanations.
 *
 * @author Laurent Declercq <l.declercq@nuxwin.com>
 * @param string $domainDirectory Current domain directory path
 * @param string $skipDomain Domain that must not be removed
 * @return void
 */
function i18n_domainsGarbageCollector($domainDirectory, $skipDomain)
{
	$currentDomainFilepath = $domainDirectory . '/' . $skipDomain;
	$domainsFiles = glob($domainDirectory . '/*_*_*.mo');

	foreach ($domainsFiles as $file) {
		if ($file != $currentDomainFilepath) {
			if (@unlink($file)) {
				write_log("i18n: Removed $file machine object production file.", E_USER_NOTICE);
			} else {
				write_log("i18n: Unable to remove $file machine object production file.", E_USER_ERROR);
			}
		}
	}
}

/**
 * Import Machine object file in languages directory
 *
 * @author Laurent Declercq <l.declercq@nuxwin.com>
 * @return bool TRUE on success, FALSE otherwise
 */
function i18n_importMachineObjectFile()
{
	// closure that is run before move_uploaded_file() function - See the Utils_UploadFile() function for further
	// information about implementation details
	$beforeMove = function () {
		/** @var $cfg iMSCP_Config_Handler_File */
		$cfg = iMSCP_Registry::get('config');
		$localesDirectory = $cfg['GUI_ROOT_DIR'] . '/i18n/locales';

		$filePath = $_FILES['languageFile']['tmp_name'];

		if (!is_readable($filePath)) {
			set_page_message(tr('File is not readable.'), 'error');
			return false;
		}

		try {
			$parser = new iMSCP_I18n_Parser_Mo($filePath);
			$encoding = $parser->getContentType();
			$locale = $parser->getLanguage();
			$revision = $parser->getPoRevisionDate();
			$lastTranslator = $parser->getLastTranslator();
		} catch (iMSCP_Exception $e) {
			set_page_message(tr('Only gettext Machine Object files (MO files) are accepted.'), 'error');
			return false;
		}

		if (empty($encoding) || empty($locale) || empty($revision) || empty($lastTranslator)) {
			set_page_message(
				tr("%s is not a valid i-MSCP language file.", $_FILES['languageFile']['name']), 'error'
			);
			return false;
		}

		if (!is_dir("$localesDirectory/$locale")) {
			if (!@mkdir("$localesDirectory/$locale", 0700)) {
				set_page_message(tr("Unable to create the %s directory for language file.", $locale), 'error');
				return false;
			}
		}

		if (!is_dir("$localesDirectory/$locale/LC_MESSAGES")) {
			if (!@mkdir("$localesDirectory/$locale/LC_MESSAGES", 0700)) {
				set_page_message(tr("Unable to create 'LC_MESSAGES' directory for language file."), 'error');
				return false;
			}
		}

		// Return destination file path
		return "$localesDirectory/$locale/LC_MESSAGES/$locale.mo";
	};

	if (utils_uploadFile('languageFile', array($beforeMove)) === false) {
		return false;
	}

	// Rebuild language index
	i18n_buildLanguageIndex();
	return true;
}

/**
 * Change panel default language
 *
 * @author Laurent Declercq <l.declercq@nuxwin.com>
 * @return bool TRUE if language name is valid, FALSE otherwise
 */
function i18n_changeDefaultLanguage()
{
	if (isset($_POST['defaultLanguage'])) {
		/** @var $cfg iMSCP_Config_Handler_File */
		$cfg = iMSCP_Registry::get('config');

		/** @var $dbConfig iMSCP_Config_Handler_Db */
		$defaultLanguage = clean_input($_POST['defaultLanguage']);
		$availableLanguages = i18n_getAvailableLanguages();

		// Check for language availability
		$isValidLanguage = false;
		foreach ($availableLanguages as $languageDefinition) {
			if ($languageDefinition['locale'] == $defaultLanguage) {
				$isValidLanguage = true;
			}
		}

		if (!$isValidLanguage) return false;

		/** @var $dbConfig iMSCP_Config_Handler_Db */
		$dbConfig = iMSCP_Registry::get('dbConfig');
		$dbConfig->USER_INITIAL_LANG = $defaultLanguage;
		$cfg->USER_INITIAL_LANG = $defaultLanguage;

		// Ensures language change on next load for current user in case he has not yet his gui properties explicitly
		// set (eg. for the first admin user when i-MSCP was just installed
		$stmt = exec_query('SELECT lang  FROM user_gui_props WHERE user_id = ?', $_SESSION['user_id']);

		if ($stmt->fields['lang'] == null) {
			unset($_SESSION['user_def_lang']);
		}
	} else {
		return false;
	}

	return true;
}
