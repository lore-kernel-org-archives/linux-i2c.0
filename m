From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 8/8] iio: accel: kxcjk-1013: optimize i2c transfers
 in trigger handler
Date: Sun, 05 Jul 2015 13:11:04 +0100
Message-ID: <55991ED8.5020500@kernel.org>
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com> <1435916017-12859-9-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435916017-12859-9-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/07/15 10:33, Irina Tirdea wrote:
> From: Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
> enable/disable the bus at each i2c transfer and must wait for
> the enable/disable to happen before sending the data.
> 
> When reading data in the trigger handler, the kxcjk-1013 accel driver
> does one i2c transfer for each axis. This has an impact on the
> frequency of the accelerometer at high sample rates due to additional
> delays introduced by the i2c bus at each transfer.
> 
> Reading all axis values in one i2c transfer reduces the delays
> introduced by the i2c bus. Uses i2c_smbus_read_i2c_block_data_or_emulated
> that will fallback to reading each axis as a separate word in case i2c
> block read is not supported.
> 
> Signed-off-by: Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Same comments as previously.

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iio/accel/kxcjk-1013.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 4960397..8f401c2 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -923,7 +923,7 @@ static const struct iio_event_spec kxcjk1013_event = {
>  		.realbits = 12,						\
>  		.storagebits = 16,					\
>  		.shift = 4,						\
> -		.endianness = IIO_CPU,					\
> +		.endianness = IIO_LE,					\
>  	},								\
>  	.event_spec = &kxcjk1013_event,				\
>  	.num_event_specs = 1						\
> @@ -955,19 +955,16 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct kxcjk1013_data *data = iio_priv(indio_dev);
> -	int bit, ret, i = 0;
> +	int ret;
>  
>  	mutex_lock(&data->mutex);
> -
> -	for (bit = 0; bit < AXIS_MAX; bit++) {
> -		ret = kxcjk1013_get_acc_reg(data, bit);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			goto err;
> -		}
> -		data->buffer[i++] = ret;
> -	}
> +	ret = i2c_smbus_read_i2c_block_data_or_emulated(data->client,
> +							KXCJK1013_REG_XOUT_L,
> +							AXIS_MAX * 2,
> +							(u8 *)data->buffer);
>  	mutex_unlock(&data->mutex);
> +	if (ret < 0)
> +		goto err;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>  					   data->timestamp);
> 
