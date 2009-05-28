From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: driver for the Synopsys DesignWare I2C controller
Date: Thu, 28 May 2009 09:32:37 +0200
Message-ID: <63386a3d0905280032x7f427213t2b9b027d5be2a472@mail.gmail.com>
References: <1242725005-6431-1-git-send-email-baruch@tkos.co.il>
	 <63386a3d0905271223k470bb89elbbb566b68c0d7cd7@mail.gmail.com>
	 <20090528041051.GB4855@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090528041051.GB4855@tarshish>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2009/5/28 Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>:

>> > +static int dw_i2c_probe(struct platform_device *pdev)
>>
>> Can you tag this with __init?
>
> OK. __devinit is probably better.

(and same for exit)

Look in include/linux/init.h for the use of these macros. There
are many, many erroneous drivers in the kernel, and I think it
is mainly due to the fact that __devinit looks like it has something
to do with "devices", while it does not.

It should be named __hotpluginit or something so one can see
what it actually is.

I don't think any platform_device tagged with __devinit is
correct really, platform_device:s cannot  be hotplugged that's
against the definition of a platform_device.

I should make more cleanup patches regarding this...

Linus
