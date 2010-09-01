From: "Masayuki Ohtake" <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: Re: [MeeGo-Dev][PATCH] Topcliff: Update PCH_I2C driver to 2.6.35
Date: Wed, 1 Sep 2010 14:08:32 +0900
Message-ID: <001e01cb4993$bc0d75d0$66f8800a@maildom.okisemi.com>
References: <4C7DB9CF.5000905@dsn.okisemi.com> <1283309032.1797.123.camel@Joe-Laptop>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Wang Yong Y\"" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Wang Qi\"" <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Andrew\"" <andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Tomoya MORINAGA <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Joe,

I have a question.
Current our I2C driver  has the following 2 patterns dev_err().

(1) dev_err(adap->pch_adapter.dev.parent, "...");

(2) dev_err(&pdev->dev, "...");


> #define pch_err(adap, fmt, arg...) \
> dev_err(adap->pch_adapter.dev.parent, fmt, ##arg)

In case of using the above code, pattern (1) can apply, but (2) can't.

As to (2),
Should we use as dev_err or define another macro?

Thanks, Ohtake(OKISemi)

----- Original Message ----- 
From: "Joe Perches" <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
To: "Masayuki Ohtak" <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>; "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>;
"Crane Cai" <crane.cai-5C7GfCeVMHo@public.gmane.org>; "Samuel Ortiz" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; "Linus Walleij" <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>;
"Ralf Baechle" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>; "srinidhi kasagar" <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>; <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>;
<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; "Wang Yong Y"" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; "Wang Qi"" <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; "Andrew""
<andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; "Tomoya MORINAGA" <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>; "Arnd
Bergmann" <arnd-r2nGTMty4D4@public.gmane.org>
Sent: Wednesday, September 01, 2010 11:43 AM
Subject: Re: [MeeGo-Dev][PATCH] Topcliff: Update PCH_I2C driver to 2.6.35


> On Wed, 2010-09-01 at 11:26 +0900, Masayuki Ohtak wrote:
> > I2C driver of Topcliff PCH
> > +++ b/drivers/i2c/busses/i2c-pch.c
> []
> > +static void pch_init(struct i2c_algo_pch_data *adap)
> []
> > + if (pch_i2c_speed == FAST_MODE_CLK) {
> > + reg_value |= FAST_MODE_EN;
> > + dev_dbg(adap->pch_adapter.dev.parent, "Fast mode enabled\n");
> > + }
>
> Just a suggestion below, ignore it at your pleasure...
>
> These dev_<level> calls might be easier to read if you had
> some #defines like:
>
> #define pch_dbg(adap, fmt, arg...) \
> dev_dbg(adap->pch_adapter.dev.parent, fmt, ##arg)
> #define pch_err(adap, fmt, arg...) \
> dev_err(adap->pch_adapter.dev.parent, fmt, ##arg)
> #define pch_info(adap, fmt, arg...) \
> dev_info(adap->pch_adapter.dev.parent, fmt, ##arg)
>
> then the last dev_dbg becomes:
>
> pch_dbg(adap, "Fast mode enabled\n");
>
> Many modules use similar wrapper #defines.
>
> > + dev_dbg(adap->pch_adapter.dev.parent,
> > + "%s: I2CCTL=%x pch_i2cbc=%x pch_i2ctmr=%x Enable interrupts\n",
> > + __func__, ioread32(p + PCH_I2CCTL),
> > + pch_i2cbc, pch_i2ctmr);
>
> pch_dbg(adap, etc...)
>
> etc.
>
> cheers, Joe
>
