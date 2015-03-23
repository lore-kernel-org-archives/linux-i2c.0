From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH v2 3/4] i2c: slave: add documentation for i2c-slave-eeprom
Date: Mon, 23 Mar 2015 09:26:38 +0100
Message-ID: <1427099199-3628-4-git-send-email-wsa@the-dreams.de>
References: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427099199-3628-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---

Changes since V1: added acks

 Documentation/i2c/slave-eeprom-backend | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/i2c/slave-eeprom-backend

diff --git a/Documentation/i2c/slave-eeprom-backend b/Documentation/i2c/slave-eeprom-backend
new file mode 100644
index 00000000000000..c8444ef82acfa3
--- /dev/null
+++ b/Documentation/i2c/slave-eeprom-backend
@@ -0,0 +1,14 @@
+Linux I2C slave eeprom backend
+==============================
+
+by Wolfram Sang <wsa-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org> in 2014-15
+
+This is a proof-of-concept backend which acts like an EEPROM on the connected
+I2C bus. The memory contents can be modified from userspace via this file
+located in sysfs:
+
+	/sys/bus/i2c/devices/<device-direcory>/slave-eeprom
+
+As of 2015, Linux doesn't support poll on binary sysfs files, so there is no
+notfication when another master changed the content.
+
-- 
2.1.4
