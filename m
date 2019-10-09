From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH RESEND] gpu: drm: bridge: analogix-anx78xx: convert to
 i2c_new_dummy_device
Date: Wed, 9 Oct 2019 11:14:58 +0300
Message-ID: <20191009081458.GB22998@pendragon.ideasonboard.com>
References: <20191008203145.3159-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191008203145.3159-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@siol.net>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Tue, Oct 08, 2019 at 10:31:45PM +0200, Wolfram Sang wrote:
> Move from the deprecated i2c_new_dummy() to i2c_new_dummy_device(). We
> now get an ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Rebased to v5.4-rc2 since last time. One of the last two users of the
> old API, so please apply soon, so I can remove the old interface. Only
> build tested.
> 
>  drivers/gpu/drm/bridge/analogix-anx78xx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
> index 3c7cc5af735c..be7756280e41 100644
> --- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
> @@ -1350,10 +1350,10 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
>  
>  	/* Map slave addresses of ANX7814 */
>  	for (i = 0; i < I2C_NUM_ADDRESSES; i++) {
> -		anx78xx->i2c_dummy[i] = i2c_new_dummy(client->adapter,
> +		anx78xx->i2c_dummy[i] = i2c_new_dummy_device(client->adapter,
>  						anx78xx_i2c_addresses[i] >> 1);
> -		if (!anx78xx->i2c_dummy[i]) {
> -			err = -ENOMEM;
> +		if (IS_ERR(anx78xx->i2c_dummy[i])) {
> +			err = PTR_ERR(anx78xx->i2c_dummy[i]);
>  			DRM_ERROR("Failed to reserve I2C bus %02x\n",
>  				  anx78xx_i2c_addresses[i]);
>  			goto err_unregister_i2c;

-- 
Regards,

Laurent Pinchart
