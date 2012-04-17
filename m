From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] of/i2c: call i2c_verify_client from of_find_i2c_device_by_node
Date: Tue, 17 Apr 2012 12:42:15 -0600
Message-ID: <1334688135-8355-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

i2c_bus_type may contain both I2C clients and I2C adapters. Fix
of_find_i2c_device_by_node to call i2c_verify_client to ensure that it
only returns non-NULL of I2C clients.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Note: This is a dependency for the pinctrl I2C bus mux I will send in a
minute. It'd probably be easiest to merge this through the I2C tree.
It might also be useful to put this patch (and the others I'll send) in
a separate tree so it can be merged into any SoC trees that wish to use
this new feature.

 drivers/of/of_i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index f37fbeb..0684887 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -90,7 +90,7 @@ struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 	if (!dev)
 		return NULL;
 
-	return to_i2c_client(dev);
+	return i2c_verify_client(dev);
 }
 EXPORT_SYMBOL(of_find_i2c_device_by_node);
 
-- 
1.7.0.4
