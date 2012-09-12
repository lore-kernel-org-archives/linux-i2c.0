From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] at24: make module parameters changeable via sysfs
Date: Wed, 12 Sep 2012 11:43:32 +0200
Message-ID: <1347443012-21302-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The respective values are evaluated at each read/write, so no further
action is required than to change the perm argument to module_param.

Note there is no sanity check so root can make the driver effectively
unusable but that's what root is for :-)

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/misc/eeprom/at24.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ab1ad41..8a5a192 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -85,7 +85,7 @@ struct at24_data {
  * This value is forced to be a power of two so that writes align on p=
ages.
  */
 static unsigned io_limit =3D 128;
-module_param(io_limit, uint, 0);
+module_param(io_limit, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(io_limit, "Maximum bytes per I/O (default 128)");
=20
 /*
@@ -93,7 +93,7 @@ MODULE_PARM_DESC(io_limit, "Maximum bytes per I/O (de=
fault 128)");
  * it's important to recover from write timeouts.
  */
 static unsigned write_timeout =3D 25;
-module_param(write_timeout, uint, 0);
+module_param(write_timeout, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 2=
5)");
=20
 #define AT24_SIZE_BYTELEN 5
--=20
1.7.10.4
