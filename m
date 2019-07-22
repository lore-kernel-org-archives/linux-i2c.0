From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 05/14] mfd: da9150-core: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:12 +0200
Message-ID: <20190722172623.4166-6-wsa+renesas@sang-engineering.com>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/mfd/da9150-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
index 13033068721a..7f0aa1e8db96 100644
--- a/drivers/mfd/da9150-core.c
+++ b/drivers/mfd/da9150-core.c
@@ -420,10 +420,10 @@ static int da9150_probe(struct i2c_client *client,
 	qif_addr = da9150_reg_read(da9150, DA9150_CORE2WIRE_CTRL_A);
 	qif_addr = (qif_addr & DA9150_CORE_BASE_ADDR_MASK) >> 1;
 	qif_addr |= DA9150_QIF_I2C_ADDR_LSB;
-	da9150->core_qif = i2c_new_dummy(client->adapter, qif_addr);
-	if (!da9150->core_qif) {
+	da9150->core_qif = i2c_new_dummy_device(client->adapter, qif_addr);
+	if (IS_ERR(da9150->core_qif)) {
 		dev_err(da9150->dev, "Failed to attach QIF client\n");
-		return -ENODEV;
+		return PTR_ERR(da9150->core_qif);
 	}
 
 	i2c_set_clientdata(da9150->core_qif, da9150);
-- 
2.20.1
