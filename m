From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] gpio: Add missing open drain/source handling to gpiod_set_value_cansleep()
Date: Tue,  9 Jan 2018 19:08:21 +0100
Message-ID: <1515521301-4375-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-i2c@vger.kernel.org

Since commit f11a04464ae57e8d ("i2c: gpio: Enable working over slow
can_sleep GPIOs"), probing the i2c RTC connected to an i2c-gpio bus on
r8a7740/armadillo fails with:

    rtc-s35390a 0-0030: error resetting chip
    rtc-s35390a: probe of 0-0030 failed with error -5

More debug code reveals:

    i2c i2c-0: master_xfer[0] R, addr=0x30, len=1
    i2c i2c-0: NAK from device addr 0x30 msg #0
    s35390a_get_reg: ret = -6

Commit 02e479808b5d62f8 ("gpio: Alter semantics of *raw* operations to
actually be raw") moved open drain/source handling from
gpiod_set_raw_value_commit() to gpiod_set_value(), but forgot to take
into account that gpiod_set_value_cansleep() also needs this handling.
The i2c protocol mandates that i2c signals are open drain, hence i2c
communication fails.

Fix this by adding the missing handling to gpiod_set_value_cansleep(),
using a new common helper __gpiod_set_value_nocheck().

Fixes: 02e479808b5d62f8 ("gpio: Alter semantics of *raw* operations to actually be raw")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The bad gpio commit is in v4.15-rc1 and later.
The i2c commit exposing this is not yet upstream, but in i2c/for-next.
---
 drivers/gpio/gpiolib.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 358bce6e798b476c..7761d632a5b0dd20 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2927,6 +2927,18 @@ void gpiod_set_raw_value(struct gpio_desc *desc, int value)
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_value);
 
+static void __gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
+{
+	if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
+		value = !value;
+	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
+		gpio_set_open_drain_value_commit(desc, value);
+	else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
+		gpio_set_open_source_value_commit(desc, value);
+	else
+		gpiod_set_raw_value_commit(desc, value);
+}
+
 /**
  * gpiod_set_value() - assign a gpio's value
  * @desc: gpio whose value will be assigned
@@ -2941,16 +2953,8 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_value);
 void gpiod_set_value(struct gpio_desc *desc, int value)
 {
 	VALIDATE_DESC_VOID(desc);
-	/* Should be using gpiod_set_value_cansleep() */
 	WARN_ON(desc->gdev->chip->can_sleep);
-	if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
-		value = !value;
-	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
-		gpio_set_open_drain_value_commit(desc, value);
-	else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
-		gpio_set_open_source_value_commit(desc, value);
-	else
-		gpiod_set_raw_value_commit(desc, value);
+	__gpiod_set_value_nocheck(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_value);
 
@@ -3277,9 +3281,7 @@ void gpiod_set_value_cansleep(struct gpio_desc *desc, int value)
 {
 	might_sleep_if(extra_checks);
 	VALIDATE_DESC_VOID(desc);
-	if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
-		value = !value;
-	gpiod_set_raw_value_commit(desc, value);
+	__gpiod_set_value_nocheck(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
 
-- 
2.7.4
