From: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 3/3] i2c: imx: whitespace and checkpatch cleanup
Date: Wed, 7 Jan 2015 02:36:29 +0000
Message-ID: <BLUPR03MB3730EFCF20035ADB0027ABAF5460@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1420555701-24645-1-git-send-email-p.zabel@pengutronix.de>
 <1420555701-24645-3-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420555701-24645-3-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "Fabio.Estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Fabio.Estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sent: Tuesday, January 06, 2015 10:48 PM
> To: Wolfram Sang
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Duan Fugang-B38611; Yuan Yao-B46683;
> Estevam Fabio-R49496; kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; Philipp Zabel
> Subject: [PATCH 3/3] i2c: imx: whitespace and checkpatch cleanup
> 
> This patch fixes up some whitespace issues and addresses a few checkpatch
> warnings.
> 
> Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-imx.c | 53 ++++++++++++++++++++++++++------------
> ------
>  1 file changed, 32 insertions(+), 21 deletions(-)

[snip]
>  		if (i == (msgs->len - 1)) {
>  			if (is_lastmsg) {
>  				/*
> -				 * It must generate STOP before read I2DR to
> prevent
> -				 * controller from generating another clock cycle
> +				 * It must generate STOP before read I2DR to
> +				 * prevent controller from generating another
> +				 * clock cycle
>  				 */

It is better for the format:
	/* It must generate STOP before read I2DR to
	 * prevent controller from generating another
	 * clock cycle
	 */

Regards,
Andy
