From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH] i2c: driver for the Synopsys DesignWare I2C controller
Date: Sun, 31 May 2009 08:23:45 +0300
Message-ID: <20090531052345.GB14148@tarshish>
References: <1242725005-6431-1-git-send-email-baruch@tkos.co.il> <63386a3d0905271223k470bb89elbbb566b68c0d7cd7@mail.gmail.com> <20090528041051.GB4855@tarshish> <63386a3d0905280032x7f427213t2b9b027d5be2a472@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <63386a3d0905280032x7f427213t2b9b027d5be2a472-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

On Thu, May 28, 2009 at 09:32:37AM +0200, Linus Walleij wrote:
> 2009/5/28 Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>:
> 
> >> > +static int dw_i2c_probe(struct platform_device *pdev)
> >>
> >> Can you tag this with __init?
> >
> > OK. __devinit is probably better.
> 
> I don't think any platform_device tagged with __devinit is
> correct really, platform_device:s cannot  be hotplugged that's
> against the definition of a platform_device.

Doesn't this __devinit have something to do with the ability to compile the 
driver as a module (as is the case here)? See for example 
drivers/watchdog/omap_wdt.c and commit 
0e3912c75f42986c17d955542247bf04c6eef738

> I should make more cleanup patches regarding this...

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
