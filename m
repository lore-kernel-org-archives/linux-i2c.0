From: Petri Gynther <pgynther-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] pca954x: Initialize the mux to disconnected state in pca954x_probe()
Date: Fri, 17 Jun 2011 18:00:00 -0700
Message-ID: <20110618005949.2F442E0866@hockey.mtv.corp.google.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

pca954x power-on default is channel 0 connected. If multiple pca954x
muxes are connected to the same physical I2C bus, the parent bus will
see channel 0 devices behind both muxes by default. This is bad.

Scenario:
            -- pca954x @ 0x70 -- ch 0 (I2C-bus-101) -- EEPROM @ 0x50
            |
I2C-bus-1 ---
            |
            -- pca954x @ 0x71 -- ch 0 (I2C-bus-111) -- EEPROM @ 0x50

1. Load I2C bus driver: creates I2C-bus-1
2. Load pca954x driver: creates virtual I2C-bus-101 and I2C-bus-111
3. Load eeprom driver
4. Try to read EEPROM @ 0x50 on I2C-bus-101. The transaction will also bleed
   onto I2C-bus-111 because pca954x @ 0x71 channel 0 is connected by default.

Fix: Initialize pca954x to disconnected state in pca954x_probe()

Signed-off-by: Petri Gynther <pgynther-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/muxes/pca954x.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
index 54e1ce7..6f89536 100644
--- a/drivers/i2c/muxes/pca954x.c
+++ b/drivers/i2c/muxes/pca954x.c
@@ -201,10 +201,11 @@ static int pca954x_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, data);
 
-	/* Read the mux register at addr to verify
-	 * that the mux is in fact present.
+	/* Write the mux register at addr to verify
+	 * that the mux is in fact present. This also
+	 * initializes the mux to disconnected state.
 	 */
-	if (i2c_smbus_read_byte(client) < 0) {
+	if (i2c_smbus_write_byte(client, 0) < 0) {
 		dev_warn(&client->dev, "probe failed\n");
 		goto exit_free;
 	}
-- 
1.7.3.1
