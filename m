From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/6] leds: lp5523: Perform SW reset before detection
Date: Thu, 11 Nov 2010 10:21:55 +0200
Message-ID: <1289463715-12507-7-git-send-email-samu.p.onkalo@nokia.com>
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
 drivers/leds/leds-lp5523.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index 4248d78..0cc4ead 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -203,13 +203,6 @@ static int lp5523_configure(struct i2c_client *client)
 		{ 0x9c, 0x50, 0x9c, 0xd0, 0x9d, 0x80, 0xd8, 0x00, 0},
 	};
 
-	lp5523_write(client, LP5523_REG_RESET, 0xff);
-
-	usleep_range(10000, 20000); /*
-				     * Exact value is not available. 10 - 20ms
-				     * appears to be enough for reset.
-				     */
-
 	ret |= lp5523_write(client, LP5523_REG_ENABLE, LP5523_ENABLE);
 	/* Chip startup time is 500 us, 1 - 2 ms gives some margin */
 	usleep_range(1000, 2000);
@@ -941,6 +934,11 @@ static int lp5523_probe(struct i2c_client *client,
 		usleep_range(1000, 2000); /* 500us abs min. */
 	}
 
+	lp5523_write(client, LP5523_REG_RESET, 0xff);
+	usleep_range(10000, 20000); /*
+				     * Exact value is not available. 10 - 20ms
+				     * appears to be enough for reset.
+				     */
 	ret = lp5523_detect(client);
 	if (ret)
 		goto fail2;
-- 
1.6.0.4
