From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] mach-pxa/viper: Fix timeout usage for I2C
Date: Mon, 12 Apr 2010 20:20:10 +0100
Message-ID: <20100412192010.GM3048@n2100.arm.linux.org.uk>
References: <1270390118-1802-1-git-send-email-w.sang@pengutronix.de> <m2rf17812d71004121057n5131d025pb4965f45b61271f@mail.gmail.com> <20100412211319.5a43c65b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100412211319.5a43c65b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>, Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 12, 2010 at 09:13:19PM +0200, Jean Delvare wrote:
> On Tue, 13 Apr 2010 01:57:51 +0800, Eric Miao wrote:
> > On Sun, Apr 4, 2010 at 10:08 PM, Wolfram Sang <w.sang@pengutronix.d=
e> wrote:
> > > The timeout value is in jiffies, so it should be using HZ, not a =
plain
> > > number. Assume '100' means 100ms here and adapt accordingly.
> > >
> > > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> > > Cc: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>
> > > Cc: Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > > Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> > > ---
> > >
> > > Janitorial fix, not tested due to no hardware.
> > >
> > > =A0arch/arm/mach-pxa/viper.c | =A0 =A05 +++--
> > > =A01 files changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.=
c
> > > index 1dd1334..c25921f 100644
> > > --- a/arch/arm/mach-pxa/viper.c
> > > +++ b/arch/arm/mach-pxa/viper.c
> > > @@ -33,6 +33,7 @@
> > > =A0#include <linux/pm.h>
> > > =A0#include <linux/sched.h>
> > > =A0#include <linux/gpio.h>
> > > +#include <linux/jiffies.h>
> > > =A0#include <linux/i2c-gpio.h>
> > > =A0#include <linux/serial_8250.h>
> > > =A0#include <linux/smc91x.h>
> > > @@ -453,7 +454,7 @@ static struct i2c_gpio_platform_data i2c_bus_=
data =3D {
> > > =A0 =A0 =A0 =A0.sda_pin =3D VIPER_RTC_I2C_SDA_GPIO,
> > > =A0 =A0 =A0 =A0.scl_pin =3D VIPER_RTC_I2C_SCL_GPIO,
> > > =A0 =A0 =A0 =A0.udelay =A0=3D 10,
> > > - =A0 =A0 =A0 .timeout =3D 100,
> > > + =A0 =A0 =A0 .timeout =3D HZ / 10,
> > > =A0};
> > >
> > > =A0static struct platform_device i2c_bus_device =3D {
> > > @@ -778,7 +779,7 @@ static void __init viper_tpm_init(void)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.sda_pin =3D VIPER_TPM_I2C_SDA_GPI=
O,
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.scl_pin =3D VIPER_TPM_I2C_SCL_GPI=
O,
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.udelay =A0=3D 10,
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .timeout =3D 100,
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .timeout =3D HZ / 10,
> > > =A0 =A0 =A0 =A0};
> > > =A0 =A0 =A0 =A0char *errstr;
> > >
> >=20
> > One other better and cleaner approach to such inconsistency issue i=
s
> > to have a timeout_ms field, and having i2c-gpio.c driver to convert=
 this
> > to jiffies using msec_to_jiffies() at run-time.
>=20
> With what benefit? Expressing time values in units of HZ is very
> frequent in the kernel code and shouldn't actually surprise anyone.

Actually, this patch shows there is confusion.

"Assume '100' means 100ms here and adapt accordingly."

Since this patch is for ARM, where HZ=3D100, the above patch is not a
simple "convert how we derive this constant" patch - it's a functional
change, reducing the timeouts by a factor of 10.

Could that be because the patch author misinterpreted the HZ-based
values?

I suspect I'm not the only one who thinks that the latter of "HZ / 10"
"100ms" is easier to read and comprehend without mistake.
