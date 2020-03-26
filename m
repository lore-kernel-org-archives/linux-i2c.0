From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] mfd: htc-i2cpld: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:10:09 +0100
Message-ID: <20200326211009.13411-2-wsa+renesas@sang-engineering.com>
References: <20200326211009.13411-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211009.13411-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mfd/htc-i2cpld.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
index 8ad6768bd7a2..247f9849e54a 100644
--- a/drivers/mfd/htc-i2cpld.c
+++ b/drivers/mfd/htc-i2cpld.c
@@ -355,12 +355,12 @@ static int htcpld_register_chip_i2c(
 	info.platform_data = chip;
 
 	/* Add the I2C device.  This calls the probe() function. */
-	client = i2c_new_device(adapter, &info);
-	if (!client) {
+	client = i2c_new_client_device(adapter, &info);
+	if (IS_ERR(client)) {
 		/* I2C device registration failed, contineu with the next */
 		dev_warn(dev, "Unable to add I2C device for 0x%x\n",
 			 plat_chip_data->addr);
-		return -ENODEV;
+		return PTR_ERR(client);
 	}
 
 	i2c_set_clientdata(client, chip);
-- 
2.20.1
