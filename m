From: "Zang Roy-R61911" <r61911-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] rtc: add support for DS3232 RTC
Date: Mon, 5 Jul 2010 15:50:55 +0800
Message-ID: <46EA46969DA12B47932A34F1DA67A147041870@zch01exm23.fsl.freescale.net>
References: <1278312326-19022-1-git-send-email-tie-fei.zang@freescale.com> <20100705092231.2780a1b8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20100705092231.2780a1b8-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Hu Mingkai-B21284 <B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Srinivasan Srikanth-R9AABP <R9AABP-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 

> -----Original Message-----
> From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org] 
> Sent: Monday, July 05, 2010 15:23 PM
> To: Zang Roy-R61911
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; 
> Hu Mingkai-B21284; Srinivasan Srikanth-R9AABP
> Subject: Re: [PATCH] rtc: add support for DS3232 RTC
> 
> Hi Roy,
> 
> On Mon,  5 Jul 2010 14:45:26 +0800, Roy Zang wrote:
> > This patch adds the driver for RTC chip DS3232 via I2C bus
> > 
> > Signed-off-by: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Signed-off-by: Jingchang Lu <b22599-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Signed-off-by: Srikanth Srinivasan 
> <srikanth.srinivasan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Signed-off-by: Roy Zang <tie-fei.zang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> > Tested on MPC8536DS and P4080DS board
> > 
> >  drivers/rtc/Kconfig      |   11 +
> >  drivers/rtc/Makefile     |    1 +
> >  drivers/rtc/rtc-ds3232.c |  466 
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 478 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/rtc/rtc-ds3232.c
> 
> You're sending this patch to the wrong list. Please read MAINTAINERS
> again.
Does linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org is the correct mail list?
The rtc device is on the i2c bus.
Roy
