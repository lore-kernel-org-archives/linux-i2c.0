From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 6/8] media: i2c: adv7180: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:00 +0200
Message-ID: <20190722172604.3572-7-wsa+renesas@sang-engineering.com>
References: <20190722172604.3572-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172604.3572-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Lars-Peter Clausen <lars@metafoo.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/media/i2c/adv7180.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index 6f3dc8862622..e780969cc2f2 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -1329,17 +1329,17 @@ static int adv7180_probe(struct i2c_client *client,
 	}
 
 	if (state->chip_info->flags & ADV7180_FLAG_MIPI_CSI2) {
-		state->csi_client = i2c_new_dummy(client->adapter,
+		state->csi_client = i2c_new_dummy_device(client->adapter,
 				ADV7180_DEFAULT_CSI_I2C_ADDR);
-		if (!state->csi_client)
-			return -ENOMEM;
+		if (IS_ERR(state->csi_client))
+			return PTR_ERR(state->csi_client);
 	}
 
 	if (state->chip_info->flags & ADV7180_FLAG_I2P) {
-		state->vpp_client = i2c_new_dummy(client->adapter,
+		state->vpp_client = i2c_new_dummy_device(client->adapter,
 				ADV7180_DEFAULT_VPP_I2C_ADDR);
-		if (!state->vpp_client) {
-			ret = -ENOMEM;
+		if (IS_ERR(state->vpp_client)) {
+			ret = PTR_ERR(state->vpp_client);
 			goto err_unregister_csi_client;
 		}
 	}
-- 
2.20.1
