From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 14/34] misc: tsl2550: simplify getting the adapter of a client
Date: Sat,  8 Jun 2019 12:55:53 +0200
Message-ID: <20190608105619.593-15-wsa+renesas@sang-engineering.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/misc/tsl2550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index 5b7afd6190fe..09db397df287 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -336,7 +336,7 @@ static struct i2c_driver tsl2550_driver;
 static int tsl2550_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct tsl2550_data *data;
 	int *opmode, err = 0;
 
-- 
2.19.1
