From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH RESEND] gpu: drm: bridge: analogix-anx78xx: convert to
 i2c_new_dummy_device
Date: Thu, 10 Oct 2019 09:04:50 +0200
Message-ID: <97111f38-0820-edf5-8316-58fef6b065cf@samsung.com>
References: <CGME20191008203222epcas4p4a9ab2b8dd10759e61ce9b1ec4547d13f@epcas4p4.samsung.com>
        <20191008203145.3159-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191008203145.3159-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, dri-devel@lists.freedesktop.org
Cc: linux-i2c@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@siol.net>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 08.10.2019 22:31, Wolfram Sang wrote:
> Move from the deprecated i2c_new_dummy() to i2c_new_dummy_device(). We
> now get an ERRPTR which we use in error handling.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


Brian's patch is already applied.


Regards

Andrzej


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
