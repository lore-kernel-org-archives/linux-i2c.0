From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/13] i2c: i2c-mxs: Let device core handle pinctrl
Date: Sun, 26 May 2013 17:58:31 -0300
Message-ID: <CAOMZO5Bju3v4gXayzZ6vMjr9WrSqcYWN+6fnyKMc3AaoYt44Gg@mail.gmail.com>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
	<1367863561-11534-3-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1367863561-11534-3-git-send-email-fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, May 6, 2013 at 3:05 PM, Fabio Estevam
<fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
> we can rely on device core for handling pinctrl.
>
> So remove devm_pinctrl_get_select_default() from the driver.
>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Any comments on this one?
