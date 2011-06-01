<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{TR_CLIENT_MANAGE_SQL_PAGE_TITLE}</title>
<meta name="robots" content="nofollow, noindex" />
<meta http-equiv="Content-Type" content="text/html; charset={THEME_CHARSET}" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
  <link href="{THEME_COLOR_PATH}/css/imscp.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="{THEME_COLOR_PATH}/css/imscp.js"></script>
<!--[if lt IE 7.]>
<script defer type="text/javascript" src="{THEME_COLOR_PATH}/css/pngfix.js"></script>
<![endif]-->
  <script type="text/javascript">
<!--
function action_delete(url, sql) {
	if (!confirm(sprintf("{TR_MESSAGE_DELETE}", sql)))
		return false;
	location = url;
}
//-->
  </script>
 </head>

 <body onLoad="MM_preloadImages('{THEME_COLOR_PATH}/images/icons/database_a.png','{THEME_COLOR_PATH}/images/icons/domains_a.png','{THEME_COLOR_PATH}/images/icons/ftp_a.png','{THEME_COLOR_PATH}/images/icons/general_a.png' ,'{THEME_COLOR_PATH}/images/icons/email_a.png','{THEME_COLOR_PATH}/images/icons/webtools_a.png','{THEME_COLOR_PATH}/images/icons/statistics_a.png','{THEME_COLOR_PATH}/images/icons/support_a.png')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;padding:0;margin:0 auto;">
<!-- BDP: logged_from -->
<tr>
 <td colspan="3" height="20" nowrap="nowrap" class="backButton">&nbsp;&nbsp;&nbsp;<a href="change_user_interface.php?action=go_back"><img src="{THEME_COLOR_PATH}/images/icons/close_interface.png" width="16" height="16" border="0" style="vertical-align:middle" alt="" /></a> {YOU_ARE_LOGGED_AS}</td>
</tr>
<!-- EDP: logged_from -->
   <tr>
    <td align="left" valign="top" style="vertical-align: top; width: 195px; height: 56px;"><img src="{THEME_COLOR_PATH}/images/top/top_left.jpg" width="195" height="56" border="0" alt="i-MSCP Logogram" /></td>
    <td style="height: 56px; width:100%; background-color: #0f0f0f"><img src="{THEME_COLOR_PATH}/images/top/top_left_bg.jpg" width="582" height="56" border="0" alt="" /></td>
    <td style="width: 73px; height: 56px;"><img src="{THEME_COLOR_PATH}/images/top/top_right.jpg" width="73" height="56" border="0" alt="" /></td>
  </tr>
  <tr>
   <td style="width: 195px; vertical-align: top;">{MENU}</td>
   <td colspan="2" style="vertical-align: top;">
    <table style="width: 100%; padding:0;margin:0;" cellspacing="0">
     <tr style="height:95px;">
      <td style="padding-left:30px; width: 100%; background-image: url({THEME_COLOR_PATH}/images/top/middle_bg.jpg);">{MAIN_MENU}</td>
      <td style="padding:0;margin:0;text-align: right; width: 73px;vertical-align: top;"><img src="{THEME_COLOR_PATH}/images/top/middle_right.jpg" width="73" height="95" border="0" alt="" /></td>
     </tr>
     <tr>
      <td colspan="3">
       <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
         <td align="left">
          <table width="100%" cellpadding="5" cellspacing="5">
           <tr>
            <td width="25"><img src="{THEME_COLOR_PATH}/images/content/table_icon_sql.png" width="25" height="25" alt="" /></td>
             <td colspan="2" class="title">{TR_MANAGE_SQL}</td>
            </tr>
           </table>
          </td>
          <td width="27" align="right">&nbsp;</td>
         </tr>
         <tr>
          <td>
           <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
             <td width="40">&nbsp;</td>
             <td valign="top">
              <table width="100%" cellpadding="5" cellspacing="5">
               <!-- BDP: page_message -->
               <tr>
                <td colspan="4" class="title"><span class="message">{MESSAGE}</span></td>
               </tr>
               <!-- EDP: page_message -->
               <!-- BDP: db_list -->
               <tr>
                <td width="60%" class="content3">&nbsp;&nbsp;<b>{TR_DATABASE}</b></td>
                <td colspan="3" align="center" class="content3"><b>{TR_ACTION}</b></td>
               </tr>
               <tr>
                <td height="48" align="left" class="content4">&nbsp;&nbsp;&nbsp;<strong><img src="{THEME_COLOR_PATH}/images/icons/database_small.png" width="16" height="16" style="vertical-align:middle" alt="" />&nbsp;{DB_NAME}</strong></td>
                <td colspan="2" width="16%" align="left" class="content4">&nbsp;&nbsp;<img src="{THEME_COLOR_PATH}/images/icons/add_user.png" width="26" height="16" border="0" style="vertical-align:middle" alt="" />&nbsp;<a href="sql_user_add.php?id={DB_ID}" class="link">{TR_ADD_USER}</a></td>
                <td align="left" class="content4">&nbsp;&nbsp;<img src="{THEME_COLOR_PATH}/images/icons/delete.png" width="16" height="16" border="0" style="vertical-align:middle" alt="" />&nbsp;&nbsp;<a href="#" class="link" onClick="action_delete('sql_database_delete.php?id={DB_ID}', '{DB_NAME_JS}')">{TR_DELETE}</a></td>
               </tr>
               <!-- BDP: db_message -->
               <tr>
                <td height="28" colspan="4" class="title"><span class="message">&nbsp;&nbsp;{DB_MSG}</span></td>
               </tr>
               <!-- EDP: db_message -->
               <!-- BDP: user_list -->
               <tr class="hl">
                <td height="48" align="left" class="content">&nbsp;&nbsp;&nbsp;<img src="{THEME_COLOR_PATH}/images/icons/users.png" width="21" height="21" style="vertical-align:middle" alt="" />&nbsp;{DB_USER}</td>
                <td width="14%" align="left" class="content">&nbsp;&nbsp;&nbsp;<img src="{THEME_COLOR_PATH}/images/icons/pma.png" width="16" height="16" border="0" style="vertical-align:middle" alt="" />&nbsp;<a href="pma_auth.php?id={USER_ID}" class="link" target="_blank">{TR_PHP_MYADMIN}</a></td>
                <td align="left" class="content">&nbsp;&nbsp;<img src="{THEME_COLOR_PATH}/images/icons/change_password.png" width="16" height="16" border="0" style="vertical-align:middle" alt="" />&nbsp;<a href="sql_change_password.php?id={USER_ID}" class="link">{TR_CHANGE_PASSWORD}</a></td>
                <td align="left" class="content">&nbsp;&nbsp;<img src="{THEME_COLOR_PATH}/images/icons/delete.png" width="16" height="16" border="0" style="vertical-align:middle" alt="" />&nbsp;&nbsp;<a href="#" class="link" onClick="action_delete('sql_delete_user.php?id={USER_ID}', '{DB_USER_JS}')">{TR_DELETE}</a></td>
               </tr>
               <!-- EDP: user_list -->
               <!-- EDP: db_list -->
              </table>
             </td>
            </tr>
           </table>
          </td>
         </tr>
        </table>
       </td>
      </tr>
     </table>
    </td>
   </tr>
  </table>
 </body>
</html>