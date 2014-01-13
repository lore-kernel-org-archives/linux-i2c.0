From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] i2c: Re-instate body of i2c_parent_is_i2c_adapter()
Date: Mon, 13 Jan 2014 14:29:04 -0700
Message-ID: <1389648544-4201-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Phil Carmody <phil.carmody-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The body of i2c_parent_is_i2c_adapter() is currently guarded by
CONFIG_I2C_MUX instead.

Among potentially other problems, this resulted in i2c_lock_adapter()
only locking I2C mux child adapters, and not the parent adapter. In
turn, this could allow inter-mingling of mux child selection and I2C
transactions, which could result in I2C transactions being directed to
the wrong I2C bus, and possibly even switching between busses in the
middle of a transaction.

One concrete issue caused by this bug was corrupted HDMI EDID reads
during boot on the NVIDIA Tegra Seaboard system, although this only
became apparent in recent linux-next, when the boot timing was changed
just enough to trigger the race condition.

Fixes: 3923172b3d70 ("i2c: reduce parent checking to a NOOP in non-I2C_MUX case")
Cc: Phil Carmody <phil.carmody-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/linux/i2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index eff50e062be8..d9c8dbd3373f 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -445,7 +445,7 @@ static inline void i2c_set_adapdata(struct i2c_adapter *dev, void *data)
 static inline struct i2c_adapter *
 i2c_parent_is_i2c_adapter(const struct i2c_adapter *adapter)
 {
-#if IS_ENABLED(I2C_MUX)
+#if IS_ENABLED(CONFIG_I2C_MUX)
 	struct device *parent = adapter->dev.parent;
 
 	if (parent != NULL && parent->type == &i2c_adapter_type)
-- 
1.8.1.5
