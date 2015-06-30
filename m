From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v1 02/10] i2c: core: Have clients point to their firmware nodes
Date: Tue, 30 Jun 2015 16:55:00 +0200
Message-ID: <1435676108-20590-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1435676108-20590-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435676108-20590-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is needed by platform-independent code that needs to do something
with devices based on the data provided by the firmware.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---

 drivers/i2c/i2c-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 069a41f..707850a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1295,6 +1295,7 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	}
 
 	info.of_node = of_node_get(node);
+	info.fwnode = info.of_node ? &info.of_node->fwnode : NULL;
 	info.archdata = &dev_ad;
 
 	if (of_get_property(node, "wakeup-source", NULL))
-- 
2.4.1
