From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: add reset interface
Date: Wed, 14 Dec 2016 21:00:50 +0200
Message-ID: <1481742050.9552.5.camel@linux.intel.com>
References: <1479789700-19532-1-git-send-email-zhangfei.gao@linaro.org>
         <20161213203457.GB2889@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10790 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754053AbcLNTDy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 14 Dec 2016 14:03:54 -0500
In-Reply-To: <20161213203457.GB2889@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Tue, 2016-12-13 at 21:34 +0100, Wolfram Sang wrote:
> On Tue, Nov 22, 2016 at 12:41:40PM +0800, Zhangfei Gao wrote:
> > Some platforms like hi3660 need do reset first to allow accessing
> > registers
> > 
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> 
> Adding designware maintainers to CC...
> 
> > ---
> >  drivers/i2c/busses/i2c-designware-core.h    | 1 +
> >  drivers/i2c/busses/i2c-designware-platdrv.c | 5 +++++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-designware-core.h
> > b/drivers/i2c/busses/i2c-designware-core.h
> > index 0d44d2a..94b14fa 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.h
> > +++ b/drivers/i2c/busses/i2c-designware-core.h
> > @@ -80,6 +80,7 @@ struct dw_i2c_dev {
> >  	void __iomem		*base;
> >  	struct completion	cmd_complete;
> >  	struct clk		*clk;
> > +	struct reset_control	*rst;
> >  	u32			(*get_clk_rate_khz) (struct
> > dw_i2c_dev *dev);
> >  	struct dw_pci_controller *controller;
> >  	int			cmd_err;
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> > b/drivers/i2c/busses/i2c-designware-platdrv.c
> > index 0b42a12..fd80e58 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/property.h>
> >  #include <linux/io.h>
> > +#include <linux/reset.h>
> >  #include <linux/slab.h>
> >  #include <linux/acpi.h>
> >  #include <linux/platform_data/i2c-designware.h>
> > @@ -176,6 +177,10 @@ static int dw_i2c_plat_probe(struct
> > platform_device *pdev)
> >  	dev->irq = irq;
> >  	platform_set_drvdata(pdev, dev);
> >  
> > +	dev->rst = devm_reset_control_get(&pdev->dev, NULL);
> > +	if (!IS_ERR(dev->rst))
> > +		reset_control_reset(dev->rst);

Do we care about EPROBE_DEFER?

Perhaps on error path we need to assert it.

And I guess it should be devm_reset_control_get_optional().

> > +
> >  	/* fast mode by default because of legacy reasons */
> >  	dev->clk_freq = 400000;
> >  
> > -- 
> > 2.7.4
> > 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
