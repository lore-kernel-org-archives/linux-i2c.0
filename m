From: =?windows-1252?Q?Svenning_S=F8rensen?= <sss-sijd2F9aCfdBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: scx200_acb: avoid I2C bus overclocking.
Date: Thu, 23 Apr 2015 22:27:50 +0200
Message-ID: <553955C6.3030000@secomea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

According to I2C spec, max SCL rate is 100 kHz, but SCx200/CS5536
controller is currently driving it at 214 kHz according to my math.

SCL is derived from an input clock of 48 MHz, which must be divided
by 480 (240 cycles for each SCL high/low state) to be within spec.

Signed-off-by: Svenning Soerensen <sss-sijd2F9aCfdBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/scx200_acb.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 0a7e410..4def02d 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -46,6 +46,7 @@ module_param_array(base, int, NULL, 0);
 MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
 
 #define POLL_TIMEOUT	(HZ/5)
+#define ACBCLK		240	/* 48 MHz / 100 kHz / 2 */
 
 enum scx200_acb_state {
 	state_idle,
@@ -255,14 +256,14 @@ static void scx200_acb_poll(struct scx200_acb_iface *iface)
 static void scx200_acb_reset(struct scx200_acb_iface *iface)
 {
 	/* Disable the ACCESS.bus device and Configure the SCL
-	   frequency: 16 clock cycles */
-	outb(0x70, ACBCTL2);
+	   frequency: 240 clock cycles => 100 kHz */
+	outb(ACBCLK, ACBCTL2);
 	/* Polling mode */
 	outb(0, ACBCTL1);
 	/* Disable slave address */
 	outb(0, ACBADDR);
 	/* Enable the ACCESS.bus device */
-	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
+	outb(ACBCLK | ACBCTL2_ENABLE, ACBCTL2);
 	/* Free STALL after START */
 	outb(inb(ACBCTL1) & ~(ACBCTL1_STASTRE | ACBCTL1_NMINTE), ACBCTL1);
 	/* Send a STOP */
@@ -390,10 +391,10 @@ static int scx200_acb_probe(struct scx200_acb_iface *iface)
 	u8 val;
 
 	/* Disable the ACCESS.bus device and Configure the SCL
-	   frequency: 16 clock cycles */
-	outb(0x70, ACBCTL2);
+	   frequency: 240 clock cycles => 100 kHz*/
+	outb(ACBCLK, ACBCTL2);
 
-	if (inb(ACBCTL2) != 0x70) {
+	if (inb(ACBCTL2) != ACBCLK) {
 		pr_debug("ACBCTL2 readback failed\n");
 		return -ENXIO;
 	}
@@ -406,7 +407,7 @@ static int scx200_acb_probe(struct scx200_acb_iface *iface)
 		return -ENXIO;
 	}
 
-	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
+	outb(ACBCLK | ACBCTL2_ENABLE, ACBCTL2);
 
 	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
 
-- 
2.4.0.rc1
