From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 34/34] usb: typec: tcpm: fusb302: simplify getting the adapter of a client
Date: Sat,  8 Jun 2019 12:56:13 +0200
Message-ID: <20190608105619.593-35-wsa+renesas@sang-engineering.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/usb/typec/tcpm/fusb302.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 7302f7501ec9..c524088246ee 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1697,13 +1697,12 @@ static int fusb302_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct fusb302_chip *chip;
-	struct i2c_adapter *adapter;
+	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
 	const char *name;
 	int ret = 0;
 	u32 v;
 
-	adapter = to_i2c_adapter(client->dev.parent);
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
 		dev_err(&client->dev,
 			"I2C/SMBus block functionality not supported!\n");
-- 
2.19.1
