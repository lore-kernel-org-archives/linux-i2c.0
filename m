From: Phil Carmody <phil.carmody-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH] i2c: reduce parent checking to a NOOP in non-I2C_MUX case
Date: Wed, 26 Jun 2013 10:56:35 +0300
Message-ID: <1372233395-13663-1-git-send-email-phil.carmody@partner.samsung.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: ml.lawnick-Mmb7MZpHnFY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Phil Carmody <phil.carmody-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In 0826374 - i2c: Multiplexed I2C bus core support
core i2c code increased in size and complexity even when I2C_MUX
wasn't selected.

Turning this check into a constant NULL in the n case lets the
client functions in be simplified too, not needing to include
never-called calls to the mux-specific helpers.

Signed-off-by: Phil Carmody <phil.carmody-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>
---
 include/linux/i2c.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e988fa9..b3c4b8d 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -447,11 +447,13 @@ static inline void i2c_set_adapdata(struct i2c_adapter *dev, void *data)
 static inline struct i2c_adapter *
 i2c_parent_is_i2c_adapter(const struct i2c_adapter *adapter)
 {
+#if IS_ENABLED(I2C_MUX)
 	struct device *parent = adapter->dev.parent;
 
 	if (parent != NULL && parent->type == &i2c_adapter_type)
 		return to_i2c_adapter(parent);
 	else
+#endif
 		return NULL;
 }
 
-- 
1.7.9.5
