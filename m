From: "Chaithrika U S" <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 3/4] i2c: davinci: Add suspend/resume support
Date: Wed, 6 Jan 2010 10:26:47 +0530
Message-ID: <000101ca8e8c$a6612370$f3236a50$@com>
References: <1260267218-19406-1-git-send-email-chaithrika@ti.com>	<1260267218-19406-2-git-send-email-chaithrika@ti.com>	<1260267218-19406-3-git-send-email-chaithrika@ti.com>	<1260267218-19406-4-git-send-email-chaithrika@ti.com> <87vdfgrwib.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87vdfgrwib.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Content-Language: en-us
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Kevin Hilman' <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 06, 2010 at 04:26:44, Kevin Hilman wrote:
> Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org> writes:
> 
> > Add suspend and resume callbacks to DaVinci I2C driver.
> > This has been tested on DA850/OMAP-L138 EVM. The SoC specific
> > suspend-to-RAM support patch series [1] is needed to test this feature.
> >
> > [1] http://linux.davincidsp.com/pipermail/davinci-linux-open-source/
> > 2009-November/016958.html
> >
> > Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-davinci.c |   32 ++++++++++++++++++++++++++++++++
> >  1 files changed, 32 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> > index 81c1049..c1c2909 100644
> > --- a/drivers/i2c/busses/i2c-davinci.c
> > +++ b/drivers/i2c/busses/i2c-davinci.c
> > @@ -622,6 +622,36 @@ static int davinci_i2c_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_PM
> > +static int davinci_i2c_suspend(struct platform_device *pdev, pm_message_t state)
> > +{
> > +	struct davinci_i2c_dev *dev = platform_get_drvdata(pdev);
> > +
> > +	/* put I2C into reset */
> > +	davinci_i2c_reset_ctrl(dev, 0);
> > +
> > +	clk_disable(dev->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int davinci_i2c_resume(struct platform_device *pdev)
> > +{
> > +	struct davinci_i2c_dev *dev = platform_get_drvdata(pdev);
> > +
> > +	clk_enable(dev->clk);
> > +
> > +	/* take I2C out of reset */
> > +	davinci_i2c_reset_ctrl(dev, 1);
> > +
> > +	return 0;
> > +}
> > +
> > +#else
> > +#define davinci_i2c_suspend NULL
> > +#define davinci_i2c_resume NULL
> > +#endif
> > +
> >  /* work with hotplug and coldplug */
> >  MODULE_ALIAS("platform:i2c_davinci");
> >  
> > @@ -632,6 +662,8 @@ static struct platform_driver davinci_i2c_driver = {
> >  		.name	= "i2c_davinci",
> >  		.owner	= THIS_MODULE,
> >  	},
> > +	.suspend	= davinci_i2c_suspend,
> > +	.resume		= davinci_i2c_resume,
> 
> Rather than adding these to the platform_driver, you should use dev_pm_ops.
> 
> Something like the patch below on top of your PATCH 3/4 should work.
> 
> Other than this, I'm OK with this series, feel free to add my signoff
> and resend to linux-i2c and LKML.  linux-i2c has had very slow
> response to embedded patches lately.
> 
> Kevin
> 

OK. I will post updated patches soon.

Thanks & Regards, 
Chaithrika
