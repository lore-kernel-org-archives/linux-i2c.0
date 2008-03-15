From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: ISP1301_OMAP: New-style i2c driver
	updates, part 2
Date: Sat, 15 Mar 2008 14:04:54 +0200
Message-ID: <31e679430803150504u290c9e9w781ab6b67768f866@mail.gmail.com>
References: <1199379597-6273-1-git-send-email-me@felipebalbi.com>
	<200802252138.30301.david-b@pacbell.net>
	<31e679430802260122xc30356ayd98fc3c079e613b7@mail.gmail.com>
	<200803071220.10744.david-b@pacbell.net>
	<31e679430803071300w2f2e80ddqd4516a976df4474@mail.gmail.com>
	<20080315125940.2fe84f24@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080315125940.2fe84f24-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, dsaxena-k7pgMgclrJvR7s880joybQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Sat, Mar 15, 2008 at 1:59 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Felipe,
>
>
>
>  On Fri, 7 Mar 2008 23:00:40 +0200, Felipe Balbi wrote:
>  > Hi,
>  >
>  > On Fri, Mar 7, 2008 at 10:20 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> =
wrote:
>  > > On Tuesday 26 February 2008, Felipe Balbi wrote:
>  > >  > >
>  > >  > >  Passing irq_flags???  That sounds like nonsense.  Please expla=
in ...
>  > >  >
>  > >  > request_irq was using different irq flags depending on the board,=
 so
>  > >  > instead of keeping if (machine_is_*) in the driver just because o=
f irq
>  > >  > flags we could bring it from a platform_data.
>  > >
>  > >  Just use the resource type flags ... IORESOURCE_IRQ can
>  > >  be combined with
>  >
>  > but then isp1301 should become a platform_driver, shouldn't it?
>  > I'd need a struct platform_device on the board file and get the device
>  > on probe just to get an irq flag?
>  >
>  > Maybe I'm missing something but I'm understanding something like:
>  >
>  > --- a/arch/arm/mach-omap1/board-h2.c
>  > +++ b/arch/arm/mach-omap1/board-h2.c
>  > @@ -140,6 +140,17 @@ static struct platform_device h2_nor_device =3D {
>  >         .resource       =3D &h2_nor_resource,
>  >  };
>  >
>  > +static struct resource h2_isp1301_resource =3D {
>  > +       .flags          =3D IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
>  > +};
>  > +
>  > +static struct platform_device h2_nor_device =3D {
>  > +       .name           =3D "isp1301_omap",
>  > +       .id             =3D 0,
>  > +       .num_resources  =3D 1,
>  > +       .resource       =3D &h2_isp1301_resource,
>  > +};
>  > +
>  >  static struct mtd_partition h2_nand_partitions[] =3D {
>  >  #if 0
>  >         /* REVISIT:  enable these partitions if you make NAND BOOT
>  > diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1=
301_omap.c
>  > index 4bb931c..d0a5825 100644
>  > --- a/drivers/i2c/chips/isp1301_omap.c
>  > +++ b/drivers/i2c/chips/isp1301_omap.c
>  > @@ -1453,6 +1453,27 @@ isp1301_start_hnp(struct otg_transceiver *dev)
>  >
>  >  /*-------------------------------------------------------------------=
------*/
>  >
>  > +struct platform_driver isp1301_plat_driver =3D {
>  > +       .driver =3D {
>  > +               .name   =3D DRIVER_NAME,
>  > +               .bus    =3D &platform_bus_type,
>  > +               .owner  =3D THIS_MODULE,
>  > +       },
>  > +};
>  > +
>  > +static int __init isp1301_plat_probe(struct platform_device *pdev)
>  > +{
>  > +       struct resource *resource;
>  > +
>  > +       resource =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  > +       if (!resource)
>  > +               return -ENODEV;
>  > +
>  > +       the_transceiver->irq_type =3D resource->flags;
>  > +}
>  > +
>  > +/*-------------------------------------------------------------------=
------*/
>  > +
>  >  /* no error returns, they'd just make bus scanning stop */
>  >  static int __init isp1301_probe(struct i2c_client *client)
>  >  {
>  >
>  > (of course the code above doesn't work, it's just to clear my mind :-p)
>  >
>  > Anyways, wouldn't be easier to put a platform_data that can ship
>  > withing struct i2c_board_info?
>
>  The above looks all wrong to me. The ISP1301 is an I=B2C device, it gets
>  an i2c driver, not a platform driver.

That's what I was trying to say.

>  If you need to pass any extra parameter from the platform code to the
>  isp1301 driver, you must define a custom structure and pass it as
>  i2c_board_info->platform_data. In your case, it would look like:
>
>  struct isp1301_platform_data {
>         int irq_type;
>  }

Yes, I was doing exactly this.

>  David, please correct me if I'm wrong.
>
>  That being said, if many drivers need an irq_type field in addition to
>  the irq number, we might consider adding an irq_type field to struct
>  i2c_board_info and struct i2c_client directly. It probably doesn't make
>  much sense to have irq and irq_type take different routes if they are
>  most often needed together.

Agreed here, the code will also look cleaner if we:

request_irq(client->irq, irq_handler, client->irq_flags,
                   CLIENT_DRIVER_NAME, client);


-- =

Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
