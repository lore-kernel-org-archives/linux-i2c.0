From: Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] i2c-isch: Decrease delay in the loop checking the BUSY state of the bus
Date: Fri, 20 Jan 2012 12:46:54 +0100
Message-ID: <1327060014-7604-1-git-send-email-olivier@sobrie.be>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Generally it is not needed to wait for 1 msec, the SMBus get often ready
in less than 200 usecs.

msleep(1) can wait up to 20 msecs... It has a significant impact when
there is a burst of transactions on the bus.

Signed-off-by: Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-isch.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index 6561d27..f90a605 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -47,7 +47,7 @@
 #define SMBBLKDAT	(0x20 + sch_smba)
 
 /* Other settings */
-#define MAX_TIMEOUT	500
+#define MAX_RETRIES	5000
 
 /* I2C constants */
 #define SCH_QUICK		0x00
@@ -68,7 +68,7 @@ static int sch_transaction(void)
 {
 	int temp;
 	int result = 0;
-	int timeout = 0;
+	int retries = 0;
 
 	dev_dbg(&sch_adapter.dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb(SMBHSTCNT),
@@ -100,12 +100,12 @@ static int sch_transaction(void)
 	outb(inb(SMBHSTCNT) | 0x10, SMBHSTCNT);
 
 	do {
-		msleep(1);
+		usleep_range(100, 200);
 		temp = inb(SMBHSTSTS) & 0x0f;
-	} while ((temp & 0x08) && (timeout++ < MAX_TIMEOUT));
+	} while ((temp & 0x08) && (retries++ < MAX_RETRIES));
 
 	/* If the SMBus is still busy, we give up */
-	if (timeout > MAX_TIMEOUT) {
+	if (retries > MAX_RETRIES) {
 		dev_err(&sch_adapter.dev, "SMBus Timeout!\n");
 		result = -ETIMEDOUT;
 	}
-- 
1.7.5.4
