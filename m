From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/7] iio: inv_mpu6050: Only toggle DATA_RDY_EN in
 inv_reset_fifo
Date: Sun, 29 May 2016 16:29:24 +0100
Message-ID: <8b3fdc98-6038-382e-d359-6bbe51ffc751@kernel.org>
References: <cover.1463582011.git.leonard.crestez@intel.com>
 <37946b54fbedeb258f12413a09683c18a8825290.1463582011.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <37946b54fbedeb258f12413a09683c18a8825290.1463582011.git.leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ge Gao <ggao-ktqnL0SqcGIj5TC/SZClsA@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 18/05/16 16:00, Crestez Dan Leonard wrote:
> Signed-off-by: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Looks good to me.

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 13 ++++++++-----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  3 ++-
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 8455af0..3fc0b71 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -41,7 +41,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
>  
>  	/* disable interrupt */
> -	result = regmap_write(st->map, st->reg->int_enable, 0);
> +	result = regmap_update_bits(st->map, st->reg->int_enable,
> +				    INV_MPU6050_BIT_DATA_RDY_EN, 0);
>  	if (result) {
>  		dev_err(regmap_get_device(st->map), "int_enable failed %d\n",
>  			result);
> @@ -68,8 +69,9 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  	/* enable interrupt */
>  	if (st->chip_config.accl_fifo_enable ||
>  	    st->chip_config.gyro_fifo_enable) {
> -		result = regmap_write(st->map, st->reg->int_enable,
> -				      INV_MPU6050_BIT_DATA_RDY_EN);
> +		result = regmap_update_bits(st->map, st->reg->int_enable,
> +					    INV_MPU6050_BIT_DATA_RDY_EN,
> +					    INV_MPU6050_BIT_DATA_RDY_EN);
>  		if (result)
>  			return result;
>  	}
> @@ -92,8 +94,9 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  
>  reset_fifo_fail:
>  	dev_err(regmap_get_device(st->map), "reset fifo failed %d\n", result);
> -	result = regmap_write(st->map, st->reg->int_enable,
> -			      INV_MPU6050_BIT_DATA_RDY_EN);
> +	result = regmap_update_bits(st->map, st->reg->int_enable,
> +				    INV_MPU6050_BIT_DATA_RDY_EN,
> +				    INV_MPU6050_BIT_DATA_RDY_EN);
>  
>  	return result;
>  }
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index e8818d4..1a6bad3 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -69,7 +69,8 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  		if (result)
>  			return result;
>  
> -		result = regmap_write(st->map, st->reg->int_enable, 0);
> +		result = regmap_update_bits(st->map, st->reg->int_enable,
> +					INV_MPU6050_BIT_DATA_RDY_EN, 0);
>  		if (result)
>  			return result;
>  
> 
