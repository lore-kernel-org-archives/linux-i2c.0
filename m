From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: mux: pca954x: Add missing pca9542 definition to
 chip_desc
Date: Wed, 4 Jan 2017 15:08:24 +0100
Message-ID: <528ce653-e361-fbe1-3165-664ee0d8d991@axentia.se>
References: <1483522197-38819-1-git-send-email-preid@electromag.com.au>
 <1483522197-38819-2-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483522197-38819-2-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-01-04 10:29, Phil Reid wrote:
> The spec for the pca954x was missing. This chip is the same as the pca9540
> except that it has interrupt lines. While the i2c_device_id table mapped
> the pca9542 to the pca9540 definition the compatible table did not. In
> preparation for irq support add the pca9542 definition.

A new ACPI table was added behind your back, which needs the same
treatment as the i2c table.

With that fixed,
Acked-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>

Cheers,
peda

> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 8bc3d36..981d145 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -83,6 +83,11 @@ struct pca954x {
>  		.enable = 0x4,
>  		.muxtype = pca954x_ismux,
>  	},
> +	[pca_9542] = {
> +		.nchans = 2,
> +		.enable = 0x4,
> +		.muxtype = pca954x_ismux,
> +	},
>  	[pca_9543] = {
>  		.nchans = 2,
>  		.muxtype = pca954x_isswi,
> @@ -109,7 +114,7 @@ struct pca954x {
>  
>  static const struct i2c_device_id pca954x_id[] = {
>  	{ "pca9540", pca_9540 },
> -	{ "pca9542", pca_9540 },
> +	{ "pca9542", pca_9542 },
>  	{ "pca9543", pca_9543 },
>  	{ "pca9544", pca_9544 },
>  	{ "pca9545", pca_9545 },
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
