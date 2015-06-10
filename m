From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 5/6] i2c: at91: print hardware version
Date: Wed, 10 Jun 2015 10:05:53 +0200
Message-ID: <20150610080553.GO25800@odux.rfo.atmel.com>
References: <cover.1433866582.git.cyrille.pitchen@atmel.com>
 <d1fbf4bce3b470409ef3198f551cfc3f8f22ac78.1433866582.git.cyrille.pitchen@atmel.com>
 <5577428C.3090206@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5577428C.3090206-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 09, 2015 at 10:46:20PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/09/2015 07:22 PM, Cyrille Pitchen wrote:
> 
> >The probe() function now prints the hardware version of the I2C
> >controller.
> 
> >Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >---
> >  drivers/i2c/busses/i2c-at91.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> >diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> >index 817ae69..6e88b30 100644
> >--- a/drivers/i2c/busses/i2c-at91.c
> >+++ b/drivers/i2c/busses/i2c-at91.c
> [...]
> >@@ -908,7 +910,8 @@ static int at91_twi_probe(struct platform_device *pdev)
> >  		return rc;
> >  	}
> >
> >-	dev_info(dev->dev, "AT91 i2c bus driver.\n");
> >+	dev_info(dev->dev, "AT91 i2c bus driver (version: %#x).\n",
> 
>    It looks as if you rather print the driver's version. :-)

>From my point of view, having a version number for a Linux driver would
be strange so it's not confusing.

> 
> >+		 at91_twi_read(dev, AT91_TWI_VER));
> >  	return 0;
> >  }
> 
> WBR, Sergei
> 

Regards

Ludovic
