From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/6] leds: lp5521: Perform SW reset before detection
Date: Thu, 11 Nov 2010 10:21:54 +0200
Message-ID: <1289463715-12507-6-git-send-email-samu.p.onkalo@nokia.com>
References: <1289463715-12507-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289463715-12507-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Chip detection may fail if the chip is in some odd state
for example after system restart. Chip doesn't have
HW reset line.

Signed-off-by: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/leds/leds-lp5521.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index 963c014..33facd0 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -245,13 +245,6 @@ static int lp5521_configure(struct i2c_client *client,
 
 	lp5521_init_engine(chip, attr_group);
 
-	lp5521_write(client, LP5521_REG_RESET, 0xff);
-
-	usleep_range(10000, 20000); /*
-				     * Exact value is not available. 10 - 20ms
-				     * appears to be enough for reset.
-				     */
-
 	/* Set all PWMs to direct control mode */
 	ret = lp5521_write(client, LP5521_REG_OP_MODE, 0x3F);
 
@@ -716,6 +709,11 @@ static int lp5521_probe(struct i2c_client *client,
 		usleep_range(1000, 2000); /* 500us abs min. */
 	}
 
+	lp5521_write(client, LP5521_REG_RESET, 0xff);
+	usleep_range(10000, 20000); /*
+				     * Exact value is not available. 10 - 20ms
+				     * appears to be enough for reset.
+				     */
 	ret = lp5521_detect(client);
 
 	if (ret) {
-- 
1.6.0.4
