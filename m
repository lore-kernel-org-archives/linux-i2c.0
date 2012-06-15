From: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: Re: Fwd: [PATCH 1/3] i2c: Add Device Tree support to the Nomadik
 I2C driver
Date: Fri, 15 Jun 2012 18:35:46 +0530
Message-ID: <20120615130544.GA28537@bnru02>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD8BAD2.50703@linaro.org>
 <CACRpkdZFi34nChnMEo6yik67zk9owZLk-6zcdP7mmOXyLz8uqQ@mail.gmail.com>
 <4FDAFA17.6050502@linaro.org>
 <CAE2-_9rRYxjU9QQgtBv9ReMY5x+oRiJG1cDQahYHanjDrwVUYA@mail.gmail.com>
 <20120615115042.GA27480@bnru02>
 <4FDB2E57.4030904@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FDB2E57.4030904-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 15, 2012 at 14:45:11 +0200, Lee Jones wrote:
> On 15/06/12 12:50, Srinidhi Kasagar wrote:
> > [...]
> >>
> >>
> >> From: Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> Date: Tue, 17 Apr 2012 16:04:13 +0100
> >> Subject: [PATCH 1/1] i2c: Add Device Tree support to the Nomadik I=
2C driver
> >>
> >> Here we apply the bindings required for successful Device Tree
> >> probing of the i2c-nomadik driver. We also apply a fall-back
> >> configuration in case either one is not provided, or a required
> >> element is missing from the one supplied.
> >>
> >> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> Signed-off-by: Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> ---
> >>   drivers/i2c/busses/i2c-nomadik.c |   82 ++++++++++++++++++++++++=
+++++++++++++-
> >>   1 file changed, 80 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses=
/i2c-nomadik.c
> >> index a92440d..58e8114 100644
> >> --- a/drivers/i2c/busses/i2c-nomadik.c
> >> +++ b/drivers/i2c/busses/i2c-nomadik.c
> >> @@ -23,6 +23,7 @@
> >>   #include<linux/io.h>
> >>   #include<linux/regulator/consumer.h>
> >>   #include<linux/pm_runtime.h>
> >> +#include<linux/of.h>
> >>
> >>   #include<plat/i2c.h>
> >>
> >> @@ -899,15 +900,86 @@ static const struct i2c_algorithm nmk_i2c_al=
go =3D {
> >>         .functionality  =3D nmk_i2c_functionality
> >>   };
> >>
> >> +static struct nmk_i2c_controller u8500_i2c =3D {
> >> +       /*
> >> +        * Slave data setup time; 250ns, 100ns, and 10ns, which
> >> +        * is 14, 6 and 2 respectively for a 48Mhz i2c clock.
> >> +        */
> >> +       .slsu           =3D 0xe,
> >> +       .tft            =3D 1,      /* Tx FIFO threshold */
> >> +       .rft            =3D 8,      /* Rx FIFO threshold */
> >> +       .clk_freq       =3D 100000, /* std. mode operation */
> >> +       .timeout        =3D 200,    /* Slave response timeout(ms) =
*/
> >> +       .sm             =3D I2C_FREQ_MODE_FAST,
> >
> > How is this possible? you are setting clk_freq as 100kb/s and mode
> > as fast mode which is supposed to be 400kb/s.
>=20
> That's not how I read it:

But it is not readable. It confuses people.

>=20
> > enum i2c_freq_mode {
> >         I2C_FREQ_MODE_STANDARD,         /* up to 100 Kb/s */
> >         I2C_FREQ_MODE_FAST,             /* up to 400 Kb/s */
> >         I2C_FREQ_MODE_HIGH_SPEED,       /* up to 3.4 Mb/s */
> >         I2C_FREQ_MODE_FAST_PLUS,        /* up to 1 Mb/s */
> > };
>=20
> The operative words here are "up to".

I know, then none of these modes does not make sense.

>=20
> >> +};
> >> +
> >> +static int __devinit
> >> +nmk_i2c_of_probe(struct device_node *np, struct nmk_i2c_controlle=
r *pdata)
> >> +{
> >> +       of_property_read_u32(np, "clock-frequency", (u32*)&pdata->=
clk_freq);
> >> +       if (!pdata->clk_freq) {
> >> +               pr_warn("%s: Clock frequency not found\n", np->ful=
l_name);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       of_property_read_u32(np, "stericsson,slsu", (u32*)&pdata->=
slsu);
> >> +       if (!pdata->slsu) {
> >> +               pr_warn("%s: Data line delay not found\n", np->ful=
l_name);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       of_property_read_u32(np, "stericsson,tft", (u32*)&pdata->t=
ft);
> >> +       if (!pdata->tft) {
> >> +               pr_warn("%s: Tx FIFO threshold not found\n", np->f=
ull_name);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       of_property_read_u32(np, "stericsson,rft", (u32*)&pdata->r=
ft);
> >> +       if (!pdata->rft) {
> >> +               pr_warn("%s: Rx FIFO threshold not found\n", np->f=
ull_name);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       of_property_read_u32(np, "stericsson,timeout", (u32*)&pdat=
a->timeout);
> >> +       if (!pdata->timeout) {
> >> +               pr_warn("%s: Timeout not found\n", np->full_name);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (of_get_property(np, "stericsson,i2c_freq_mode_fast", N=
ULL))
> >> +               pdata->sm =3D I2C_FREQ_MODE_FAST;
> >> +       else
> >> +               pdata->sm =3D I2C_FREQ_MODE_STANDARD;
> >
> > The controller has more modes like fast mode plus and high speed mo=
de. You can't make
> > assumptions like this.
>=20
> These are currently unsupported. Read the comments in the file:

I wrote this code, I remember these comments very well :)

>=20
> > 	/*
> > 	 * set the speed mode. Currently we support
> > 	 * only standard and fast mode of operation
> > 	 * TODO - support for fast mode plus (up to 1Mb/s)
> > 	 * and high speed (up to 3.4 Mb/s)
> > 	 */
>=20
> I can add a similar comment here if it make you feel better?

Please.

>=20
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   static int __devinit nmk_i2c_probe(struct platform_device *pdev)
> >>   {
> >>         int ret =3D 0;
> >>         struct resource *res;
> >> -       struct nmk_i2c_controller *pdata =3D
> >> -                       pdev->dev.platform_data;
> >> +       struct nmk_i2c_controller *pdata =3D pdev->dev.platform_da=
ta;
> >> +       struct device_node *np =3D pdev->dev.of_node;
> >>         struct nmk_i2c_dev      *dev;
> >>         struct i2c_adapter *adap;
> >>
> >> +       if (np) {
> >> +               if (!pdata) {
> >> +                       pdata =3D devm_kzalloc(&pdev->dev, sizeof(=
*pdata), GFP_KERNEL);
> >> +                       if (!pdata) {
> >> +                               ret =3D -ENOMEM;
> >> +                               goto err_no_mem;
> >> +                       }
> >> +               }
> >> +               ret =3D nmk_i2c_of_probe(np, pdata);
> >> +               if (ret)
> >> +                       kfree(pdata);
> >> +       }
> >> +
> >> +       if (!pdata)
> >> +               /* No i2c configuration found, using the default. =
*/
> >> +               pdata =3D&u8500_i2c;
> >
> > There are redundant fallback configurations exists in the driver. Y=
ou might need to remove
> > those, if you want to fallback here.
>=20
> I only see a fall-back for clk_freq. Are there others?

No, I can see that it only exists in setup_i2c_controller(). Please fix=
=2E

>=20
> >> +
> >>         dev =3D kzalloc(sizeof(struct nmk_i2c_dev), GFP_KERNEL);
> >>         if (!dev) {
> >>                 dev_err(&pdev->dev, "cannot allocate memory\n");
> >> @@ -1038,11 +1110,17 @@ static int __devexit nmk_i2c_remove(struct=
 platform_device *pdev)
> >>         return 0;
> >>   }
> >>
> >> +static const struct of_device_id nmk_gpio_match[] =3D {
> >> +       { .compatible =3D "st,nomadik-i2c", },
> >> +       {},
> >> +};
> >> +
> >>   static struct platform_driver nmk_i2c_driver =3D {
> >>         .driver =3D {
> >>                 .owner =3D THIS_MODULE,
> >>                 .name =3D DRIVER_NAME,
> >>                 .pm =3D&nmk_i2c_pm,
> >> +               .of_match_table =3D nmk_gpio_match,
> >>         },
> >>         .probe =3D nmk_i2c_probe,
> >>         .remove =3D __devexit_p(nmk_i2c_remove),
> >> --
> >> 1.7.9.5
> >>
>=20
> Kind regards,
> Lee
>=20
> --=20
> Lee Jones
> Linaro ST-Ericsson Landing Team Lead
> M: +44 77 88 633 515
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
