From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH] gpio: Add missing open drain/source handling to =?iso-8859-1?Q?gpiod=5Fset=5Fvalue=5Fcansleep()?=
Date: Thu, 11 Jan 2018 11:29:42 +0100
Message-ID: <02320234-166e-42a2-b076-2c08284d3c99@cesnet.cz>
References: <1515521301-4375-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from office2.cesnet.cz ([195.113.144.244]:41416 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754112AbeAKK3p (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 11 Jan 2018 05:29:45 -0500
In-Reply-To: <1515521301-4375-1-git-send-email-geert+renesas@glider.be>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On =C3=BAter=C3=BD 9. ledna 2018 19:08:21 CET, Geert Uytterhoeven wrote:
> Since commit f11a04464ae57e8d ("i2c: gpio: Enable working over slow
> can_sleep GPIOs"), probing the i2c RTC connected to an i2c-gpio bus on
> r8a7740/armadillo fails with:
>
>     rtc-s35390a 0-0030: error resetting chip
>     rtc-s35390a: probe of 0-0030 failed with error -5
>
> More debug code reveals:
>
>     i2c i2c-0: master_xfer[0] R, addr=3D0x30, len=3D1
>     i2c i2c-0: NAK from device addr 0x30 msg #0
>     s35390a_get_reg: ret =3D -6
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
> Fixes: 02e479808b5d62f8 ("gpio: Alter semantics of *raw*=20
> operations to actually be raw")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The bad gpio commit is in v4.15-rc1 and later.
> The i2c commit exposing this is not yet upstream, but in i2c/for-next.
> ---
>  drivers/gpio/gpiolib.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 358bce6e798b476c..7761d632a5b0dd20 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2927,6 +2927,18 @@ void gpiod_set_raw_value(struct=20
> gpio_desc *desc, int value)
>  }
>  EXPORT_SYMBOL_GPL(gpiod_set_raw_value);
> =20
> +static void __gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
> +{
> +=09if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
> +=09=09value =3D !value;
> +=09if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
> +=09=09gpio_set_open_drain_value_commit(desc, value);
> +=09else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
> +=09=09gpio_set_open_source_value_commit(desc, value);
> +=09else
> +=09=09gpiod_set_raw_value_commit(desc, value);
> +}
> +
>  /**
>   * gpiod_set_value() - assign a gpio's value
>   * @desc: gpio whose value will be assigned
> @@ -2941,16 +2953,8 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_value);
>  void gpiod_set_value(struct gpio_desc *desc, int value)
>  {
>  =09VALIDATE_DESC_VOID(desc);
> -=09/* Should be using gpiod_set_value_cansleep() */
>  =09WARN_ON(desc->gdev->chip->can_sleep);
> -=09if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
> -=09=09value =3D !value;
> -=09if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
> -=09=09gpio_set_open_drain_value_commit(desc, value);
> -=09else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
> -=09=09gpio_set_open_source_value_commit(desc, value);
> -=09else
> -=09=09gpiod_set_raw_value_commit(desc, value);
> +=09__gpiod_set_value_nocheck(desc, value);
>  }
>  EXPORT_SYMBOL_GPL(gpiod_set_value);
> =20
> @@ -3277,9 +3281,7 @@ void gpiod_set_value_cansleep(struct=20
> gpio_desc *desc, int value)
>  {
>  =09might_sleep_if(extra_checks);
>  =09VALIDATE_DESC_VOID(desc);
> -=09if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
> -=09=09value =3D !value;
> -=09gpiod_set_raw_value_commit(desc, value);
> +=09__gpiod_set_value_nocheck(desc, value);
>  }
>  EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
> =20

I realize that I'm late to the party (a merge request has been sent), but I=20=

can confirm that I tested that this still works for a bitbang I2C over GPIO=20=

pins connected to MAX14830 managed by max310x.

Tested-By: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

Cheers,
Jan
