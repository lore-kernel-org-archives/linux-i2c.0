From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/4] i2c: mux: mlxcpld: switch to using .probe_new
Date: Tue, 17 Apr 2018 16:32:31 +0200
Message-ID: <20180417143233.25145-3-peda@axentia.se>
References: <20180417143233.25145-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417143233.25145-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Michael Hennerich <michael.hennerich@analog.com>, Wolfram Sang <wsa@the-dreams.de>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
index 12ad8d65faf6..2fe86cc81da9 100644
--- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
+++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
@@ -149,8 +149,7 @@ static int mlxcpld_mux_deselect(struct i2c_mux_core *muxc, u32 chan)
 }
 
 /* Probe/reomove functions */
-static int mlxcpld_mux_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int mlxcpld_mux_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
 	struct mlxcpld_mux_plat_data *pdata = dev_get_platdata(&client->dev);
@@ -208,7 +207,7 @@ static struct i2c_driver mlxcpld_mux_driver = {
 	.driver		= {
 		.name	= "mlxcpld-mux",
 	},
-	.probe		= mlxcpld_mux_probe,
+	.probe_new	= mlxcpld_mux_probe,
 	.remove		= mlxcpld_mux_remove,
 	.id_table	= mlxcpld_mux_id,
 };
-- 
2.11.0
