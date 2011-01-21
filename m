From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 6/6] i2c/pxa2xx: pass of_node from platform driver to
 adapter and publish
Date: Fri, 21 Jan 2011 12:32:39 -0700
Message-ID: <AANLkTinh4395wuWwH2E2kJG+rhMXUzFeGekeugyCSzWt@mail.gmail.com>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de> <1294246263-31960-7-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1294246263-31960-7-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 5, 2011 at 9:51 AM, Sebastian Andrzej Siewior
<bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> the of_node will auto-publish devices which are added to the device
> tree.
>
> Commit 925bb9c6 aka ("of/i2c: Fix module load order issue caused by
> of_i2c.c) moved the of_i2c_register_devices() function from the i2c c=
ore
> back to the drivers. This patch does the same thing for the pxa drive=
r.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Ben, I'll leave you to pick this one up.

g.

> ---
> =A0drivers/i2c/busses/i2c-pxa.c | =A0 =A05 +++++
> =A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-px=
a.c
> index bfd115d..a90739b 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -29,6 +29,7 @@
> =A0#include <linux/errno.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/i2c-pxa.h>
> +#include <linux/of_i2c.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/err.h>
> =A0#include <linux/clk.h>
> @@ -1138,6 +1139,9 @@ static int i2c_pxa_probe(struct platform_device=
 *dev)
>
> =A0 =A0 =A0 =A0i2c->adap.algo_data =3D i2c;
> =A0 =A0 =A0 =A0i2c->adap.dev.parent =3D &dev->dev;
> +#ifdef CONFIG_OF
> + =A0 =A0 =A0 i2c->adap.dev.of_node =3D dev->dev.of_node;
> +#endif
>
> =A0 =A0 =A0 =A0if (i2c_type =3D=3D REGS_CE4100)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D i2c_add_adapter(&i2c->adap);
> @@ -1147,6 +1151,7 @@ static int i2c_pxa_probe(struct platform_device=
 *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "I2C: Failed to add b=
us\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto eadapt;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 of_i2c_register_devices(&i2c->adap);
>
> =A0 =A0 =A0 =A0platform_set_drvdata(dev, i2c);
>
> --
> 1.7.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
