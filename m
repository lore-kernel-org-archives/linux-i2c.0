From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH V2] drivers/i2c/busses/i2c-at91.c: fix brokeness
Date: Mon, 7 Nov 2011 11:01:27 +0100
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B38B21C@wm021.weinmann.com>
References: <alpine.DEB.2.00.1111071019560.21431@gatekeeper.vosshq.de>
 <20111107094701.GF4265@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111107094701.GF4265-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "'balbi-l0cyMroinI0@public.gmane.org'" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'>, "'nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "'plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org'" <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

> IMHO, you should split this patch into three or more smaller patches.
> You're doing lots of different things in one commit and it'll be a pain to
> bisect should this cause any issues to anyone.

I didn't split the patch because it is virtually a complete rewrite.
Due to the severe limitations of the old driver, I think it should
replace the old driver.

> > +/* -*- linux-c -*-
> 
> you shouldn't add this editor hooks to linux source files.

Ok.


> > -static int at91_i2c_resume(struct platform_device *pdev)
> > +static int at91_i2c_resume(struct device *dev)
> >  {
> > -	return clk_enable(twi_clk);
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct at91_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
> 
> dev_get_drvdata(dev) will do the same of two above lines. You don't need to
> fetch the platform_device...

Ok.

> > -MODULE_AUTHOR("Rick Bronson");
> > +MODULE_AUTHOR("Nikolaus Voss");
> 
> wow... are you sure ? Rick will always be the original author, no ?

Yes, of course, but I don't want to declare him responsible for my
own mistakes. The new driver has almost nothing to do with the old.

Thanks for your *very* fast reply and review.

Niko
