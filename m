From: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] mach-pxa/viper: Fix timeout usage for I2C
Date: Tue, 20 Apr 2010 08:20:46 +0800
Message-ID: <z2xf17812d71004191720o3f8660a4kdd31ef9cdb6beae9@mail.gmail.com>
References: <20100412213235.1688dda8@hyperion.delvare> <1271591309-22567-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1271591309-22567-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>, Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Apr 18, 2010 at 7:48 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> The timeout value is in jiffies, so it should be using HZ, not a plai=
n
> number. Assume with HZ=3D100 '100' means 1s here and adapt accordingl=
y.
>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Cc: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>
> Cc: Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>
> Changes since V1:
>
> * Don't assume 100 means 100ms
>
> Thanks for the comments!
>
> Admitted, the first try was a really bad guess. Maybe I got distracte=
d from the
> previous patch for another arch where the value was 10000.
>
> While this may still not be the favoured solution for Eric, I think i=
t is at
> least better than before, so it might be worth applying after all?

Ack. The clearest fix would involve more code to be updated, which
can be postponed. This fix, at least, makes the time quantity clearer.

>
> Janitorial fix, not tested due to no hardware.
>
> =C2=A0arch/arm/mach-pxa/viper.c | =C2=A0 =C2=A05 +++--
> =C2=A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
> index 1dd1334..12cf38c 100644
> --- a/arch/arm/mach-pxa/viper.c
> +++ b/arch/arm/mach-pxa/viper.c
> @@ -33,6 +33,7 @@
> =C2=A0#include <linux/pm.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/gpio.h>
> +#include <linux/jiffies.h>
> =C2=A0#include <linux/i2c-gpio.h>
> =C2=A0#include <linux/serial_8250.h>
> =C2=A0#include <linux/smc91x.h>
> @@ -453,7 +454,7 @@ static struct i2c_gpio_platform_data i2c_bus_data=
 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.sda_pin =3D VIPER_RTC_I2C_SDA_GPIO,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.scl_pin =3D VIPER_RTC_I2C_SCL_GPIO,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.udelay =C2=A0=3D 10,
> - =C2=A0 =C2=A0 =C2=A0 .timeout =3D 100,
> + =C2=A0 =C2=A0 =C2=A0 .timeout =3D HZ,
> =C2=A0};
>
> =C2=A0static struct platform_device i2c_bus_device =3D {
> @@ -778,7 +779,7 @@ static void __init viper_tpm_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.sda_pin =3D V=
IPER_TPM_I2C_SDA_GPIO,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.scl_pin =3D V=
IPER_TPM_I2C_SCL_GPIO,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.udelay =C2=A0=
=3D 10,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .timeout =3D 100,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .timeout =3D HZ,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *errstr;
>
> --
> 1.7.0
>
>
