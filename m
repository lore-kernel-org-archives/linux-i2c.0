From: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: i2c-ocores: Use reg-shift property
Date: Thu, 12 Jul 2012 19:32:23 +0530
Message-ID: <20120712140222.GB27050@jayachandranc.netlogicmicro.com>
References: <1341900658-7698-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1341900658-7698-3-git-send-email-jayachandranc@netlogicmicro.com>
 <20120712133157.GI2194@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120712133157.GI2194-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org, Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 12, 2012 at 03:31:57PM +0200, Wolfram Sang wrote:
> On Tue, Jul 10, 2012 at 11:40:56AM +0530, Jayachandran C wrote:
> > From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > 
> > Deprecate 'regstep' property and use the standard 'reg-shift' property
> > for register offset shifts. 'regstep' will still be supported as an
> > optional property, but will give a warning when used.
> > 
> > Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
> > ---
> >  .../devicetree/bindings/i2c/i2c-ocores.txt         |    8 +++--
> >  drivers/i2c/busses/i2c-ocores.c                    |   36 ++++++++++++--------
> >  include/linux/i2c-ocores.h                         |    6 ++--
> >  3 files changed, 31 insertions(+), 19 deletions(-)
> > 
[...]
> > diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> > index e8159db..9617ec1 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -25,10 +25,11 @@
> >  #include <linux/slab.h>
> >  #include <linux/io.h>
> >  #include <linux/of_i2c.h>
> > +#include <linux/log2.h>
> >  
> >  struct ocores_i2c {
> >  	void __iomem *base;
> > -	int regstep;
> > +	int reg_shift;
> 
> Should be u32 since you use of_property_read_u32(). sparse tells you
> that.

We can keep reg_shift as int (fixing the width for reg_shift to 32
is unnecessary), and use a u32 to read the property, see below

> > +	struct device_node *np = pdev->dev.of_node;
> > +	u32 val;
> > +
> > +	if (of_property_read_u32(np, "reg-shift", &i2c->reg_shift)) {
> > +		/* no 'reg-shift', check for deprecated 'regstep' */
> > +		if (!of_property_read_u32(np, "regstep", &val)) {
> > +			if (!is_power_of_2(val)) {
> > +				dev_err(&pdev->dev, "invalid regstep %d\n",
> > +					val);
> > +				return -EINVAL;
> > +			}
> > +			i2c->reg_shift = ilog2(val);
> > +			dev_warn(&pdev->dev,
> > +				"regstep property deprecated, use reg-shift\n");
> > +		}
> >  	}

Will change this to 
	if (of_property_read_u32(np, "reg-shift", &val)) {
		....
	} else
		i2c->reg_shift = val;

[...]
> > diff --git a/include/linux/i2c-ocores.h b/include/linux/i2c-ocores.h
> > index 4d5e57f..bb58c7d 100644
> > --- a/include/linux/i2c-ocores.h
> > +++ b/include/linux/i2c-ocores.h
> > @@ -12,9 +12,9 @@
> >  #define _LINUX_I2C_OCORES_H
> >  
> >  struct ocores_i2c_platform_data {
> > -	u32 regstep;   /* distance between registers */
> > -	u32 clock_khz; /* input clock in kHz */
> > -	u8 num_devices; /* number of devices in the devices list */
> > +	u32 reg_shift;		/* register offset shift value */
> > +	u32 clock_khz;		/* input clock in kHz */
> > +	u8 num_devices;		/* number of devices in the devices list */
> 
> Minor: I'd like to keep the changes here minimal, so 'git blame' will be more
> useful. Given the line below, indentation is not consisten anyhow.

Ok, I will post an updated patchset with the changes.

Regards,
JC.
