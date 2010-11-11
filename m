From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/6] leds: lp5523: Adjust delays and add comments to them
Date: Thu, 11 Nov 2010 10:21:53 +0200
Message-ID: <1289463715-12507-5-git-send-email-samu.p.onkalo@nokia.com>
References: <1289463715-12507-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289463715-12507-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Delays were little bit too long. Adjust delay times and
add some comments to them.

Signed-off-by: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/leds/leds-lp5523.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index 053e1f8..4248d78 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -205,11 +205,14 @@ static int lp5523_configure(struct i2c_client *client)
 
 	lp5523_write(client, LP5523_REG_RESET, 0xff);
 
-	usleep_range(10000, 100000);
+	usleep_range(10000, 20000); /*
+				     * Exact value is not available. 10 - 20ms
+				     * appears to be enough for reset.
+				     */
 
 	ret |= lp5523_write(client, LP5523_REG_ENABLE, LP5523_ENABLE);
-	/* Chip startup time after reset is 500 us */
-	usleep_range(1000, 10000);
+	/* Chip startup time is 500 us, 1 - 2 ms gives some margin */
+	usleep_range(1000, 2000);
 
 	ret |= lp5523_write(client, LP5523_REG_CONFIG,
 			    LP5523_AUTO_INC | LP5523_PWR_SAVE |
@@ -246,8 +249,8 @@ static int lp5523_configure(struct i2c_client *client)
 		return -1;
 	}
 
-	/* Wait 3ms and check the engine status */
-	usleep_range(3000, 20000);
+	/* Let the programs run for couple of ms and check the engine status */
+	usleep_range(3000, 6000);
 	lp5523_read(client, LP5523_REG_STATUS, &status);
 	status &= LP5523_ENG_STATUS_MASK;
 
@@ -452,10 +455,10 @@ static ssize_t lp5523_selftest(struct device *dev,
 	/* Measure VDD (i.e. VBAT) first (channel 16 corresponds to VDD) */
 	lp5523_write(chip->client, LP5523_REG_LED_TEST_CTRL,
 				    LP5523_EN_LEDTEST | 16);
-	usleep_range(3000, 10000);
+	usleep_range(3000, 6000); /* ADC conversion time is typically 2.7 ms */
 	ret = lp5523_read(chip->client, LP5523_REG_STATUS, &status);
 	if (!(status & LP5523_LEDTEST_DONE))
-		usleep_range(3000, 10000);
+		usleep_range(3000, 6000); /* Was not ready. Wait little bit */
 
 	ret |= lp5523_read(chip->client, LP5523_REG_LED_TEST_ADC, &vdd);
 	vdd--;	/* There may be some fluctuation in measurement */
@@ -471,16 +474,16 @@ static ssize_t lp5523_selftest(struct device *dev,
 			chip->pdata->led_config[i].led_current);
 
 		lp5523_write(chip->client, LP5523_REG_LED_PWM_BASE + i, 0xff);
-		/* let current stabilize 2ms before measurements start */
-		usleep_range(2000, 10000);
+		/* let current stabilize 2 - 4ms before measurements start */
+		usleep_range(2000, 4000);
 		lp5523_write(chip->client,
 			     LP5523_REG_LED_TEST_CTRL,
 			     LP5523_EN_LEDTEST | i);
-		/* ledtest takes 2.7ms */
-		usleep_range(3000, 10000);
+		/* ADC conversion time is 2.7 ms typically */
+		usleep_range(3000, 6000);
 		ret = lp5523_read(chip->client, LP5523_REG_STATUS, &status);
 		if (!(status & LP5523_LEDTEST_DONE))
-			usleep_range(3000, 10000);
+			usleep_range(3000, 6000);/* Was not ready. Wait. */
 		ret |= lp5523_read(chip->client, LP5523_REG_LED_TEST_ADC, &adc);
 
 		if (adc >= vdd || adc < LP5523_ADC_SHORTCIRC_LIM)
@@ -933,9 +936,9 @@ static int lp5523_probe(struct i2c_client *client,
 
 	if (pdata->enable) {
 		pdata->enable(0);
-		usleep_range(1000, 10000);
+		usleep_range(1000, 2000); /* Keep enable down at least 1ms */
 		pdata->enable(1);
-		usleep_range(1000, 10000); /* Spec says min 500us */
+		usleep_range(1000, 2000); /* 500us abs min. */
 	}
 
 	ret = lp5523_detect(client);
-- 
1.6.0.4
