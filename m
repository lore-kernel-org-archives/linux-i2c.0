From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: Re: [PATCH] TSL2550 driver bugfix
Date: Mon, 13 Jul 2009 12:06:36 +0200
Message-ID: <20090713100636.GT5823@enneenne.com>
References: <4A4A2FBC.1060804@valueteam.com> <4A4A4036.3000408@cam.ac.uk> <4A4B1A71.20101@valueteam.com> <20090711202030.52ffbddb@hyperion.delvare> <20090712105237.01e11954@hyperion.delvare> <4A5AE89A.8000000@valueteam.com> <20090713104454.5b932c3d@hyperion.delvare> <4A5B011F.8030507@valueteam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A5B011F.8030507-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Mon, Jul 13, 2009 at 11:40:47AM +0200, Michele De Candia (VT) wrote:
> Signed-off-by: Michele Jr De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
> 
> diff --git a/drivers/i2c/chips/tsl2550.c b/drivers/i2c/chips/tsl2550.c
> index 1a9cc13..561d7bf 100644
> --- a/drivers/i2c/chips/tsl2550.c
> +++ b/drivers/i2c/chips/tsl2550.c
> @@ -27,7 +27,7 @@
>  #include <linux/delay.h>
>  
>  #define TSL2550_DRV_NAME	"tsl2550"
> -#define DRIVER_VERSION		"1.1.1"
> +#define DRIVER_VERSION		"1.1.2"
>  
>  /*
>   * Defines
> @@ -189,13 +189,16 @@ static int tsl2550_calculate_lux(u8 ch0, u8 ch1)
>  	u8 r = 128;
>  
>  	/* Avoid division by 0 and count 1 cannot be greater than count 0 */
> -	if (c0 && (c1 <= c0))
> -		r = c1 * 128 / c0;
> +	if (c1 <= c0)
> +		if (c0) {
> +			r = c1 * 128 / c0;
> +
> +			/* Calculate LUX */
> +			lux = ((c0 - c1) * ratio_lut[r]) / 256;
> +		} else
> +			lux = 0;
>  	else
> -		return -1;
> -
> -	/* Calculate LUX */
> -	lux = ((c0 - c1) * ratio_lut[r]) / 256;
> +		return -EAGAIN;
>  
>  	/* LUX range check */
>  	return lux > TSL2550_MAX_LUX ? TSL2550_MAX_LUX : lux;

Acked-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
