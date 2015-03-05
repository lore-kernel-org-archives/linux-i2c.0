From: =?UTF-8?Q?Michael_G=C3=B6hler?= <visit-rE2GDwZd62U@public.gmane.org>
Subject: [PATCH] i2c-tools: py-smbus linker issue in arch
Date: Thu, 05 Mar 2015 13:36:51 +0100
Message-ID: <d2aeb8ce046071b00780df2656945101@myjm.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_75e788b908dea277f554a2ad93c19dff"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--=_75e788b908dea277f554a2ad93c19dff
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

Hi,

this fixes a linker issue in py-smbus for Arch-Linux 
(https://aur.archlinux.org/packages/python-smbus/) and makes it possible 
to run setup.py independently again.

Thanks!
--=_75e788b908dea277f554a2ad93c19dff
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=i2c-tools-arch-linker-issue.patch
Content-Disposition: attachment;
 filename=i2c-tools-arch-linker-issue.patch;
 size=901

SW5kZXg6IHB5LXNtYnVzL01vZHVsZS5tawo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBweS1zbWJ1cy9Nb2R1bGUu
bWsJKHJldmlzaW9uIDYyNzcpCisrKyBweS1zbWJ1cy9Nb2R1bGUubWsJKHdvcmtpbmcgY29weSkK
QEAgLTEyLDcgKzEyLDcgQEAKIFBZVEhPTiA/PSBweXRob24KIERJU1RVVElMUyA6PSBcCiAJY2Qg
JChQWV9TTUJVU19ESVIpICYmIFwKLQlDUFBGTEFHUz0iJChDUFBGTEFHUykgLUkuLi9pbmNsdWRl
IiBMREZMQUdTPSIkKExERkxBR1MpIC1MbGliIC1saTJjIiAkKFBZVEhPTikgc2V0dXAucHkKKwkk
KFBZVEhPTikgc2V0dXAucHkKIAogYWxsLXB5dGhvbjogJChJTkNMVURFX0RJUikvaTJjL3NtYnVz
LmgKIAkkKERJU1RVVElMUykgYnVpbGQKSW5kZXg6IHB5LXNtYnVzL3NldHVwLnB5Cj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIHB5LXNtYnVzL3NldHVwLnB5CShyZXZpc2lvbiA2Mjc3KQorKysgcHktc21idXMvc2V0
dXAucHkJKHdvcmtpbmcgY29weSkKQEAgLTExLDQgKzExLDEwIEBACiAJbWFpbnRhaW5lcl9lbWFp
bD0ibGludXgtaTJjQHZnZXIua2VybmVsLm9yZyIsCiAJbGljZW5zZT0iR1BMdjIiLAogCXVybD0i
aHR0cDovL2xtLXNlbnNvcnMub3JnLyIsCi0JZXh0X21vZHVsZXM9W0V4dGVuc2lvbigic21idXMi
LCBbInNtYnVzbW9kdWxlLmMiXSldKQorCWV4dF9tb2R1bGVzPVtFeHRlbnNpb24oCisJCSJzbWJ1
cyIsCisJCVsic21idXNtb2R1bGUuYyJdLAorCQlleHRyYV9jb21waWxlX2FyZ3M9WyctSS4uL2lu
Y2x1ZGUnXSwKKwkJZXh0cmFfbGlua19hcmdzPVsnLWxpMmMnXQorCSldCispCg==
--=_75e788b908dea277f554a2ad93c19dff--
