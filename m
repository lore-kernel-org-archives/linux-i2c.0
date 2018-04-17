From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/4] i2c: mux: ltc4306: switch to using .probe_new
Date: Tue, 17 Apr 2018 16:32:30 +0200
Message-ID: <20180417143233.25145-2-peda@axentia.se>
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
 drivers/i2c/muxes/i2c-mux-ltc4306.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
index 311b1cced0c0..a9af93259b19 100644
--- a/drivers/i2c/muxes/i2c-mux-ltc4306.c
+++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
@@ -206,8 +206,7 @@ static const struct of_device_id ltc4306_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ltc4306_of_match);
 
-static int ltc4306_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int ltc4306_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
 	const struct chip_desc *chip;
@@ -221,7 +220,7 @@ static int ltc4306_probe(struct i2c_client *client,
 	chip = of_device_get_match_data(&client->dev);
 
 	if (!chip)
-		chip = &chips[id->driver_data];
+		chip = &chips[i2c_match_id(ltc4306_id, client)->driver_data];
 
 	idle_disc = device_property_read_bool(&client->dev,
 					      "i2c-mux-idle-disconnect");
@@ -310,7 +309,7 @@ static struct i2c_driver ltc4306_driver = {
 		.name	= "ltc4306",
 		.of_match_table = of_match_ptr(ltc4306_of_match),
 	},
-	.probe		= ltc4306_probe,
+	.probe_new	= ltc4306_probe,
 	.remove		= ltc4306_remove,
 	.id_table	= ltc4306_id,
 };
-- 
2.11.0
