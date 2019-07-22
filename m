From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 04/14] mfd: bcm590xx: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:11 +0200
Message-ID: <20190722172623.4166-5-wsa+renesas@sang-engineering.com>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/mfd/bcm590xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 1aeb5e498d91..bfac5dc091ca 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -61,11 +61,11 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri,
 	}
 
 	/* Secondary I2C slave address is the base address with A(2) asserted */
-	bcm590xx->i2c_sec = i2c_new_dummy(i2c_pri->adapter,
+	bcm590xx->i2c_sec = i2c_new_dummy_device(i2c_pri->adapter,
 					  i2c_pri->addr | BIT(2));
-	if (!bcm590xx->i2c_sec) {
+	if (IS_ERR(bcm590xx->i2c_sec)) {
 		dev_err(&i2c_pri->dev, "failed to add secondary I2C device\n");
-		return -ENODEV;
+		return PTR_ERR(bcm590xx->i2c_sec);
 	}
 	i2c_set_clientdata(bcm590xx->i2c_sec, bcm590xx);
 
-- 
2.20.1
