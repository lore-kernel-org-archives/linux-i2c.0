From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 06/34] media: i2c: ak881x: simplify getting the adapter of a client
Date: Sat,  8 Jun 2019 12:55:45 +0200
Message-ID: <20190608105619.593-7-wsa+renesas@sang-engineering.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/media/i2c/ak881x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ak881x.c b/drivers/media/i2c/ak881x.c
index 30f9db1351b9..09860603da64 100644
--- a/drivers/media/i2c/ak881x.c
+++ b/drivers/media/i2c/ak881x.c
@@ -232,7 +232,7 @@ static const struct v4l2_subdev_ops ak881x_subdev_ops = {
 static int ak881x_probe(struct i2c_client *client,
 			const struct i2c_device_id *did)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct ak881x *ak881x;
 	u8 ifmode, data;
 
-- 
2.19.1
