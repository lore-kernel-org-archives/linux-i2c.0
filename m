From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: imx: whitespace and checkpatch cleanup
Date: Wed, 07 Jan 2015 12:01:53 +0100
Message-ID: <1420628513.3191.30.camel@pengutronix.de>
References: <1420555701-24645-1-git-send-email-p.zabel@pengutronix.de>
	 <1420555701-24645-3-git-send-email-p.zabel@pengutronix.de>
	 <BLUPR03MB3730EFCF20035ADB0027ABAF5460@BLUPR03MB373.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BLUPR03MB3730EFCF20035ADB0027ABAF5460-GeMU99GfrrsHjcGqcGfFzOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Fabio.Estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Fabio.Estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

Am Mittwoch, den 07.01.2015, 02:36 +0000 schrieb
fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org:
> From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Sent: Tuesday, January 06, 2015 10:48 PM
> > To: Wolfram Sang
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Duan Fugang-B38611; Yuan Yao-B46683;
> > Estevam Fabio-R49496; kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; Philipp Zabel
> > Subject: [PATCH 3/3] i2c: imx: whitespace and checkpatch cleanup
> > 
> > This patch fixes up some whitespace issues and addresses a few checkpatch
> > warnings.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 53 ++++++++++++++++++++++++++------------
> > ------
> >  1 file changed, 32 insertions(+), 21 deletions(-)
> 
> [snip]
> >  		if (i == (msgs->len - 1)) {
> >  			if (is_lastmsg) {
> >  				/*
> > -				 * It must generate STOP before read I2DR to
> > prevent
> > -				 * controller from generating another clock cycle
> > +				 * It must generate STOP before read I2DR to
> > +				 * prevent controller from generating another
> > +				 * clock cycle
> >  				 */
> 
> It is better for the format:
> 	/* It must generate STOP before read I2DR to

Thank you for the review, but according to Documentation/CodingStyle
this multi-line comment format is only preferred for code in net/ and
drivers/net.

regards
Philipp
