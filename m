From: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Subject: [PATCH] i2c: i2c-bcm2708: fixes cdiv uneven number
Date: Thu, 30 Apr 2015 20:07:46 +0200
Message-ID: <1430417266-14900-1-git-send-email-linux_wi@tinag.ch>
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
 drivers/i2c/busses/i2c-bcm2708.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2708.c b/drivers/i2c/busses/i2c-bcm2708.c
index 81e9374..454ab48 100644
--- a/drivers/i2c/busses/i2c-bcm2708.c
+++ b/drivers/i2c/busses/i2c-bcm2708.c
@@ -441,9 +441,15 @@ static int bcm2708_i2c_probe(struct platform_device *pdev)
 
 	bus_hz = clk_get_rate(bi->clk);
 	cdiv = bus_hz / baudrate;
-	if (cdiv > 0xffff) {
-		cdiv = 0xffff;
+	/* as per datasheet cdiv is always rounded down to an even number */
+	if (cdiv > 0xfffe) {
+		cdiv = 0xfffe;
 		baudrate = bus_hz / cdiv;
+	} else {
+		if ((cdiv & 0xfffe) != cdiv) {
+			cdiv &= 0xfffe;
+			baudrate = bus_hz / cdiv;
+		}
 	}
 	bi->cdiv = cdiv;
 
-- 
2.1.4
