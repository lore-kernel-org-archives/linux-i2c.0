From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/6] leds: lp5521: Change some macros to functions
Date: Thu, 11 Nov 2010 10:21:50 +0200
Message-ID: <1289463715-12507-2-git-send-email-samu.p.onkalo@nokia.com>
References: <1289463715-12507-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289463715-12507-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Some small macros changed to inline functions to have proper
type checking.

Signed-off-by: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/leds/leds-lp5521.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index 3782f31..fe69e52 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -125,11 +125,22 @@ struct lp5521_chip {
 	u8			num_leds;
 };
 
-#define cdev_to_led(c)		container_of(c, struct lp5521_led, cdev)
-#define engine_to_lp5521(eng)	container_of((eng), struct lp5521_chip, \
-						engines[(eng)->id - 1])
-#define led_to_lp5521(led)	container_of((led), struct lp5521_chip, \
-						leds[(led)->id])
+static inline struct lp5521_led *cdev_to_led(struct led_classdev *cdev)
+{
+	return container_of(cdev, struct lp5521_led, cdev);
+}
+
+static inline struct lp5521_chip *engine_to_lp5521(struct lp5521_engine *engine)
+{
+	return container_of(engine, struct lp5521_chip,
+			    engines[engine->id - 1]);
+}
+
+static inline struct lp5521_chip *led_to_lp5521(struct lp5521_led *led)
+{
+	return container_of(led, struct lp5521_chip,
+			    leds[led->id]);
+}
 
 static void lp5521_led_brightness_work(struct work_struct *work);
 
-- 
1.6.0.4
