From: "Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v4] i2c/at91: adopt pinctrl support
Date: Tue, 11 Nov 2014 00:53:58 +0000
Message-ID: <B256D81BAE5131468A838E5D7A243641BFC71DAA@penmbx01>
References: <1415584552-11390-1-git-send-email-wenyou.yang@atmel.com>
 <54609DD8.8030903@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54609DD8.8030903-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Desroches, Ludovic" <Ludovic.Desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: "khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Ferre, Nicolas" <Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org]
> Sent: Monday, November 10, 2014 7:13 PM
> To: Yang, Wenyou; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; Desroches, Ludovic
> Cc: khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Ferre, Nicolas; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH v4] i2c/at91: adopt pinctrl support
> 
> Hello.
> 
> On 11/10/2014 4:55 AM, Wenyou Yang wrote:
> 
> > Amend the at91 i2c pin controller
> 
>     You're amending the hardware itself, really? :-)
> 
> > to optionally take a pin controlhandle
> 
>     I don't see the code that does this.
> 
> > and set the state of the pins to:
> > - "default" on boot and resume.
> 
>     I don't see where you are changing anything for the probe() method.
> Perhaps you meant the driver core code which selects the dafault profile
> automatically?
Yes, the driver core code default do, so remove the redundant code from _probe function.

> 
> > - "sleep" on suspend().
> 
> > This should make it possible to optimize energy usage for the pins
> > both for the suspend/resume cycle
> 
> > Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> > ---
> > Hi Wolfram,
> >
> > Thanks a lot.
> >
> > The change of this version is to remove
> > 	pinctrl_pm_select_default_state(&pdev->dev) from the _probe function.
> 
>     Aha, you've specifically removed this...
> 
> WBR, Sergei

Best Regards,
Wenyou Yang
