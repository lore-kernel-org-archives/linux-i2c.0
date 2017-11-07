From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] ARM: sa1100: simpad: Correct I2C GPIO offsets
Date: Tue,  7 Nov 2017 16:17:03 +0100
Message-ID: <20171107151703.3847-1-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:49011 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbdKGPTR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 7 Nov 2017 10:19:17 -0500
Received: by mail-lf0-f65.google.com with SMTP id r135so14923334lfe.5
        for <linux-i2c@vger.kernel.org>; Tue, 07 Nov 2017 07:19:16 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Jochen Friedrich <jochen@scram.de>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>

Arnd reported the following build bug bug:

In file included from arch/arm/mach-sa1100/simpad.c:20:0:
arch/arm/mach-sa1100/include/mach/SA-1100.h:1118:18: error: large
integer implicitly truncated to unsigned type [-Werror=overflow]
                      (0x00000001 << (Nb))
                      ^
include/linux/gpio/machine.h:56:16: note: in definition of macro
'GPIO_LOOKUP_IDX'
.chip_hwnum = _chip_hwnum,
              ^~~~~~~~~~~
arch/arm/mach-sa1100/include/mach/SA-1100.h:1140:21: note: in
expansion of macro 'GPIO_GPIO'
                    ^~~~~~~~~
arch/arm/mach-sa1100/simpad.c:331:27: note: in expansion of
macro 'GPIO_GPIO21'
  GPIO_LOOKUP_IDX("gpio", GPIO_GPIO21, NULL, 0,

This is what happened:

commit b2e63555592f81331c8da3afaa607d8cf83e8138
"i2c: gpio: Convert to use descriptors"
commit 4d0ce62c0a02e41a65cfdcfe277f5be430edc371
"i2c: gpio: Augment all boardfiles to use open drain"
together uncovered an old bug in the Simpad board
file: as theGPIO_LOOKUP_IDX() encodes GPIO offsets
on gpiochips in an u16 (see <linux/gpio/machine.h>)
these GPIO "numbers" does not fit, since in
arch/arm/mach-sa1100/include/mach/SA-1100.h it is
defined as:

This is however provably wrong, since the i2c-gpio
driver uses proper GPIO numbers, albeit earlier from
the global number space, whereas this GPIO_GPIO21
is the local line offset in the GPIO register, which
is used in other code but certainly not in the
gpiolib GPIO driver in drivers/gpio/gpio-sa1100.c, which
has code like this:

static void sa1100_gpio_set(struct gpio_chip *chip,
                            unsigned offset, int value)
{
    int reg = value ? R_GPSR : R_GPCR;

    writel_relaxed(BIT(offset),
        sa1100_gpio_chip(chip)->membase + reg);
}

So far everything however compiled fine as an unsigned
int was used to pass the GPIO numbers in
struct i2c_gpio_platform_data. We can trace the actual error
back to

commit dbd406f9d0a1d33a1303eb75cbe3f9435513d339
"ARM: 7025/1: simpad: add GPIO based device definitions."
This added the i2c_gpio with the wrong offsets.

This commit was before the SA1100 was converted to use
the gpiolib, but as can be seen from the contemporary
gpio.c in mach-sa1100, it was already using:

static int sa1100_gpio_get(struct gpio_chip *chip,
                           unsigned offset)
{
        return GPLR & GPIO_GPIO(offset);
}

And GPIO_GPIO() is essentially the BIT() macro.

Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Jochen Friedrich <jochen@scram.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Wolfram: this is in the i2c GPIO refactoring in your tree,
please apply it directly as a fix for v4.15 if there are
no protests.
Jochen: did this ever work? I suspect the patch was simply
developed on top of a different kernel.
---
 arch/arm/mach-sa1100/simpad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 9db483a42826..7d4feb8a49ac 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -328,9 +328,9 @@ static struct platform_device simpad_gpio_leds = {
 static struct gpiod_lookup_table simpad_i2c_gpiod_table = {
 	.dev_id = "i2c-gpio",
 	.table = {
-		GPIO_LOOKUP_IDX("gpio", GPIO_GPIO21, NULL, 0,
+		GPIO_LOOKUP_IDX("gpio", 21, NULL, 0,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP_IDX("gpio", GPIO_GPIO25, NULL, 1,
+		GPIO_LOOKUP_IDX("gpio", 25, NULL, 1,
 				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
-- 
2.13.6
