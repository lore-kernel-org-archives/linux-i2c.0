From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: muxes: fix build break
Date: Thu, 2 Aug 2012 11:53:24 +0200
Message-ID: <20120802115324.6ed7ce52@endymion.delvare>
References: <1343898737-24386-1-git-send-email-vbyravarasu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343898737-24386-1-git-send-email-vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Venu,

On Thu, 2 Aug 2012 14:42:17 +0530, Venu Byravarasu wrote:
> Seems a new parameter is added to i2c_add_mux_adapter().
> All its references, except for the one present in
> i2c-mux-pinctrl.c, were updated.
> As this is causing build break, pushing current patch to fix it.

Thanks for the heads up. When I wrote the patch adding the parameter,
the i2c-mux-pinctrl driver wasn't upstream yet, that's why I missed it.

> 
> Signed-off-by: Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/muxes/i2c-mux-pinctrl.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> index 46a6697..5f097f3 100644
> --- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> @@ -221,7 +221,7 @@ static int __devinit i2c_mux_pinctrl_probe(struct platform_device *pdev)
>  				(mux->pdata->base_bus_num + i) : 0;
>  
>  		mux->busses[i] = i2c_add_mux_adapter(mux->parent, &pdev->dev,
> -						     mux, bus, i,
> +						     mux, bus, i, 0,
>  						     i2c_mux_pinctrl_select,
>  						     deselect);
>  		if (!mux->busses[i]) {

As the problematic patch isn't upstream yet, I've simply folded the
above into it:
http://khali.linux-fr.org/devel/linux-3/jdelvare-i2c/i2c-mux-support-class.patch

Thanks again,
-- 
Jean Delvare
