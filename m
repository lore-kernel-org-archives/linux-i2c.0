From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] I2c:smbus - Fix typo in comment.
Date: Tue, 19 May 2015 20:09:41 +0530
Message-ID: <1432046381-3320-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: linux-i2c@vger.kernel.org


Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/i2c/i2c-smbus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 9ebf9cb..94765a8 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -89,7 +89,7 @@ static void smbus_alert(struct work_struct *work)
 		 * to high, because of slave transmit arbitration.  After
 		 * responding, an SMBus device stops asserting SMBALERT#.
 		 *
-		 * Note that SMBus 2.0 reserves 10-bit addresess for future
+		 * Note that SMBus 2.0 reserves 10-bit addresses for future
 		 * use.  We neither handle them, nor try to use PEC here.
 		 */
 		status = i2c_smbus_read_byte(ara);
-- 
1.7.9.5
