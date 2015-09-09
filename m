From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: sirf: tune the divider to make i2c bus freq more accurate
Date: Wed,  9 Sep 2015 10:30:32 +0000
Message-ID: <1441794632-4074-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Guoying Zhang <Guoying.Zhang-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Guoying Zhang <Guoying.Zhang-kQvG35nSl+M@public.gmane.org>

In prima2 and atlas7, due to some hardware design issue. we
need to adjust the divider ratio a little according to i2c
bus frequency ranges.
Since i2c is open drain interface that allows the slave to
stall the transaction by holding the SCL line at '0', the RTL
implementation is waiting for SCL feedback from the pin after
setting it to High-Z ('1'). This wait adds to the high-time
interval counter few cycles of the input synchronization
(depending on the SCL_FILTER_REG field), and also the time it
takes for the board pull-up resistor to rise the SCL line.
For slow SCL settings these additions are negligible, but they
start to affect the speed when clock is set to faster frequencies.
This patch is based on the actual tests, and it makes SCL more
accurate.

Signed-off-by: Guoying Zhang <Guoying.Zhang-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/i2c/busses/i2c-sirf.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 1092d4e..13e51ef 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -358,11 +358,29 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 	if (err < 0)
 		bitrate = SIRFSOC_I2C_DEFAULT_SPEED;
 
-	if (bitrate < 100000)
-		regval =
-			(2 * ctrl_speed) / (bitrate * 11);
-	else
+	/*
+	 * Due to some hardware design issues, we need to tune the formula.
+	 * Since i2c is open drain interface that allows the slave to
+	 * stall the transaction by holding the SCL line at '0', the RTL
+	 * implementation is waiting for SCL feedback from the pin after
+	 * setting it to High-Z ('1'). This wait adds to the high-time
+	 * interval counter few cycles of the input synchronization
+	 * (depending on the SCL_FILTER_REG field), and also the time it
+	 * takes for the board pull-up resistor to rise the SCL line.
+	 * For slow SCL settings these additions are negligible,
+	 * but they start to affect the speed when clock is set to faster
+	 * frequencies.
+	 * Through the actual tests, use the different user_div value(which
+	 * in the divider formular 'Fio / (Fi2c * user_div)') to adapt
+	 * the different ranges of i2c bus clock frequency, to make the SCL
+	 * more accurate.
+	 */
+	if (bitrate <= 30000)
 		regval = ctrl_speed / (bitrate * 5);
+	else if (bitrate > 30000 && bitrate <= 280000)
+		regval = (2 * ctrl_speed) / (bitrate * 11);
+	else
+		regval = ctrl_speed / (bitrate * 6);
 
 	writel(regval, siic->base + SIRFSOC_I2C_CLK_CTRL);
 	if (regval > 0xFF)
-- 
1.9.1
