From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] MAINTAINERS: add maintainer for ACPI parts of I2C
Date: Tue, 19 Aug 2014 10:16:21 -0500
Message-ID: <1408461381-18463-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Mika has done great work in that field, so let people know.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---

Mika: What do you think? Your help is very valuable and I'd like to make that
official :)

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aefa94841ff3..edba18ce39bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4446,6 +4446,13 @@ F:	include/linux/i2c-*.h
 F:	include/uapi/linux/i2c.h
 F:	include/uapi/linux/i2c-*.h
 
+I2C ACPI SUPPORT
+M:	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+L:	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	drivers/i2c/i2c-acpi.c
+
 I2C-TAOS-EVM DRIVER
 M:	Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
 L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-- 
2.0.0
