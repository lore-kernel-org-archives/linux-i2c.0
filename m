From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH RESEND] gpu: drm: bridge: sii9234: convert to
 devm_i2c_new_dummy_device
Date: Thu, 10 Oct 2019 09:01:32 +0200
Message-ID: <4887a9f6-8f37-d56b-322b-c04a38b7361e@samsung.com>
References: <CGME20191008203330epcas2p31dc15af8587d35eba5a03f71418587bd@epcas2p3.samsung.com>
        <20191008203322.3238-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191008203322.3238-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, dri-devel@lists.freedesktop.org
Cc: linux-i2c@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@siol.net>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 08.10.2019 22:33, Wolfram Sang wrote:
> Move from the deprecated i2c_new_dummy() to devm_i2c_new_dummy_device().
> We now get an ERRPTR which we use in error handling and we can skip
> removal of the created devices.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---


Applied, thx.


Rergards

Andrzej


>
> Rebased to v5.4-rc2 since last time. One of the last two users of the
> old API, so please apply soon, so I can remove the old interface. Only
> build tested.
>
>  drivers/gpu/drm/bridge/sii9234.c | 36 +++++++++++---------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
> index 25d4ad8c7ad6..8a6c85693a88 100644
> --- a/drivers/gpu/drm/bridge/sii9234.c
> +++ b/drivers/gpu/drm/bridge/sii9234.c
> @@ -841,39 +841,28 @@ static int sii9234_init_resources(struct sii9234 *ctx,
>  
>  	ctx->client[I2C_MHL] = client;
>  
> -	ctx->client[I2C_TPI] = i2c_new_dummy(adapter, I2C_TPI_ADDR);
> -	if (!ctx->client[I2C_TPI]) {
> +	ctx->client[I2C_TPI] = devm_i2c_new_dummy_device(&client->dev, adapter,
> +							 I2C_TPI_ADDR);
> +	if (IS_ERR(ctx->client[I2C_TPI])) {
>  		dev_err(ctx->dev, "failed to create TPI client\n");
> -		return -ENODEV;
> +		return PTR_ERR(ctx->client[I2C_TPI]);
>  	}
>  
> -	ctx->client[I2C_HDMI] = i2c_new_dummy(adapter, I2C_HDMI_ADDR);
> -	if (!ctx->client[I2C_HDMI]) {
> +	ctx->client[I2C_HDMI] = devm_i2c_new_dummy_device(&client->dev, adapter,
> +							  I2C_HDMI_ADDR);
> +	if (IS_ERR(ctx->client[I2C_HDMI])) {
>  		dev_err(ctx->dev, "failed to create HDMI RX client\n");
> -		goto fail_tpi;
> +		return PTR_ERR(ctx->client[I2C_HDMI]);
>  	}
>  
> -	ctx->client[I2C_CBUS] = i2c_new_dummy(adapter, I2C_CBUS_ADDR);
> -	if (!ctx->client[I2C_CBUS]) {
> +	ctx->client[I2C_CBUS] = devm_i2c_new_dummy_device(&client->dev, adapter,
> +							  I2C_CBUS_ADDR);
> +	if (IS_ERR(ctx->client[I2C_CBUS])) {
>  		dev_err(ctx->dev, "failed to create CBUS client\n");
> -		goto fail_hdmi;
> +		return PTR_ERR(ctx->client[I2C_CBUS]);
>  	}
>  
>  	return 0;
> -
> -fail_hdmi:
> -	i2c_unregister_device(ctx->client[I2C_HDMI]);
> -fail_tpi:
> -	i2c_unregister_device(ctx->client[I2C_TPI]);
> -
> -	return -ENODEV;
> -}
> -
> -static void sii9234_deinit_resources(struct sii9234 *ctx)
> -{
> -	i2c_unregister_device(ctx->client[I2C_CBUS]);
> -	i2c_unregister_device(ctx->client[I2C_HDMI]);
> -	i2c_unregister_device(ctx->client[I2C_TPI]);
>  }
>  
>  static inline struct sii9234 *bridge_to_sii9234(struct drm_bridge *bridge)
> @@ -950,7 +939,6 @@ static int sii9234_remove(struct i2c_client *client)
>  
>  	sii9234_cable_out(ctx);
>  	drm_bridge_remove(&ctx->bridge);
> -	sii9234_deinit_resources(ctx);
>  
>  	return 0;
>  }
