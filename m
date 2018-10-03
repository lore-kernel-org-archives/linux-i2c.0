From: Luca Ceresoli <lucaceresoli77@gmail.com>
Subject: [PATCH v2 3/3] i2c: mux: mlxcpld: simplify code to reach the adapter
Date: Wed,  3 Oct 2018 17:50:24 +0200
Message-ID: <20181003155024.16024-3-lucaceresoli77@gmail.com>
References: <20181003155024.16024-1-lucaceresoli77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003155024.16024-1-lucaceresoli77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>, Peter Rosin <peda@axentia.se>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Michael Hennerich <michael.hennerich@analog.com>
List-Id: linux-i2c@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>

struct i2c_client has a direct pointer to the adapter, no need to dig
it out of the struct device tree.

Suggested-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
index f2bf3e57ed67..5ed55ca4fe93 100644
--- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
+++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
@@ -132,7 +132,7 @@ static int mlxcpld_mux_deselect(struct i2c_mux_core *muxc, u32 chan)
 static int mlxcpld_mux_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adap = client->adapter;
 	struct mlxcpld_mux_plat_data *pdata = dev_get_platdata(&client->dev);
 	struct i2c_mux_core *muxc;
 	int num, force;
-- 
2.17.1
