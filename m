From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] i2c: Make the return type of i2c_del_mux_adapter() void
Date: Sat,  9 Mar 2013 19:16:49 +0100
Message-ID: <1362853009-20789-7-git-send-email-lars@metafoo.de>
References: <1362853009-20789-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362853009-20789-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-i2c@vger.kernel.org

i2c_del_mux_adapter always returns 0 and none of it current users check its
return value anyway. It is also an essential requirement of the Linux device
driver model, that functions which may be called from a device's remove callback
to free resources provided by the device, are not allowed to fail. This is the
case for i2c_del_mux_adapter(), so make its return type void to make the
fact that it won't fail explicit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/i2c/i2c-mux.c   | 4 +---
 include/linux/i2c-mux.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 361b78d..7409ebb 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -191,14 +191,12 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 }
 EXPORT_SYMBOL_GPL(i2c_add_mux_adapter);
 
-int i2c_del_mux_adapter(struct i2c_adapter *adap)
+void i2c_del_mux_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_mux_priv *priv = adap->algo_data;
 
 	i2c_del_adapter(adap);
 	kfree(priv);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(i2c_del_mux_adapter);
 
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index 40cb05a..b5f9a00 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -42,7 +42,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 				int (*deselect) (struct i2c_adapter *,
 						 void *mux_dev, u32 chan_id));
 
-int i2c_del_mux_adapter(struct i2c_adapter *adap);
+void i2c_del_mux_adapter(struct i2c_adapter *adap);
 
 #endif /* __KERNEL__ */
 
-- 
1.8.0
