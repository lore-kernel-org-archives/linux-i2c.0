From: atull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [PATCH] i2c designware add support of I2C standard mode
Date: Wed, 20 Aug 2014 10:25:40 -0500
Message-ID: <alpine.DEB.2.02.1408201021440.11079@atx-linux-37>
References: <20140820124231.GD21734@leverpostej> <1408544948-22339-1-git-send-email-romainba@abilis.com> <alpine.DEB.2.02.1408200928130.11079@atx-linux-37>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1408200928130.11079@atx-linux-37>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, yvanderv-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, Romain Baeriswyl <romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 20 Aug 2014, atull wrote:

> 
> 
> On Wed, 20 Aug 2014, Romain Baeriswyl wrote:
> 
> > From: Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > 
> > Some legacy devices support ony I2C standard mode at 100kHz.
> > This patch allows to select the standard mode through the DTS
> > with the use of the existing clock-frequency parameter.
> > 
> > When clock-frequency parameter is not set, the fast mode is selected.
> > Only when the parameter is set at 100000, the standard mode is selected.
> > 
> > Signed-off-by: Romain Baeriswyl <romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > Reviewed-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-designware-platdrv.c |   23 +++++++++++++++++++++--
> >  1 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> > index 402ec39..b543fe1 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -122,6 +122,7 @@ static int dw_i2c_probe(struct platform_device *pdev)
> >  	struct i2c_adapter *adap;
> >  	struct resource *mem;
> >  	int irq, r;
> > +	u32 clk_freq;
> >  
> >  	irq = platform_get_irq(pdev, 0);
> >  	if (irq < 0) {
> > @@ -151,6 +152,9 @@ static int dw_i2c_probe(struct platform_device *pdev)
> >  		return PTR_ERR(dev->clk);
> >  	clk_prepare_enable(dev->clk);
> >  
> > +	/* fast mode by default because of legacy reasons */
> > +	clk_freq = 400000;
> > +
> >  	if (pdev->dev.of_node) {
> >  		u32 ht = 0;
> >  		u32 ic_clk = dev->get_clk_rate_khz(dev);
> > @@ -166,6 +170,17 @@ static int dw_i2c_probe(struct platform_device *pdev)
> >  		of_property_read_u32(pdev->dev.of_node,
> >  				     "i2c-scl-falling-time-ns",
> >  				     &dev->scl_falling_time);
> > +
> > +		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> > +				     &clk_freq);
> > +
> > +		/* Only standard mode at 100kHz and fast mode at 400kHz
> > +		 * are supported.
> > +		 */
> > +		if (clk_freq != 100000 && clk_freq != 400000) {
> > +			dev_err(&pdev->dev, "Only 100kHz and 400kHz supported");
> > +			return -EINVAL;
> > +		}
> 
> Hi Romain,
> 
> It is common to operate i2c at <100KHz on boards that have i2c 
> issues.  I am using this driver at 50KHz because I have a LCD module 
> that just doesn't work at a full 100KHz.  Please remove the check for 
> these two frequency points.
> 
> >  	}
> >  
> >  	dev->functionality =
> > @@ -175,8 +190,12 @@ static int dw_i2c_probe(struct platform_device *pdev)
> >  		I2C_FUNC_SMBUS_BYTE_DATA |
> >  		I2C_FUNC_SMBUS_WORD_DATA |
> >  		I2C_FUNC_SMBUS_I2C_BLOCK;
> > -	dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
> > -		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
> > +	if (clk_freq == 100000)
> 
> Please change to <=
> 

Hi Romain,

This looks fine to me, my "<= issues" are not important as this isn't 
really setting a frequency, but just setting a bit that controls speed.

Acked-by: Alan Tull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>


> > +		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
> > +			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_STD;
> > +	else
> > +		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
> > +			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
> >  
> >  	/* Try first if we can configure the device from ACPI */
> >  	r = dw_i2c_acpi_configure(pdev);
> > -- 
> > 1.7.1
> > 
> > 
> 
