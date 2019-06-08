From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 26/34] rtc: fm3130: simplify getting the adapter of a client
Date: Sat,  8 Jun 2019 12:56:05 +0200
Message-ID: <20190608105619.593-27-wsa+renesas@sang-engineering.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/rtc/rtc-fm3130.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-fm3130.c b/drivers/rtc/rtc-fm3130.c
index e1137670d4d2..015cf639166e 100644
--- a/drivers/rtc/rtc-fm3130.c
+++ b/drivers/rtc/rtc-fm3130.c
@@ -107,8 +107,7 @@ static int fm3130_get_time(struct device *dev, struct rtc_time *t)
 	fm3130_rtc_mode(dev, FM3130_MODE_READ);
 
 	/* read the RTC date and time registers all at once */
-	tmp = i2c_transfer(to_i2c_adapter(fm3130->client->dev.parent),
-			fm3130->msg, 2);
+	tmp = i2c_transfer(fm3130->client->adapter, fm3130->msg, 2);
 	if (tmp != 2) {
 		dev_err(dev, "%s error %d\n", "read", tmp);
 		return -EIO;
@@ -200,8 +199,7 @@ static int fm3130_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	}
 
 	/* read the RTC alarm registers all at once */
-	tmp = i2c_transfer(to_i2c_adapter(fm3130->client->dev.parent),
-			&fm3130->msg[2], 2);
+	tmp = i2c_transfer(fm3130->client->adapter, &fm3130->msg[2], 2);
 	if (tmp != 2) {
 		dev_err(dev, "%s error %d\n", "read", tmp);
 		return -EIO;
@@ -351,7 +349,7 @@ static int fm3130_probe(struct i2c_client *client,
 	struct fm3130		*fm3130;
 	int			err = -ENODEV;
 	int			tmp;
-	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter	*adapter = client->adapter;
 
 	if (!i2c_check_functionality(adapter,
 			I2C_FUNC_I2C | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
-- 
2.19.1
