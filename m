From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] ARM: Tegra: i2c driver
Date: Mon, 20 Jun 2011 22:59:28 -0600
Message-ID: <BANLkTi=aaSnT-incv3FhOZ0Yp8CtYf31mA@mail.gmail.com>
References: <20110621002318.8086.48367.stgit@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110621002318.8086.48367.stgit@riker>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: kradtke-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Olof Johansson <olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 20, 2011 at 6:23 PM, John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrot=
e:
> This patch modifies the tegra i2c driver so that it can be initiailiz=
ed
> using the device tree along with the devices connected to the i2c bus=
=2E
>
> Signed-off-by: John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
>
> =A0drivers/i2c/busses/i2c-tegra.c | =A0 17 ++++++++++++++++-
> =A01 files changed, 16 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-=
tegra.c
> index 4d93196..d2393e6 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -26,6 +26,7 @@
> =A0#include <linux/delay.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/i2c-tegra.h>
> +#include <linux/of_i2c.h>
>
> =A0#include <asm/unaligned.h>
>
> @@ -540,6 +541,7 @@ static int tegra_i2c_probe(struct platform_device=
 *pdev)
> =A0 =A0 =A0 =A0struct resource *iomem;
> =A0 =A0 =A0 =A0struct clk *clk;
> =A0 =A0 =A0 =A0struct clk *i2c_clk;
> + =A0 =A0 =A0 const unsigned int *prop;
> =A0 =A0 =A0 =A0void *base;
> =A0 =A0 =A0 =A0int irq;
> =A0 =A0 =A0 =A0int ret =3D 0;
> @@ -597,7 +599,17 @@ static int tegra_i2c_probe(struct platform_devic=
e *pdev)
> =A0 =A0 =A0 =A0i2c_dev->irq =3D irq;
> =A0 =A0 =A0 =A0i2c_dev->cont_id =3D pdev->id;
> =A0 =A0 =A0 =A0i2c_dev->dev =3D &pdev->dev;
> - =A0 =A0 =A0 i2c_dev->bus_clk_rate =3D pdata ? pdata->bus_clk_rate :=
 100000;
> +
> + =A0 =A0 =A0 i2c_dev->bus_clk_rate =3D 100000; /* default clock rate=
 */
> + =A0 =A0 =A0 if (pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_dev->bus_clk_rate =3D pdata->bus_cl=
k_rate;
> +
> + =A0 =A0 =A0 } else if (i2c_dev->dev->of_node) { =A0 =A0/* if there =
is a device tree node ... */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D of_get_property(i2c_dev->dev->=
of_node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "clock-=
frequency", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_dev->bus_clk_rate =3D=
 be32_to_cpup(prop);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (pdev->id =3D=3D 3)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c_dev->is_dvc =3D 1;
> @@ -627,6 +639,7 @@ static int tegra_i2c_probe(struct platform_device=
 *pdev)
> =A0 =A0 =A0 =A0i2c_dev->adapter.algo =3D &tegra_i2c_algo;
> =A0 =A0 =A0 =A0i2c_dev->adapter.dev.parent =3D &pdev->dev;
> =A0 =A0 =A0 =A0i2c_dev->adapter.nr =3D pdev->id;
> + =A0 =A0 =A0 i2c_dev->adapter.dev.of_node =3D pdev->dev.of_node;
>
> =A0 =A0 =A0 =A0ret =3D i2c_add_numbered_adapter(&i2c_dev->adapter);
> =A0 =A0 =A0 =A0if (ret) {
> @@ -634,6 +647,8 @@ static int tegra_i2c_probe(struct platform_device=
 *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_irq;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 of_i2c_register_devices(&i2c_dev->adapter);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0err_free_irq:
> =A0 =A0 =A0 =A0free_irq(i2c_dev->irq, i2c_dev);
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
