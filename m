From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH 5/6] i2c: Replace I2C_CROS_EC_TUNNEL dependency
Date: Wed, 19 Aug 2015 13:19:57 +0200
Message-ID: <1439983198-4696-6-git-send-email-javier@osg.samsung.com>
References: <1439983198-4696-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439983198-4696-1-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Gwendal Grignou <gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The ChromeOS EC tunnel I2C bus driver depend on CROS_EC_PROTO but
MFD_CROS_EC select CROS_EC_PROTO instead. Mixing select and depends
on is bad practice as it may lead to circular Kconfig dependencies.

Since the platform device that is matched with the I2C bus driver
is registered by the ChromeOS EC mfd driver, I2C_CROS_EC_TUNNEL
really depends on MFD_CROS_EC. And because this config option
selects CROS_EC_PROTO, that dependency is met as well. So make the
driver to depend on MFD_CROS_EC instead of CROS_EC_PROTO.

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>

---

 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0b798ae708fe..f25b508bbd71 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1130,7 +1130,7 @@ config I2C_SIBYTE
 
 config I2C_CROS_EC_TUNNEL
 	tristate "ChromeOS EC tunnel I2C bus"
-	depends on CROS_EC_PROTO
+	depends on MFD_CROS_EC
 	help
 	  If you say yes here you get an I2C bus that will tunnel i2c commands
 	  through to the other side of the ChromeOS EC to the i2c bus
-- 
2.4.3
