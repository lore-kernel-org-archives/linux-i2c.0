From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] TSL2550 driver bugfix
Date: Sat, 11 Jul 2009 20:20:30 +0200
Message-ID: <20090711202030.52ffbddb@hyperion.delvare>
References: <4A4A2FBC.1060804@valueteam.com>
 <4A4A4036.3000408@cam.ac.uk>
 <4A4B1A71.20101@valueteam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4B1A71.20101-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, giometti-k2GhghHVRtY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michele, Jonathan,

Sorry for the late answer, I had a lot of work this week.

On Wed, 01 Jul 2009 10:12:33 +0200, Michele De Candia (VT) wrote:
> Signed-off-by: Michele Jr De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
> 
> diff --git a/drivers/i2c/chips/tsl2550.c b/drivers/i2c/chips/tsl2550.c
> index 1a9cc13..c4e1104 100644
> --- a/drivers/i2c/chips/tsl2550.c
> +++ b/drivers/i2c/chips/tsl2550.c
> @@ -189,14 +189,17 @@ static int tsl2550_calculate_lux(u8 ch0, u8 ch1)
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
>  		return -1;
>  
> -	/* Calculate LUX */
> -	lux = ((c0 - c1) * ratio_lut[r]) / 256;
> -
>  	/* LUX range check */
>  	return lux > TSL2550_MAX_LUX ? TSL2550_MAX_LUX : lux;
>  }

The driver does indeed not handle the dark room case properly, and your
fix is correct. But I think it is insufficient.

For one thing, returning -1 on error is not a good idea. -1 is -EPERM,
resulting in a confusing error message for the user. We should come up
with a better error code. Maybe -EAGAIN?

For another, I do hit the case c1 > c0 from times to times, in
particular when I move the sensor in dark areas. Do you hit this as
well? This might be specific to the serial evaluation module I'm using,
it is very slow and this might cause c0 and c1 to be sampled at
significantly different times (say 200 ms apart.) If the light
conditions change meanwhile, this can explain why c1 > c0. I am not
sure what to do in this case. We can return -EAGAIN and let user-space
retry. But we could also restart the computation automatically in this
case. Of course if the problem only affects the evaluation module then
we don't really care.

-- 
Jean Delvare
