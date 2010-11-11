From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/6] leds: lp5521: Adjust delays and add comments to them
Date: Thu, 11 Nov 2010 10:21:52 +0200
Message-ID: <1289463715-12507-4-git-send-email-samu.p.onkalo@nokia.com>
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
 drivers/leds/leds-lp5521.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index fe69e52..963c014 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -196,14 +196,17 @@ static int lp5521_load_program(struct lp5521_engine *eng, const u8 *pattern)
 
 	/* move current engine to direct mode and remember the state */
 	ret = lp5521_set_engine_mode(eng, LP5521_CMD_DIRECT);
-	usleep_range(1000, 10000);
+	/* Mode change requires min 500 us delay. 1 - 2 ms  with margin */
+	usleep_range(1000, 2000);
 	ret |= lp5521_read(client, LP5521_REG_OP_MODE, &mode);
 
 	/* For loading, all the engines to load mode */
 	lp5521_write(client, LP5521_REG_OP_MODE, LP5521_CMD_DIRECT);
-	usleep_range(1000, 10000);
+	/* Mode change requires min 500 us delay. 1 - 2 ms  with margin */
+	usleep_range(1000, 2000);
 	lp5521_write(client, LP5521_REG_OP_MODE, LP5521_CMD_LOAD);
-	usleep_range(1000, 10000);
+	/* Mode change requires min 500 us delay. 1 - 2 ms  with margin */
+	usleep_range(1000, 2000);
 
 	addr = LP5521_PROG_MEM_BASE + eng->prog_page * LP5521_PROG_MEM_SIZE;
 	i2c_smbus_write_i2c_block_data(client,
@@ -244,7 +247,10 @@ static int lp5521_configure(struct i2c_client *client,
 
 	lp5521_write(client, LP5521_REG_RESET, 0xff);
 
-	usleep_range(10000, 20000);
+	usleep_range(10000, 20000); /*
+				     * Exact value is not available. 10 - 20ms
+				     * appears to be enough for reset.
+				     */
 
 	/* Set all PWMs to direct control mode */
 	ret = lp5521_write(client, LP5521_REG_OP_MODE, 0x3F);
@@ -262,8 +268,8 @@ static int lp5521_configure(struct i2c_client *client,
 	ret |= lp5521_write(client, LP5521_REG_ENABLE,
 			LP5521_MASTER_ENABLE | LP5521_LOGARITHMIC_PWM |
 			LP5521_EXEC_RUN);
-	/* enable takes 500us */
-	usleep_range(500, 20000);
+	/* enable takes 500us. 1 - 2 ms leaves some margin */
+	usleep_range(1000, 2000);
 
 	return ret;
 }
@@ -316,7 +322,8 @@ static int lp5521_detect(struct i2c_client *client)
 			LP5521_MASTER_ENABLE | LP5521_LOGARITHMIC_PWM);
 	if (ret)
 		return ret;
-	usleep_range(1000, 10000);
+	/* enable takes 500us. 1 - 2 ms leaves some margin */
+	usleep_range(1000, 2000);
 	ret = lp5521_read(client, LP5521_REG_ENABLE, &buf);
 	if (ret)
 		return ret;
@@ -704,9 +711,9 @@ static int lp5521_probe(struct i2c_client *client,
 
 	if (pdata->enable) {
 		pdata->enable(0);
-		usleep_range(1000, 10000);
+		usleep_range(1000, 2000); /* Keep enable down at least 1ms */
 		pdata->enable(1);
-		usleep_range(1000, 10000); /* Spec says min 500us */
+		usleep_range(1000, 2000); /* 500us abs min. */
 	}
 
 	ret = lp5521_detect(client);
-- 
1.6.0.4
