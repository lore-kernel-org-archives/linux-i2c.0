From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 2/2] i2c: mux: pca954x: verify the device id of the pca984x chips
Date: Mon,  5 Mar 2018 21:58:22 +0100
Message-ID: <20180305205822.951-3-peda@axentia.se>
References: <20180305205822.951-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305205822.951-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Make sure to not disallow the chips on adapters that are not capable
of reading the device id, but also make sure to check the device id
before writing to the chip.

Tested-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 55 +++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index fbb84c7ef282..09bafd3e68fa 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -77,6 +77,7 @@ struct chip_desc {
 		pca954x_ismux = 0,
 		pca954x_isswi
 	} muxtype;
+	struct i2c_device_identity id;
 };
 
 struct pca954x {
@@ -97,59 +98,83 @@ static const struct chip_desc chips[] = {
 		.nchans = 2,
 		.enable = 0x4,
 		.muxtype = pca954x_ismux,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9542] = {
 		.nchans = 2,
 		.enable = 0x4,
 		.has_irq = 1,
 		.muxtype = pca954x_ismux,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9543] = {
 		.nchans = 2,
 		.has_irq = 1,
 		.muxtype = pca954x_isswi,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9544] = {
 		.nchans = 4,
 		.enable = 0x4,
 		.has_irq = 1,
 		.muxtype = pca954x_ismux,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9545] = {
 		.nchans = 4,
 		.has_irq = 1,
 		.muxtype = pca954x_isswi,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9546] = {
 		.nchans = 4,
 		.muxtype = pca954x_isswi,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9547] = {
 		.nchans = 8,
 		.enable = 0x8,
 		.muxtype = pca954x_ismux,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9548] = {
 		.nchans = 8,
 		.muxtype = pca954x_isswi,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
 	},
 	[pca_9846] = {
 		.nchans = 4,
 		.muxtype = pca954x_isswi,
+		.id = {
+			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
+			.part_id = 0x10b,
+		},
 	},
 	[pca_9847] = {
 		.nchans = 8,
 		.enable = 0x8,
 		.muxtype = pca954x_ismux,
+		.id = {
+			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
+			.part_id = 0x108,
+		},
 	},
 	[pca_9848] = {
 		.nchans = 8,
 		.muxtype = pca954x_isswi,
+		.id = {
+			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
+			.part_id = 0x10a,
+		},
 	},
 	[pca_9849] = {
 		.nchans = 4,
 		.enable = 0x4,
 		.muxtype = pca954x_ismux,
+		.id = {
+			.manufacturer_id = I2C_DEVICE_ID_NXP_SEMICONDUCTORS,
+			.part_id = 0x109,
+		},
 	},
 };
 
@@ -369,6 +394,30 @@ static int pca954x_probe(struct i2c_client *client,
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
+	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
+	if (match)
+		data->chip = of_device_get_match_data(&client->dev);
+	else
+		data->chip = &chips[id->driver_data];
+
+	if (data->chip->id.manufacturer_id != I2C_DEVICE_ID_NONE) {
+		struct i2c_device_identity id;
+
+		ret = i2c_get_device_id(client, &id);
+		if (ret && ret != -EOPNOTSUPP)
+			return ret;
+
+		if (!ret &&
+		    (id.manufacturer_id != data->chip->id.manufacturer_id ||
+		     id.part_id != data->chip->id.part_id)) {
+			dev_warn(&client->dev,
+				 "unexpected device id %03x-%03x-%x\n",
+				 id.manufacturer_id, id.part_id,
+				 id.die_revision);
+			return -ENODEV;
+		}
+	}
+
 	/* Write the mux register at addr to verify
 	 * that the mux is in fact present. This also
 	 * initializes the mux to disconnected state.
@@ -378,12 +427,6 @@ static int pca954x_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
-	if (match)
-		data->chip = of_device_get_match_data(&client->dev);
-	else
-		data->chip = &chips[id->driver_data];
-
 	data->last_chan = 0;		   /* force the first selection */
 
 	idle_disconnect_dt = of_node &&
-- 
2.11.0
