From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 13/21] i2c: core: Probe i2c master devices on demand
Date: Mon, 25 May 2015 16:53:17 +0200
Message-ID: <1432565608-26036-14-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: =?UTF-8?q?St=C3=A9phane=20Marchesin?= <stephane.marchesin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

When looking up an i2c master through its DT node, ensure that the
corresponding device has been registered.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 987c124..8c9352e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -40,6 +40,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/of_platform.h>
 #include <linux/clk/clk-conf.h>
 #include <linux/completion.h>
 #include <linux/hardirq.h>
@@ -1339,6 +1340,8 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 {
 	struct device *dev;
 
+	of_platform_device_ensure(node);
+
 	dev = bus_find_device(&i2c_bus_type, NULL, node,
 					 of_dev_node_match);
 	if (!dev)
-- 
2.4.1
