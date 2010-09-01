From: "Masayuki Ohtake" <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: Re: [MeeGo-Dev][PATCH] Topcliff: Update PCH_I2C driver to 2.6.35
Date: Wed, 1 Sep 2010 14:44:09 +0900
Message-ID: <005801cb4998$b526d9f0$66f8800a@maildom.okisemi.com>
References: <4C7DB9CF.5000905@dsn.okisemi.com> <1283309032.1797.123.camel@Joe-Laptop> <001e01cb4993$bc0d75d0$66f8800a@maildom.okisemi.com> <1283318654.1797.140.camel@Joe-Laptop>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Wang Yong Y\"" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Wang Qi\"" <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Andrew\"" <andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Tomoya MORINAGA <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Joe,

Thank you for your comments.

Best Regards,
Ohtake(OKISemi)

----- Original Message ----- 
From: "Joe Perches" <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
To: "Masayuki Ohtake" <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>; "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>;
"Crane Cai" <crane.cai-5C7GfCeVMHo@public.gmane.org>; "Samuel Ortiz" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; "Linus Walleij" <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>;
"Ralf Baechle" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>; "srinidhi kasagar" <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>; <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>;
<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; "Wang Yong Y"" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; "Wang Qi"" <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; "Andrew""
<andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; "Tomoya MORINAGA" <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>; "Arnd
Bergmann" <arnd-r2nGTMty4D4@public.gmane.org>
Sent: Wednesday, September 01, 2010 2:24 PM
Subject: Re: [MeeGo-Dev][PATCH] Topcliff: Update PCH_I2C driver to 2.6.35


> On Wed, 2010-09-01 at 14:08 +0900, Masayuki Ohtake wrote:
> > I have a question.
> > Current our I2C driver  has the following 2 patterns dev_err().
> > (1) dev_err(adap->pch_adapter.dev.parent, "...");
> > (2) dev_err(&pdev->dev, "...");
> > > #define pch_err(adap, fmt, arg...) \
> > > dev_err(adap->pch_adapter.dev.parent, fmt, ##arg)
> > In case of using the above code, pattern (1) can apply, but (2) can't.
> > As to (2),
> > Should we use as dev_err or define another macro?
>
> Hello Ohtake.
>
> To me, it's a visual complexity vs std pattern trade-off.
>
> A 2 level dereference like dev_info(&dev->dev, ...)
> isn't overly difficult to read.
> 3 or more dereferences can be harder and a bit error prone.
> So I would only use pch_<level> for (1) and dev_err for (2).
>
> There are also times when there are additional standard
> arguments that you want to prefix to dev_<level> calls
> and that can be simplified with a custom XXX_<level>
> define for dev_<level>
>
> Look at the current uses in the tree and see what you like.
>
> $ grep -rP --include=*.[ch] "#define\s*.+\s+dev_[a-z]{3,7}\s*\(" *
>
> These aren't requirements, do what you think best.
>
> cheers, Joe
>
