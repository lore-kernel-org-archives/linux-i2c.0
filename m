From: Lu Jingchang-B35083 <B35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v2 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
Date: Fri, 2 Aug 2013 05:19:21 +0000
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851FBA70@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1371545327-12481-1-git-send-email-b35083@freescale.com>
 <20130801203301.GB5117@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130801203301.GB5117-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Estevam Fabio-R49496 <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jin Zhengxiong-R64188 <R64188-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Li Xiaochun-B41219 <B41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



> Using a struct type with a div and regval member would make the code
> surrounding this array more obviously correct. Would be nice to
> straighten this first before adding another array.
> 
> How about adding a regshift member instead? It seems shifting the vybrid
> registers by two bits is the imx registers.

 [Lu Jingchang-B35083] 
  Yes, using a struct for the i2c clock {div, regval} pairs would be more readable,
and the registers indeed have the same address offset.  I'll make some change and send
the v3 patch. Thanks!


Best Regards,
Jingchang
