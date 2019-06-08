From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 12/34] misc: fsa9480: simplify getting the adapter of a client
Date: Sat,  8 Jun 2019 12:55:51 +0200
Message-ID: <20190608105619.593-13-wsa+renesas@sang-engineering.com>
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

 drivers/misc/fsa9480.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fsa9480.c b/drivers/misc/fsa9480.c
index 607b489a6501..a8126790f8de 100644
--- a/drivers/misc/fsa9480.c
+++ b/drivers/misc/fsa9480.c
@@ -410,7 +410,7 @@ static int fsa9480_irq_init(struct fsa9480_usbsw *usbsw)
 static int fsa9480_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct fsa9480_usbsw *usbsw;
 	int ret = 0;
 
-- 
2.19.1
