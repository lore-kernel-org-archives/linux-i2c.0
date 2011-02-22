From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 1/2] i2c: xiic: Add OF support for Xilinx i2c bus
	interface
Date: Tue, 22 Feb 2011 11:11:26 -0700
Message-ID: <AANLkTi=NLhAiyznBbKjSf7tpeGrGi7NOK2cHUWhfNzG-@mail.gmail.com>
References: <1298396971-611-1-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1298396971-611-1-git-send-email-monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

[cc'ing Ben Dooks, embedded i2c maintainer]

On Tue, Feb 22, 2011 at 10:49 AM, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org> wrote:
> Add OF support to Xilinx i2c bus interface.
> It is used on Microblaze systems.
>
> Signed-off-by: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Ben, since this one depends on a patch in my tree, do you want me to pick i=
t up?

g.

> ---
> =A0drivers/i2c/busses/i2c-xiic.c | =A0 37 +++++++++++++++++++++++++++++--=
------
> =A01 files changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index a9c419e..0b7647b 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -41,6 +41,11 @@
> =A0#include <linux/io.h>
> =A0#include <linux/slab.h>
>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_i2c.h>
> +#include <linux/of_address.h>

Nit: This should not be separate from the rest of the include block.
The blank line between slab.h and of.h can be dropped.

> +
> =A0#define DRIVER_NAME "xiic-i2c"
>
> =A0enum xilinx_i2c_state {
> @@ -426,7 +431,7 @@ static void xiic_process(struct xiic_i2c *i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xiic_wakeup(i2c, STATE_ERR=
OR);
>
> =A0 =A0 =A0 =A0} else if (pend & (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_=
HALF_MASK)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Transmit register/FIFO is empty or =BD e=
mpty */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Transmit register/FIFO is empty or 1/2 e=
mpty */
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clr =3D pend &
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(XIIC_INTR_TX_EMPTY_MASK |=
 XIIC_INTR_TX_HALF_MASK);
> @@ -704,10 +709,6 @@ static int __devinit xiic_i2c_probe(struct platform_=
device *pdev)
> =A0 =A0 =A0 =A0if (irq < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto resource_missing;
>
> - =A0 =A0 =A0 pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.platf=
orm_data;
> - =A0 =A0 =A0 if (!pdata)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> -
> =A0 =A0 =A0 =A0i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> @@ -730,6 +731,7 @@ static int __devinit xiic_i2c_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0i2c->adap =3D xiic_adapter;
> =A0 =A0 =A0 =A0i2c_set_adapdata(&i2c->adap, i2c);
> =A0 =A0 =A0 =A0i2c->adap.dev.parent =3D &pdev->dev;
> + =A0 =A0 =A0 i2c->adap.dev.of_node =3D of_node_get(pdev->dev.of_node);
>
> =A0 =A0 =A0 =A0xiic_reinit(i2c);
>
> @@ -748,9 +750,16 @@ static int __devinit xiic_i2c_probe(struct platform_=
device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto add_adapter_failed;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* add in known devices to the bus */
> - =A0 =A0 =A0 for (i =3D 0; i < pdata->num_devices; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_new_device(&i2c->adap, pdata->devices +=
 i);
> + =A0 =A0 =A0 dev_info(&pdev->dev, "mapped to 0x%08X, irq=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (unsigned int)i2c->base, irq);
> +
> + =A0 =A0 =A0 pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.platf=
orm_data;

While you're touching this code anyway, the cast is unnecessary.

> + =A0 =A0 =A0 if (pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* add in known devices to the bus */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->num_devices; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_new_device(&i2c->adap, =
pdata->devices + i);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 of_i2c_register_devices(&i2c->adap);
>
> =A0 =A0 =A0 =A0return 0;
>
> @@ -799,12 +808,24 @@ static int __devexit xiic_i2c_remove(struct platfor=
m_device* pdev)
> =A0/* work with hotplug and coldplug */
> =A0MODULE_ALIAS("platform:"DRIVER_NAME);
>
> +#ifdef CONFIG_OF
> +/* Match table for of_platform binding */
> +static struct of_device_id __devinitdata xilinx_iic_of_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "xlnx,xps-iic-2.00.a", },
> + =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(of, xilinx_iic_of_match);
> +#else
> +# define xilinx_iic_of_match NULL
> +#endif
> +
> =A0static struct platform_driver xiic_i2c_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =3D xiic_i2c_probe,
> =A0 =A0 =A0 =A0.remove =A0=3D __devexit_p(xiic_i2c_remove),
> =A0 =A0 =A0 =A0.driver =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D DRIVER_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D xilinx_iic_of_match,
> =A0 =A0 =A0 =A0},
> =A0};
>
> --
> 1.5.5.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
