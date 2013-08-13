From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: =?UTF-8?B?562U5aSNOiBbUEFUQ0ggdjMgMi8yXSBpMmM6IGlteDogQWRkIFY=?=
 =?UTF-8?B?eWJyaWQgVkY2MTAgSTJDIGNvbnRyb2xsZXIgc3VwcG9ydA==?=
Date: Tue, 13 Aug 2013 09:48:40 -0600
Message-ID: <520A5558.708@wwwdotorg.org>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com> <1375418648-22760-2-git-send-email-b35083@freescale.com> <20130810140827.GC18085@e106331-lin.cambridge.arm.com> <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net> <20130812164354.GF27165@e106331-lin.cambridge.arm.com> <52096E77.4040003@wwwdotorg.org> <20130813074620.GR26614@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130813074620.GR26614-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lu Jingchang-B35083 <B35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Estevam Fabio-R49496 <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Li Xiaochun-B41219 <B41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jin Zhengxiong-R64188 <R64188-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, pawel.moll-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/13/2013 01:46 AM, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org wrote:
> On Mon, Aug 12, 2013 at 05:23:35PM -0600, Stephen Warren wrote:
>> On 08/12/2013 10:43 AM, Mark Rutland wrote:
>>>> The binding string for i2c-imx driver in Documentation/devicetree/bindings/i2c/i2c-imx.txt use a wildcard format
>>>> of "- compatible : Should be "fsl,<chip>-i2c" " for device using this driver. Neither fsl,imx1-i2c nor fsl,imx21-i2c
>>>> is described in the binding document. So I just leave the vf610 i2c compatible with this. 
>>>
>>> I'm not a big fan on wildcards in bindings, as it leaves people free to
>>> put anything in and claim it's a documented binding, and makes it far
>>> harder for an os to actually implement drivers for said binding, as
>>> there's no canonical reference for the set of valid variations.
>>>
>>> Obviously there is some precedent, but I'm not sure it's something we
>>> want to stick with, and we can prevent it my updating the documentation
>>> now.
>>>
>>> Does anyone else have an opinion?
>>
>> I suppose technically we should list out every exact string in the
>> binding, but it's a little annoying to have to update the binding doc
>> every time a new chip comes out (and I expect that'll happen more and
>> more!) just to add a new compatible value since all the differences are
>> known internally to the driver and don't impact the binding...
> 
> We would only have to update the the docs when an incompatible SoC comes
> out. For this particular driver this would be all marked with a star:
> 
> * i.MX1
> * i.MX21
>   i.MX25
>   i.MX27
>   i.MX31
>   i.MX35
>   i.MX51
>   i.MX53
>   i.MX6
> * Vybrid
> 
> That's not too many updates to the binding docs since 2001.
> (The SPI core changed with nearly every SoC version though)

So, the SPI core changed its HW implementation, or changed its
SW-visible interface? If the latter, then you need a separate compatible
value for each, which was my point.
