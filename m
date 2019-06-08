From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 32/34] staging: media: soc_camera: mt9t031: simplify getting the adapter of a client
Date: Sat,  8 Jun 2019 12:56:11 +0200
Message-ID: <20190608105619.593-33-wsa+renesas@sang-engineering.com>
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

 drivers/staging/media/soc_camera/mt9t031.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/soc_camera/mt9t031.c b/drivers/staging/media/soc_camera/mt9t031.c
index 615ae9df2c57..c14f23221544 100644
--- a/drivers/staging/media/soc_camera/mt9t031.c
+++ b/drivers/staging/media/soc_camera/mt9t031.c
@@ -751,7 +751,7 @@ static int mt9t031_probe(struct i2c_client *client,
 {
 	struct mt9t031 *mt9t031;
 	struct soc_camera_subdev_desc *ssdd = soc_camera_i2c_to_desc(client);
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	int ret;
 
 	if (!ssdd) {
-- 
2.19.1
