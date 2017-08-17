From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: mux: pinctrl: potential NULL dereference on error
Date: Thu, 17 Aug 2017 14:34:02 +0200
Message-ID: <a08c1f34-9487-c606-77b9-8ea73a3ed30f@axentia.se>
References: <20170817115355.fsc3z64eih7wjze6@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170817115355.fsc3z64eih7wjze6@mwanda>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


On 2017-08-17 13:53, Dan Carpenter wrote:
> If i2c_mux_alloc() fails then we'd have a NULL derefecrence here.
> 
> Fixes: c4aee3e1b0de ("i2c: mux: pinctrl: remove platform_data")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Indeed, thanks for the patch. Applied.

(IIUC, small memory allocations are not supposed to fail so this is
 not really a "real" problem?)

FTR, I have work in progress that further cleans up i2c muxes.
Most .remove functions disappear from drivers/i2c/muxes/ and
most i2c mux users outside of i2c/muxes are also simplified for
a nice net loss in lines-of-code, and this bug would simply not
have happened with that. Oh well, that's not for the this cycle
anyway...

Cheers,
peda

> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> index 20b90a7a1e61..cc6818aabab5 100644
> --- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> @@ -173,7 +173,7 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
>  err_del_adapter:
>  	i2c_mux_del_adapters(muxc);
>  err_put_parent:
> -	i2c_put_adapter(muxc->parent);
> +	i2c_put_adapter(parent);
>  
>  	return ret;
>  }
> 

