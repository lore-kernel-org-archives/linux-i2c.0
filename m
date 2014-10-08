From: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c driver
Date: Wed, 8 Oct 2014 06:30:14 +0000
Message-ID: <3cd0b028391140b9a75cddf58dbe40b8@DM2PR03MB349.namprd03.prod.outlook.com>
References: <1411632689-31531-1-git-send-email-yao.yuan@freescale.com>
 <1411632689-31531-2-git-send-email-yao.yuan@freescale.com>
 <20141003075441.GA1349@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141003075441.GA1349@katana>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>, "LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org" <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org]
> Sent: Friday, October 03, 2014 3:55 PM
> To: Yuan Yao-B46683
> Cc: marex-ynQEQJNshbs@public.gmane.org; LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; Duan
> Fugang-B38611; shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c
> driver
> > -#include <linux/init.h>
> > -#include <linux/kernel.h>
> > -#include <linux/module.h>
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dmapool.h>
> >  #include <linux/errno.h>
> >  #include <linux/err.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/delay.h>
> >  #include <linux/i2c.h>
> > +#include <linux/init.h>
> >  #include <linux/io.h>
> > -#include <linux/sched.h>
> > -#include <linux/platform_device.h>
> > -#include <linux/clk.h>
> > -#include <linux/slab.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_dma.h>
> >  #include <linux/platform_data/i2c-imx.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> 
> This is a seperate patch.

[Yuan Yao] 
Here I just adjust the order of the include file as alphabetical order.
If it looks strange I can only add the include files about DMA.

> 
> 
> > +	while (1) {
> > +		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +		if (temp & I2SR_ICF)
> > +			break;
> > +		if (time_after(jiffies, orig_jiffies +
> > +				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT))) {
> > +			dev_dbg(dev, "<%s> Timeout\n", __func__);
> > +			return -ETIMEDOUT;
> > +		}
> > +		schedule();
> 
> That might have been asked before. Is there no interrupt for this?
> 

[Yuan Yao] No, there is no interrupt.
After DMA callback, I must wait until the last byte transfer completely.
It's a very short time which less than 10us.
By the way, how about use udelay(10) instead of schedule()?
udelay(10) is waiting a appropriate time.
schedule() is waiting too long for i2c but may be good for whole system.
Can you give me some suggestion?

Thanks for your review.

Best Regards,
Yuan Yao
