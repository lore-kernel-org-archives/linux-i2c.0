From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: driver for the Synopsys DesignWare I2C controller
Date: Mon, 1 Jun 2009 23:53:54 +0100
Message-ID: <20090601225354.GB18453@fluff.org.uk>
References: <1242725005-6431-1-git-send-email-baruch@tkos.co.il> <63386a3d0905271223k470bb89elbbb566b68c0d7cd7@mail.gmail.com> <20090528041051.GB4855@tarshish> <63386a3d0905280032x7f427213t2b9b027d5be2a472@mail.gmail.com> <20090531052345.GB14148@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090531052345.GB14148@tarshish>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, May 31, 2009 at 08:23:45AM +0300, Baruch Siach wrote:
> Hi Linus,
> 
> On Thu, May 28, 2009 at 09:32:37AM +0200, Linus Walleij wrote:
> > 2009/5/28 Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>:
> > 
> > >> > +static int dw_i2c_probe(struct platform_device *pdev)
> > >>
> > >> Can you tag this with __init?
> > >
> > > OK. __devinit is probably better.
> > 
> > I don't think any platform_device tagged with __devinit is
> > correct really, platform_device:s cannot  be hotplugged that's
> > against the definition of a platform_device.

I disagree, just beucase they aren't in general doesn't mean they
cannot be. I have been looking at an implementation which uses
hotplug to generate devices from a board description file.

It also makes life difficult if you want to unbind/bind device via
sysfs. basically, __devinit and __devexit, are in my view the correct
things to use here.
 
> Doesn't this __devinit have something to do with the ability to compile the 
> driver as a module (as is the case here)? See for example 
> drivers/watchdog/omap_wdt.c and commit 
> 0e3912c75f42986c17d955542247bf04c6eef738

This is an example where __devinit/_devexit are being used proplerly.
 
> > I should make more cleanup patches regarding this...
> 
> baruch
> 
> -- 
>                                                      ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
