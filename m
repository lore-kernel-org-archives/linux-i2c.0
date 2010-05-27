From: Robert Emanuele <rob-3bOSxtzXIkJzbRFIqnYvSA@public.gmane.org>
Subject: Re: Controlling Driver Load Order
Date: Thu, 27 May 2010 10:07:08 -0700
Message-ID: <AANLkTilKUfcYsPqr5kXlONJQAFCaE8D8U9ltQybIzCPu@mail.gmail.com>
References: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com>
	<AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com>
	<20100526235246.GA31068@pengutronix.de>
	<AANLkTikj8yGSK5Ovud_k8f6jWloojqDJmQ_H6pD_IFgM@mail.gmail.com>
	<20100527041358.GA14070@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100527041358.GA14070-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

I am using the i2c-gpio.c driver, not the i2c-at91 driver.  The Atmel
folks have expressed concerns over their i2c silicon and wrote a gpio
version.

Anyway, I better understand the subsys_initcall now and applied that
to the i2c-gpio and my i2c chip driver.  That worked perfectly for my
issue.  I'd be happy to return a patch of this.  Would be this the
sort of thing that would benefit from a config option?  Something
like:

#if defined(CONFIG_EARLY_i2C_GPIO)
subsys_initcall(i2c_gpio_init);
#else
module_init(i2c_gpio_init);
#endif

I appreciate your help and direction.

Thank you,

Rob

On Wed, May 26, 2010 at 9:13 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> On Wed, May 26, 2010 at 06:39:13PM -0700, Robert Emanuele wrote:
>
>> Still the framebuffer device would initialize first and it would lac=
k
>> having the i2c chips it needs ready. =A0That is the order I'm trying=
 to
>> straighten out.
>
> Understood. Our pointers were probably not precise enough, sorry. Ple=
ase try
> this patch and give a Tested-by-tag if it solves your problems.
>
> From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Date: Thu, 27 May 2010 06:03:48 +0200
> Subject: [PATCH] i2c-at91: use subsys_initcall() for early initializa=
tion
>
> I2C needs to be available early, so other subsystems can access it.
>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Robert Emanuele <rob-3bOSxtzXIkJzbRFIqnYvSA@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> ---
>
> =A0drivers/i2c/busses/i2c-at91.c | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-a=
t91.c
> index 305c075..bea5794 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -313,13 +313,12 @@ static int __init at91_i2c_init(void)
> =A0{
> =A0 =A0 =A0 =A0return platform_driver_register(&at91_i2c_driver);
> =A0}
> +subsys_initcall(at91_i2c_init);
>
> =A0static void __exit at91_i2c_exit(void)
> =A0{
> =A0 =A0 =A0 =A0platform_driver_unregister(&at91_i2c_driver);
> =A0}
> -
> -module_init(at91_i2c_init);
> =A0module_exit(at91_i2c_exit);
>
> =A0MODULE_AUTHOR("Rick Bronson");
>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkv98YYACgkQD27XaX1/VRsvlwCffUOH2qAsWbaG2EmIf1Cl2H+I
> 8P4AoInnCS69XCfq6wIFku1hUgeT8hlG
> =3DvGcD
> -----END PGP SIGNATURE-----
>
>
