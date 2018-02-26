From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/2] i2c: piix4: Use usleep_range()
Date: Mon, 26 Feb 2018 12:46:52 -0800
Message-ID: <1519678013-32749-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

The piix4 i2c driver is extremely slow. Replacing msleep()
with usleep_range() increases its speed substantially.
Use sleep ranges similar to those used in the i2c-801 driver
to keep things simple.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Changed timeout values for usleep_range()
    2000/2000 -> 2000/2100
    500/1000 -> 250/500
    200/500 -> 250/500

 drivers/i2c/busses/i2c-piix4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 462948e2c535..4c1f6aaec0fc 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -462,13 +462,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 
 	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
 	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
-		msleep(2);
+		usleep_range(2000, 2100);
 	else
-		msleep(1);
+		usleep_range(250, 500);
 
 	while ((++timeout < MAX_TIMEOUT) &&
 	       ((temp = inb_p(SMBHSTSTS)) & 0x01))
-		msleep(1);
+		usleep_range(250, 500);
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout == MAX_TIMEOUT) {
-- 
2.7.4
