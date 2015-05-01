From: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Subject: [PATCH v2] i2c: i2c-bcm2708: fixes cdiv uneven number
Date: Fri,  1 May 2015 23:43:49 +0200
Message-ID: <1430516629-32692-1-git-send-email-linux_wi@tinag.ch>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Prevents that cdiv can be an uneven number as per datasheet cdiv is
always rounded down to an even number.

Datasheet at page 34 on
http://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Signed-off-by: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
---
 drivers/i2c/busses/i2c-bcm2708.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2708.c b/drivers/i2c/busses/i2c-bcm2708.c
index 81e9374..dd7094a 100644
--- a/drivers/i2c/busses/i2c-bcm2708.c
+++ b/drivers/i2c/busses/i2c-bcm2708.c
@@ -67,6 +67,9 @@
 #define BSC_S_DONE		0x00000002
 #define BSC_S_TA		0x00000001
 
+#define BSC_CDIV_MAX		0xFFFE
+#define BSC_CDIV_BITMASK	0xFFFE
+
 #define I2C_TIMEOUT_MS	150
 #define I2C_WAIT_LOOP_COUNT 40
 
@@ -441,9 +444,15 @@ static int bcm2708_i2c_probe(struct platform_device *pdev)
 
 	bus_hz = clk_get_rate(bi->clk);
 	cdiv = bus_hz / baudrate;
-	if (cdiv > 0xffff) {
-		cdiv = 0xffff;
+	/* as per datasheet cdiv is always rounded down to an even number */
+	if (cdiv > BSC_CDIV_MAX) {
+		cdiv = BSC_CDIV_MAX;
 		baudrate = bus_hz / cdiv;
+	} else {
+		if ((cdiv & BSC_CDIV_BITMASK) != cdiv) {
+			cdiv &= BSC_CDIV_BITMASK;
+			baudrate = bus_hz / cdiv;
+		}
 	}
 	bi->cdiv = cdiv;
 
-- 
2.1.4
