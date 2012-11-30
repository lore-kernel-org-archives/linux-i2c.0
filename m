From: "sander van ginkel" <sander-fTxOWN6e5APJxEgaCYcSJA@public.gmane.org>
Subject: Re: [PATCH] add hardware I2C support for ARM IMX23
Date: Fri, 30 Nov 2012 17:32:24 +0100
Message-ID: <20121130173224.10203ha9fee3y36g@62.129.139.42>
References: <20121128152403.45224dvyaufb1j7n@62.129.139.42>
	<20121128150851.GA4659@pengutronix.de>
	<20121128171039.14705ltphptrp5kv@62.129.139.42>
	<20121128162452.GB4659@pengutronix.de> <50B63F81.4050008@van-ginkel.eu>
	<20121128170907.GC4659@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121128170907.GC4659-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> You might want to try my for-next branch or wait for 3.8-rc1, maybe
the
> DMA termination patch helps? Also enabling I2C debug messages is
> probably worth it.
>
> Regards,
>
>    Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang
      |
> Industrial Linux Solutions                 |
http://www.pengutronix.de/  |
>

I've tested your git tree, with the same config as I used for the  
3.7.0-rc6 release (IMX i2c build in)
It's not a 100% fix

If I do "i2cdetect -y -r 0" with 3.7.0-rc6, i2cdetect gets confused  
and the kernel keeps dumping "mxs-i2c 80058000.i2c: Failed to get PIO  
reg. write descriptor."
If I do the same with your git release I get the same result, but only  
when i2cdetect is running. When it's finished or I terminate, the  
kprint will also disappear.
So there is some improvement but not 100% yet.
