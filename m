From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/6] leds: lp5523: Change some macros to functions
Date: Thu, 11 Nov 2010 10:21:51 +0200
Message-ID: <1289463715-12507-3-git-send-email-samu.p.onkalo@nokia.com>
References: <1289463715-12507-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289463715-12507-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

A small macro changed to inline function to have proper
type checking. Inline added to two similar small functions.

Signed-off-by: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/leds/leds-lp5523.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index 1e11fcc..053e1f8 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -134,15 +134,18 @@ struct lp5523_chip {
 	u8			num_leds;
 };
 
-#define cdev_to_led(c)          container_of(c, struct lp5523_led, cdev)
+static inline struct lp5523_led *cdev_to_led(struct led_classdev *cdev)
+{
+	return container_of(cdev, struct lp5523_led, cdev);
+}
 
-static struct lp5523_chip *engine_to_lp5523(struct lp5523_engine *engine)
+static inline struct lp5523_chip *engine_to_lp5523(struct lp5523_engine *engine)
 {
 	return container_of(engine, struct lp5523_chip,
 			    engines[engine->id - 1]);
 }
 
-static struct lp5523_chip *led_to_lp5523(struct lp5523_led *led)
+static inline struct lp5523_chip *led_to_lp5523(struct lp5523_led *led)
 {
 	return container_of(led, struct lp5523_chip,
 			    leds[led->id]);
-- 
1.6.0.4
