From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: Add missing open drain/source handling to gpiod_set_value_cansleep()
Date: Wed, 10 Jan 2018 14:17:06 +0100
Message-ID: <CACRpkdaa4qvCu4tX_ZhbWTGquDjMXm-7FFDZ489LSdx2kM-tRQ@mail.gmail.com>
References: <1515521301-4375-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515521301-4375-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 9, 2018 at 7:08 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Since commit f11a04464ae57e8d ("i2c: gpio: Enable working over slow
> can_sleep GPIOs"), probing the i2c RTC connected to an i2c-gpio bus on
> r8a7740/armadillo fails with:
>
>     rtc-s35390a 0-0030: error resetting chip
>     rtc-s35390a: probe of 0-0030 failed with error -5
>
> More debug code reveals:
>
>     i2c i2c-0: master_xfer[0] R, addr=0x30, len=1
>     i2c i2c-0: NAK from device addr 0x30 msg #0
>     s35390a_get_reg: ret = -6
>
> Commit 02e479808b5d62f8 ("gpio: Alter semantics of *raw* operations to
> actually be raw") moved open drain/source handling from
> gpiod_set_raw_value_commit() to gpiod_set_value(), but forgot to take
> into account that gpiod_set_value_cansleep() also needs this handling.
> The i2c protocol mandates that i2c signals are open drain, hence i2c
> communication fails.
>
> Fix this by adding the missing handling to gpiod_set_value_cansleep(),
> using a new common helper __gpiod_set_value_nocheck().
>
> Fixes: 02e479808b5d62f8 ("gpio: Alter semantics of *raw* operations to actually be raw")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The bad gpio commit is in v4.15-rc1 and later.
> The i2c commit exposing this is not yet upstream, but in i2c/for-next.

Whoops!

It appears Meltdown and Spectre saves my ass because now I have
time to get this upstream before v4.15...

Applied for fixes with the following tweaks: I removed the __prefix (I don't
like them) and added kerneldoc.

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1693bb9ab72c..14532d9576e4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2892,7 +2892,16 @@ void gpiod_set_raw_value(struct gpio_desc
*desc, int value)
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_value);

-static void __gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
+/**
+ * gpiod_set_value_nocheck() - set a GPIO line value without checking
+ * @desc: the descriptor to set the value on
+ * @value: value to set
+ *
+ * This sets the value of a GPIO line backing a descriptor, applying
+ * different semantic quirks like active low and open drain/source
+ * handling.
+ */
+static void gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
 {
        if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
                value = !value;
@@ -2919,7 +2928,7 @@ void gpiod_set_value(struct gpio_desc *desc, int value)
 {
        VALIDATE_DESC_VOID(desc);
        WARN_ON(desc->gdev->chip->can_sleep);
-       __gpiod_set_value_nocheck(desc, value);
+       gpiod_set_value_nocheck(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_value);

@@ -3247,7 +3256,7 @@ void gpiod_set_value_cansleep(struct gpio_desc
*desc, int value)
 {
        might_sleep_if(extra_checks);
        VALIDATE_DESC_VOID(desc);
-       __gpiod_set_value_nocheck(desc, value);
+       gpiod_set_value_nocheck(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);


Yours,
Linus Walleij
