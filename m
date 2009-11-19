From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] MAINTAINERS: Add missing i2c files
Date: Thu, 19 Nov 2009 18:25:16 +0100
Message-ID: <20091119182516.243fe87a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add missing header files to the i2c subsystem section.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 MAINTAINERS |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.32-rc7.orig/MAINTAINERS	2009-11-19 17:52:32.000000000 +0100
+++ linux-2.6.32-rc7/MAINTAINERS	2009-11-19 17:58:33.000000000 +0100
@@ -2533,8 +2533,7 @@ S:	Maintained
 F:	Documentation/i2c/
 F:	drivers/i2c/
 F:	include/linux/i2c.h
-F:	include/linux/i2c-dev.h
-F:	include/linux/i2c-id.h
+F:	include/linux/i2c-*.h
 
 I2C-TINY-USB DRIVER
 M:	Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>


-- 
Jean Delvare
