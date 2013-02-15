From: Christian Ruppert <christian.ruppert@abilis.com>
Subject: Re: [PATCH] i2c-designware: Interrupt sharing and SDA hold time
Date: Fri, 15 Feb 2013 14:05:10 +0100
Message-ID: <20130215130509.GA29780@ab42.lan>
References: <1360923110-21692-1-git-send-email-christian.ruppert@abilis.com>
 <20130215115037.GT20771@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130215115037.GT20771@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 15, 2013 at 01:50:37PM +0200, Mika Westerberg wrote:
> On Fri, Feb 15, 2013 at 11:11:50AM +0100, Christian Ruppert wrote:
> > This patch implements interrupt sharing and SDA hold time configura=
tion in
> > the designware i2c driver. Both functions are enabled through platf=
orm data
> > or device tree. Tested with Linux-3.8rc4 (Synopsys ARC port, see
> > https://github.com/foss-for-synopsys-dwc-arc-processors/linux/commi=
ts/arc-3.8-baseline).
> >=20
> > Signed-off-by: Christian Ruppert <christian.ruppert@abilis.com>
> > Signed-off-by: Pierrick Hascoet <pierrick.hascoet@abilis.com>
> > ---
> >  .../devicetree/bindings/i2c/i2c-designware.txt     |   18 ++++++++=
++
> >  drivers/i2c/busses/i2c-designware-core.c           |    6 +++
> >  drivers/i2c/busses/i2c-designware-core.h           |    2 +
> >  drivers/i2c/busses/i2c-designware-platdrv.c        |   34 ++++++++=
+++++++++++-
> >  include/linux/i2c/i2c-designware.h                 |   13 +++++++
> >  5 files changed, 72 insertions(+), 1 deletions(-)
> >  create mode 100644 include/linux/i2c/i2c-designware.h
> >=20
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.t=
xt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> > index e42a2ee..474386b 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> > @@ -10,6 +10,12 @@ Recommended properties :
> > =20
> >   - clock-frequency : desired I2C bus clock frequency in Hz.
> > =20
> > +Optional properties :
> > + - interrupts-shared : If this property is present, the interrupt =
line is
> > +   considered shared with other devices.
> > + - sda-hold-time : If this property is present, the register SDA_H=
OLD will
> > +   be initialised with its value.
> > +
> >  Example :
> > =20
> >  	i2c@f0000 {
> > @@ -20,3 +26,15 @@ Example :
> >  		interrupts =3D <11>;
> >  		clock-frequency =3D <400000>;
> >  	};
> > +
> > +	i2c@1120000 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		compatible =3D "snps,designware-i2c";
> > +		reg =3D <0x1120000 0x1000>;
> > +		interrupt-parent =3D <&ictl>;
> > +		interrupts =3D <12 1>;
> > +		interrupts-shared;
> > +		clock-frequency =3D <400000>;
> > +		sda-hold-time =3D <0x64>;
> > +	};
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c=
/busses/i2c-designware-core.c
> > index cbba7db..36ba0b5 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/io.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/delay.h>
> > +#include <linux/i2c/i2c-designware.h>
> >  #include "i2c-designware-core.h"
> > =20
> >  /*
> > @@ -66,6 +67,7 @@
> >  #define DW_IC_STATUS		0x70
> >  #define DW_IC_TXFLR		0x74
> >  #define DW_IC_RXFLR		0x78
> > +#define DW_IC_SDA_HOLD		0x7c
> >  #define DW_IC_TX_ABRT_SOURCE	0x80
> >  #define DW_IC_COMP_PARAM_1	0xf4
> >  #define DW_IC_COMP_TYPE		0xfc
> > @@ -309,6 +311,10 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
> >  	dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
> >  	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT =3D %d:%d\n", hcnt, lcnt);
> > =20
> > +	/* Configure SDA Hold Time if required */
> > +	if (dev->pdat_flags & I2C_DW_PDAT_FLAGS_SET_HOLDTIME)
> > +		dw_writel(dev, dev->sda_hold_time, DW_IC_SDA_HOLD);
>=20
> AFAIK, DW_IC_SDA_HOLD minimum value is 1 so you could just do:
>=20
> 	if (dev->sda_hold_time)
> 		dw_writel(dev, dev->sda_hold_time, DW_IC_SDA_HOLD);

This is correct, I'll modify it.

> Also should this be configurable for standard and fast modes both?
> Something like sm_sda_hold_time and fm_sda_hold_time?

AFAIK the requirements for data hold time do not differ between standar=
d
and fast mode. The hardware seems to have been designed in the same
understanding since it provides two separate register sets for clock
timings in standard and fast modes but only one register for data hold
time. Am I missing something here?

> > +
> >  	/* Configure Tx/Rx FIFO threshold levels */
> >  	dw_writel(dev, dev->tx_fifo_depth - 1, DW_IC_TX_TL);
> >  	dw_writel(dev, 0, DW_IC_RX_TL);
> > diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c=
/busses/i2c-designware-core.h
> > index 9c1840e..ef20477 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.h
> > +++ b/drivers/i2c/busses/i2c-designware-core.h
> > @@ -88,6 +88,8 @@ struct dw_i2c_dev {
> >  	u32			master_cfg;
> >  	unsigned int		tx_fifo_depth;
> >  	unsigned int		rx_fifo_depth;
> > +	u32			sda_hold_time;
> > +	unsigned int		pdat_flags;
> >  };
> > =20
> >  #define ACCESS_SWAP		0x00000001
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/=
i2c/busses/i2c-designware-platdrv.c
> > index 343357a..2ad2da3 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -34,11 +34,13 @@
> >  #include <linux/sched.h>
> >  #include <linux/err.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/of.h>
> >  #include <linux/of_i2c.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm.h>
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> > +#include <linux/i2c/i2c-designware.h>
> >  #include "i2c-designware-core.h"
> > =20
> >  static struct i2c_algorithm i2c_dw_algo =3D {
> > @@ -56,6 +58,28 @@ static int dw_i2c_probe(struct platform_device *=
pdev)
> >  	struct i2c_adapter *adap;
> >  	struct resource *mem, *ioarea;
> >  	int irq, r;
> > +	unsigned long irqf;
> > +	struct i2c_designware_platform_data *pdat =3D pdev->dev.platform_=
data;
> > +
> > +	if ((!pdat) && pdev->dev.of_node) {
> > +		struct device_node *node =3D pdev->dev.of_node;
> > +
> > +		pdat =3D kmalloc(sizeof(struct i2c_designware_platform_data),
> > +				GFP_KERNEL);
> > +		if (!pdat)
> > +			return -ENOMEM;
> > +
> > +		pdat->flags =3D 0;
> > +
> > +		if (of_get_property(node, "interrupts-shared", NULL))
> > +			pdat->flags |=3D I2C_DW_PDAT_FLAGS_SHARE_IRQ;
> > +
> > +		if (!of_property_read_u32(node, "sda-hold-time",
> > +					&pdat->sda_hold_time))
> > +			pdat->flags |=3D I2C_DW_PDAT_FLAGS_SET_HOLDTIME;
> > +
> > +		pdev->dev.platform_data =3D pdat;
>=20
> I do not understand why you need a separate platform data at all? Can=
't you
> do it in a same way than the ACPI code?

I suppose you are referring to dw_i2c_acpi_configure() in i2c/next whic=
h
directly sets the values dev->... This is perfectly feasible and would
greatly simplify the patch. The reason I introduced the platform data
indirection layer is compatibility with legacy instantiations and
platforms that do not yet support device tree. We do not internally nee=
d
that backwards compatibility but does anybody else? Otherwise I'll
remove it.

> And this probably doesn't apply to the i2c/next branch because we add=
ed the
> ACPI enumeration there.

No problem, I'll check the next patch iteration wrt. i2c/next which I
should have probably done in the first place.

> > +	}
> > =20
> >  	/* NOTE: driver uses the static register mapping */
> >  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -120,12 +144,20 @@ static int dw_i2c_probe(struct platform_devic=
e *pdev)
> >  		dev->tx_fifo_depth =3D ((param1 >> 16) & 0xff) + 1;
> >  		dev->rx_fifo_depth =3D ((param1 >> 8)  & 0xff) + 1;
> >  	}
> > +	dev->sda_hold_time =3D pdat->sda_hold_time;
> > +	dev->pdat_flags =3D pdat->flags;
> > +
> >  	r =3D i2c_dw_init(dev);
> >  	if (r)
> >  		goto err_iounmap;
> > =20
> >  	i2c_dw_disable_int(dev);
> > -	r =3D request_irq(dev->irq, i2c_dw_isr, IRQF_DISABLED, pdev->name=
, dev);
> > +
> > +	irqf =3D IRQF_DISABLED;
> > +	if (dev->pdat_flags & I2C_DW_PDAT_FLAGS_SHARE_IRQ)
> > +		irqf |=3D IRQF_SHARED;
>=20
> Please check Wolfram's i2c/next. This is set already there.

Perfect. My fault for not looking there first. Thanks for highlighting
this.

> > +
> > +	r =3D request_irq(dev->irq, i2c_dw_isr, irqf, pdev->name, dev);
> >  	if (r) {
> >  		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
> >  		goto err_iounmap;
> > diff --git a/include/linux/i2c/i2c-designware.h b/include/linux/i2c=
/i2c-designware.h
> > new file mode 100644
> > index 0000000..ea8192a
> > --- /dev/null
> > +++ b/include/linux/i2c/i2c-designware.h
> > @@ -0,0 +1,13 @@
> > +#ifndef __I2C_DESIGNWARE_H__
> > +#define __I2C_DESIGNWARE_H__
> > +
> > +#include <linux/platform_device.h>
> > +
> > +struct i2c_designware_platform_data {
> > +	unsigned int flags;
> > +#define I2C_DW_PDAT_FLAGS_SHARE_IRQ    (1L<<0)
> > +#define I2C_DW_PDAT_FLAGS_SET_HOLDTIME (1L<<1)
> > +	u32          sda_hold_time;
> > +};
> > +
> > +#endif /* __I2C_DESIGNWARE_H__ */
> > --=20
> > 1.7.1
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
