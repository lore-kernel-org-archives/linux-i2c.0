From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: add missing of_node_put in i2c_mux_del_adapters
Date: Fri, 3 Mar 2017 11:15:22 +0100
Message-ID: <2d7deb19-6f10-a18d-e541-f5adb4f30ff2@axentia.se>
References: <1488527831-53733-1-git-send-email-qi.hou@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr00125.outbound.protection.outlook.com ([40.107.0.125]:4704
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751250AbdCCKbz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 3 Mar 2017 05:31:55 -0500
In-Reply-To: <1488527831-53733-1-git-send-email-qi.hou@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Qi Hou <qi.hou@windriver.com>, robh@kernel.org, linux-i2c@vger.kernel.org
Cc: leif.lindholm@linaro.org, pantelis.antoniou@konsulko.com, grant.likely@linaro.org, bruce.ashfield@windriver.com, paul.gortmaker@windriver.com, xiao.zhang@windriver.com

On 2017-03-03 08:57, Qi Hou wrote:
> Refcount of of_node is increased with of_node_get() in i2c_mux_add_adapter().
> It must be decreased with of_node_put() in i2c_mux_del_adapters().

Oops, this one slipped though the cracks. Sorry about that!

> Signe-off-by: Qi Hou <qi.hou@windriver.com>

I fixed the above typo, added a Cc: stable tag and committed it to my
for-current branch.

Cheers,
peda

> Reviewed-by: Zhang Xiao <xiao.zhang@windriver.com>
> Acked-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/i2c/i2c-mux.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 83768e8..2178266 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -429,6 +429,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
>  	while (muxc->num_adapters) {
>  		struct i2c_adapter *adap = muxc->adapter[--muxc->num_adapters];
>  		struct i2c_mux_priv *priv = adap->algo_data;
> +		struct device_node *np = adap->dev.of_node;
>  
>  		muxc->adapter[muxc->num_adapters] = NULL;
>  
> @@ -438,6 +439,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
>  
>  		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
>  		i2c_del_adapter(adap);
> +		of_node_put(np);
>  		kfree(priv);
>  	}
>  }
> 
