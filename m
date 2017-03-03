From: Qi Hou <qi.hou@windriver.com>
Subject: [PATCH] i2c: add missing of_node_put in i2c_mux_del_adapters
Date: Fri, 3 Mar 2017 15:57:11 +0800
Message-ID: <1488527831-53733-1-git-send-email-qi.hou@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: peda@axentia.se, stable@vger.kernel.org, robh@kernel.org, linux-i2c@vger.kernel.org
Cc: leif.lindholm@linaro.org, pantelis.antoniou@konsulko.com, grant.likely@linaro.org, bruce.ashfield@windriver.com, paul.gortmaker@windriver.com, xiao.zhang@windriver.com
List-Id: linux-i2c@vger.kernel.org

Refcount of of_node is increased with of_node_get() in i2c_mux_add_adapter().
It must be decreased with of_node_put() in i2c_mux_del_adapters().

Signe-off-by: Qi Hou <qi.hou@windriver.com>
Reviewed-by: Zhang Xiao <xiao.zhang@windriver.com>
Acked-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-mux.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 83768e8..2178266 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -429,6 +429,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 	while (muxc->num_adapters) {
 		struct i2c_adapter *adap = muxc->adapter[--muxc->num_adapters];
 		struct i2c_mux_priv *priv = adap->algo_data;
+		struct device_node *np = adap->dev.of_node;
 
 		muxc->adapter[muxc->num_adapters] = NULL;
 
@@ -438,6 +439,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
 
 		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
 		i2c_del_adapter(adap);
+		of_node_put(np);
 		kfree(priv);
 	}
 }
-- 
1.9.1
