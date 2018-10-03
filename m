From: Luca Ceresoli <lucaceresoli77@gmail.com>
Subject: [PATCH v2 2/3] i2c: mux: ltc4306: simplify code to reach the adapter
Date: Wed,  3 Oct 2018 17:50:23 +0200
Message-ID: <20181003155024.16024-2-lucaceresoli77@gmail.com>
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
 drivers/i2c/muxes/i2c-mux-ltc4306.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
index a9af93259b19..83a714605cd6 100644
--- a/drivers/i2c/muxes/i2c-mux-ltc4306.c
+++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
@@ -208,7 +208,7 @@ MODULE_DEVICE_TABLE(of, ltc4306_of_match);
 
 static int ltc4306_probe(struct i2c_client *client)
 {
-	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adap = client->adapter;
 	const struct chip_desc *chip;
 	struct i2c_mux_core *muxc;
 	struct ltc4306 *data;
-- 
2.17.1
