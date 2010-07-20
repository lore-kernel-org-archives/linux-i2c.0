From: "Masayuki Ohtake" <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: Re: [PATCH] I2C driver of Topcliff PCH
Date: Tue, 20 Jul 2010 21:38:22 +0900
Message-ID: <000801cb2808$72aef870$66f8800a@maildom.okisemi.com>
References: <4C204B0D.2030201@dsn.okisemi.com> <201007152135.00280.arnd@arndb.de> <000401cb27c7$ce732960$66f8800a@maildom.okisemi.com> <201007201127.57510.arnd@arndb.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "Wang, Yong Y" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Arnd,

> If you pass IRQF_SHARED, you can register any number of handlers
> for the same IRQ number using different dev pointers.
I will modify like above.

Thanks, Ohtake.
----- Original Message ----- 
From: "Arnd Bergmann" <arnd-r2nGTMty4D4@public.gmane.org>
To: "Masayuki Ohtake" <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>; "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>;
<linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; "LKML" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; "Wang, Yong Y"
<yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, July 20, 2010 6:27 PM
Subject: Re: [PATCH] I2C driver of Topcliff PCH


> On Tuesday 20 July 2010, Masayuki Ohtake wrote:
> > > > +
> > > > + dev_dbg(&pdev->dev,
> > > > + "i2c_add_adapter returns %d for channel-%d\n", ret, i);
> > > > + pch_init(&adap_info->pch_data[i]);
> > > > + dev_dbg(&pdev->dev, "pch_init invoked successfully\n");
> > > > + }
> > > > +
> > > > + ret = request_irq(pdev->irq, &pch_handler, IRQF_SHARED,
> > > > +   MODULE_NAME, adap_info);
> > >
> > > Similarly, you would create a new channel data structure for each channel here
> > > and register it separately, and then request the interrupt with that
> > > data structure as the info.
> >
> > With I2c multi-cahnnel IOH, IRQ number is in common.
> > Thus, I think our PCH I2C driver can't be implemented like above.
>
> If you pass IRQF_SHARED, you can register any number of handlers
> for the same IRQ number using different dev pointers.
>
> Arnd
>
