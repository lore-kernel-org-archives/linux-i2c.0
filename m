From: Lu Jingchang-B35083 <B35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
Date: Tue, 18 Jun 2013 09:22:06 +0000
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851E1ABA@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1371521418-3003-1-git-send-email-b35083@freescale.com>
 <1371521418-3003-2-git-send-email-b35083@freescale.com>
 <20130618084539.GB28384@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130618084539.GB28384-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Estevam Fabio-R49496 <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jin Zhengxiong-R64188 <R64188-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Li Xiaochun-B41219 <B41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org]
>Sent: Tuesday, June 18, 2013 4:46 PM
>To: Lu Jingchang-B35083
>Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; Estevam Fabio-R49496; s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org;
>linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Jin
>Zhengxiong-R64188; Li Xiaochun-B41219
>Subject: Re: [PATCH 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
>
>On Tue, Jun 18, 2013 at 10:10:18AM +0800, Jingchang Lu wrote:
>>   Add Freescale Vybrid VF610 I2C controller support to imx I2C driver
>> framework.
>>   Some operation is different from imx I2C controller.
>> The register offset, the i2c clock divider value table, the module
>> enabling(I2CR_IEN) which is just invert with imx, and the interrupt
>> flag(I2SR) clearing opcode is w1c on VF610 but w0c on imx.
>>
>> Signed-off-by: Jason Jin <Jason.jin-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> Signed-off-by: Xiaochun Li <b41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> Signed-off-by: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-imx.c | 144
>> +++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 125 insertions(+), 19 deletions(-)
>
>It seems to me that the patch introduces section mismatch warnings.
>
>WARNING: modpost: Found 2 section mismatch(es).
>To see full details build your kernel with:
>'make CONFIG_DEBUG_SECTION_MISMATCH=y'
[Lu Jingchang-B35083] 
It seems that the "__initdata" causes these section mismatches, I will fix these in patch v2.
Thanks!
