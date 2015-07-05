From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/8] iio: accel: bmc150: use available_scan_masks
Date: Sun, 05 Jul 2015 13:10:04 +0100
Message-ID: <55991E9C.8050206@kernel.org>
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com> <1435916017-12859-4-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435916017-12859-4-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/07/15 10:33, Irina Tirdea wrote:
> Use available_scan_masks to allow the iio core to select
> the data to send to userspace depending on which axes are
> enabled, instead of doing this in the driver's interrupt
> handler.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
I guess people almost always want all 3 axes of an accelerometer
so a burst read like this probably makes sense for the majority.

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iio/accel/bmc150-accel.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index 73e8773..c6c8416 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -136,6 +136,7 @@ enum bmc150_accel_axis {
>  	AXIS_X,
>  	AXIS_Y,
>  	AXIS_Z,
> +	AXIS_MAX,
>  };
>  
>  enum bmc150_power_modes {
> @@ -1201,6 +1202,8 @@ static const struct iio_info bmc150_accel_info_fifo = {
>  	.driver_module		= THIS_MODULE,
>  };
>  
> +static const unsigned long bmc150_accel_scan_masks[] = {0x7, 0};
> +
>  static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -1209,8 +1212,7 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
>  	int bit, ret, i = 0;
>  
>  	mutex_lock(&data->mutex);
> -	for_each_set_bit(bit, indio_dev->active_scan_mask,
> -			 indio_dev->masklength) {
> +	for (bit = 0; bit < AXIS_MAX; bit++) {
>  		ret = i2c_smbus_read_word_data(data->client,
>  					       BMC150_ACCEL_AXIS_TO_REG(bit));
>  		if (ret < 0) {
> @@ -1632,6 +1634,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->channels = data->chip_info->channels;
>  	indio_dev->num_channels = data->chip_info->num_channels;
> +	indio_dev->available_scan_masks = bmc150_accel_scan_masks;
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &bmc150_accel_info;
> 
