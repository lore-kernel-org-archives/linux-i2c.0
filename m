From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/3] iio: pressure: hp03: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:13 +0200
Message-ID: <20190722172613.3890-4-wsa+renesas@sang-engineering.com>
References: <20190722172613.3890-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172613.3890-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/iio/pressure/hp03.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index f00102577fd5..026ba15ef68f 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -243,10 +243,10 @@ static int hp03_probe(struct i2c_client *client,
 	 * which has it's dedicated I2C address and contains
 	 * the calibration constants for the sensor.
 	 */
-	priv->eeprom_client = i2c_new_dummy(client->adapter, HP03_EEPROM_ADDR);
-	if (!priv->eeprom_client) {
+	priv->eeprom_client = i2c_new_dummy_device(client->adapter, HP03_EEPROM_ADDR);
+	if (IS_ERR(priv->eeprom_client)) {
 		dev_err(dev, "New EEPROM I2C device failed\n");
-		return -ENODEV;
+		return PTR_ERR(priv->eeprom_client);
 	}
 
 	priv->eeprom_regmap = regmap_init_i2c(priv->eeprom_client,
-- 
2.20.1
