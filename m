From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/3] iio: light: cm36651: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:11 +0200
Message-ID: <20190722172613.3890-2-wsa+renesas@sang-engineering.com>
References: <20190722172613.3890-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172613.3890-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Kevin Tsai <ktsai@capellamicro.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/iio/light/cm36651.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index 7702c2bcbcfa..1019d625adb1 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -646,18 +646,18 @@ static int cm36651_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 
 	cm36651->client = client;
-	cm36651->ps_client = i2c_new_dummy(client->adapter,
+	cm36651->ps_client = i2c_new_dummy_device(client->adapter,
 						     CM36651_I2C_ADDR_PS);
-	if (!cm36651->ps_client) {
+	if (IS_ERR(cm36651->ps_client)) {
 		dev_err(&client->dev, "%s: new i2c device failed\n", __func__);
-		ret = -ENODEV;
+		ret = PTR_ERR(cm36651->ps_client);
 		goto error_disable_reg;
 	}
 
-	cm36651->ara_client = i2c_new_dummy(client->adapter, CM36651_ARA);
-	if (!cm36651->ara_client) {
+	cm36651->ara_client = i2c_new_dummy_device(client->adapter, CM36651_ARA);
+	if (IS_ERR(cm36651->ara_client)) {
 		dev_err(&client->dev, "%s: new i2c device failed\n", __func__);
-		ret = -ENODEV;
+		ret = PTR_ERR(cm36651->ara_client);
 		goto error_i2c_unregister_ps;
 	}
 
-- 
2.20.1
