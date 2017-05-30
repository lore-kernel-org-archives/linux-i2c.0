From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] i2c: i2c-mux: Fix channel parent node assignment
Date: Tue, 30 May 2017 13:04:08 +0200
Message-ID: <5de6a678-e646-3acb-2346-8a1d76ebbf9d@axentia.se>
References: <1496134457-19573-1-git-send-email-jacopo+renesas@jmondi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496134457-19573-1-git-send-email-jacopo+renesas@jmondi.org>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2017-05-30 10:54, Jacopo Mondi wrote:
> I2c-mux channels are created as mux siblings while they should be
> children of the mux itself. Fix it.

Has this received any testing at all?

I think it will break various users of i2c_parent_is_i2c_adapter()
that expect the current situation that a i2c mux child adapter is
direct child of the parent i2c adapter. I.e. with no intermediate
device node.

Cheers,
peda

> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> 
> Hello,
>    while inspecting child nodes of an i2c adapter it has been noted that
> child devices of an i2c-mux are listed as children of the i2c adapter itself,
> and not of the i2c-mux.
> 
> The hierarchy of devices looked like
> 
> -- i2c-04
> --- eeprom@57
> --- video_receiver@70
> --- video_receiver@34
> --- gmsl-deserializer@0		<-- MUX
> --- gmsl-deserializer@0/i2c@0	<-- MUX CHANNEL
> 
> It now looks like
> 
> -- i2c-04
> --- eeprom@57
> --- video_receiver@70
> --- video_receiver@34
> --- gmsl-deserializer@0
> ---- gmsl-deserializer@0/i2c@0
> 
> v1 -> v2:
> - change commit message as suggested by Geert
> 
>  drivers/i2c/i2c-mux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 83768e8..37b7804 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -324,7 +324,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  	priv->adap.owner = THIS_MODULE;
>  	priv->adap.algo = &priv->algo;
>  	priv->adap.algo_data = priv;
> -	priv->adap.dev.parent = &parent->dev;
> +	priv->adap.dev.parent = muxc->dev;
>  	priv->adap.retries = parent->retries;
>  	priv->adap.timeout = parent->timeout;
>  	priv->adap.quirks = parent->quirks;
> --
> 2.7.4
> 
