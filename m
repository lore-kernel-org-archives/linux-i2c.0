From: christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org
Subject: Re: [PATCH] i2c: designware: Suppress error message if platform_get_irq() returns
 -EPROBE_DEFER
Date: Tue, 3 Mar 2015 17:50:55 +0100
Message-ID: <OF441D1D4D.39476C28-ONC1257DFD.005BE73C-C1257DFD.005C7908@alitech.com>
References: <1425396456-10633-1-git-send-email-abrodkin@synopsys.com>	 <54F5E120.3090705@alitech.com> <1425400650.17965.53.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425400650.17965.53.camel-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org" <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Alexey,

Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org> wrote on 03/03/2015 05:37:31 
PM:

> From:
> 
> Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> 
> To:
> 
> "christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org" <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>, 
> 
> Cc:
> 
> "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
> "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 
> "Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "wsa@the-
> dreams.de" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" 
> <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" 
> <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org" 
> <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> 
> Date:
> 
> 03/03/2015 05:38 PM
> 
> Subject:
> 
> Re: [PATCH] i2c: designware: Suppress error message if 
> platform_get_irq() returns -EPROBE_DEFER
> 
> Hi Christian,
> [...]
> > > 
> > >     irq = platform_get_irq(pdev, 0);
> > >     if (irq < 0) {
> > > -      dev_err(&pdev->dev, "no irq resource?\n");
> > > +      if (irq != -EPROBE_DEFER)
> > > +         dev_err(&pdev->dev, "no irq resource?\n");
> > 
> > Presented like this I wonder if this merits being a dev_err at all.
> > Wouldn't dev_dbg be more adequate? This might remove the need for the
> > condition and also avoid bothering everyone if something in the 
platform
> > device structures or device tree is not right.
> > 
> > >        return irq; /* -ENXIO */
> > >     }
> 
> We've just had similar discussion related to DW APB UART with Andy here
> https://lkml.org/lkml/2015/3/3/412
> 
> So yes probably we may safely remove error message from here completely.

I agree. Although you do have a point (in the other thread) when saying 
this
kind of messages can be useful in some situations. The process of 
debugging
device tree and platform device setup is definitely more painful for 
drivers
which omit this type of messages completely. Andy's proposal of 
centralising
this looks like a very good solution here (and on top of that removes many
useless strings from the kernel binary).

Greetings,
  Christian
