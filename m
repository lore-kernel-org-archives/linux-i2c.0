From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/2] i2c: piix4: Use usleep_range()
Date: Sat, 30 Dec 2017 08:50:58 -0800
Message-ID: <1514652658-6228-2-git-send-email-linux@roeck-us.net>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.com>, =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@pr.hu>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

The piix4 i2c driver is extremely slow. Replacing msleep()
with usleep_range() increases its speed substantially.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/i2c/busses/i2c-piix4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 78dd5951d6e7..52a8b1c5c110 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -467,13 +467,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 
 	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
 	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
-		msleep(2);
+		usleep_range(2000, 2000);
 	else
-		msleep(1);
+		usleep_range(500, 1000);
 
 	while ((++timeout < MAX_TIMEOUT) &&
 	       ((temp = inb_p(SMBHSTSTS)) & 0x01))
-		msleep(1);
+		usleep_range(200, 500);
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout == MAX_TIMEOUT) {
-- 
2.7.4
