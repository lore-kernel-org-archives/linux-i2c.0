From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 33/34] staging: media: soc_camera: soc_mt9v022: simplify getting the adapter of a client
Date: Sat,  8 Jun 2019 12:56:12 +0200
Message-ID: <20190608105619.593-34-wsa+renesas@sang-engineering.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/staging/media/soc_camera/soc_mt9v022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/soc_camera/soc_mt9v022.c b/drivers/staging/media/soc_camera/soc_mt9v022.c
index e7e0d3d29499..1739a618846d 100644
--- a/drivers/staging/media/soc_camera/soc_mt9v022.c
+++ b/drivers/staging/media/soc_camera/soc_mt9v022.c
@@ -883,7 +883,7 @@ static int mt9v022_probe(struct i2c_client *client,
 {
 	struct mt9v022 *mt9v022;
 	struct soc_camera_subdev_desc *ssdd = soc_camera_i2c_to_desc(client);
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct mt9v022_platform_data *pdata;
 	int ret;
 
-- 
2.19.1
