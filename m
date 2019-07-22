From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] extcon: extcon-max77843: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:01 +0200
Message-ID: <20190722172601.3506-2-wsa+renesas@sang-engineering.com>
References: <20190722172601.3506-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172601.3506-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/extcon/extcon-max77843.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index a343a6ef3506..e6b50ca83008 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -774,12 +774,12 @@ static int max77843_init_muic_regmap(struct max77693_dev *max77843)
 {
 	int ret;
 
-	max77843->i2c_muic = i2c_new_dummy(max77843->i2c->adapter,
+	max77843->i2c_muic = i2c_new_dummy_device(max77843->i2c->adapter,
 			I2C_ADDR_MUIC);
-	if (!max77843->i2c_muic) {
+	if (IS_ERR(max77843->i2c_muic)) {
 		dev_err(&max77843->i2c->dev,
 				"Cannot allocate I2C device for MUIC\n");
-		return -ENOMEM;
+		return PTR_ERR(max77843->i2c_muic);
 	}
 
 	i2c_set_clientdata(max77843->i2c_muic, max77843);
-- 
2.20.1
