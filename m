From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH] i2c: mux: pca954x: simplify code to reach the adapter
Date: Tue, 25 Sep 2018 17:17:34 +0200
Message-ID: <20180925151734.14148-1-luca@lucaceresoli.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>
List-Id: linux-i2c@vger.kernel.org

struct i2c_client has a direct pointer to the adapter, no need to dig
it out of the struct device tree.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 24bd9275fde5..bfabf985e830 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -347,7 +347,7 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
 static int pca954x_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adap = client->adapter;
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct device *dev = &client->dev;
 	struct device_node *np = dev->of_node;
-- 
2.17.1
