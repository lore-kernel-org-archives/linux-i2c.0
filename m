From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 3/9] iio: inkern: api for manipulating ext_info of iio
 channels
Date: Sat, 31 Dec 2016 15:51:08 +0000
Message-ID: <ba7536cf-230d-e55c-5873-3a58df0b8d9c@kernel.org>
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
 <1480493823-21462-4-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480493823-21462-4-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 30/11/16 08:16, Peter Rosin wrote:
> Extend the inkern api with functions for reading and writing ext_info
> of iio channels.
> 
> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

It may make more sense to take this particular patch separately via
IIO, but as the churn on this file is fairly low I think it is probably
going to be easier to take it with the rest of the series if / when that
heads upstream.

Jonathan
> ---
>  drivers/iio/inkern.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/consumer.h | 37 +++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index b0f4630a163f..4848b8129e6c 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -863,3 +863,63 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iio_write_channel_raw);
> +
> +unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
> +{
> +	const struct iio_chan_spec_ext_info *ext_info;
> +	unsigned int i = 0;
> +
> +	if (!chan->channel->ext_info)
> +		return i;
> +
> +	for (ext_info = chan->channel->ext_info; ext_info->name; ext_info++)
> +		++i;
> +
> +	return i;
> +}
> +EXPORT_SYMBOL_GPL(iio_get_channel_ext_info_count);
> +
> +static const struct iio_chan_spec_ext_info *iio_lookup_ext_info(
> +						const struct iio_channel *chan,
> +						const char *attr)
> +{
> +	const struct iio_chan_spec_ext_info *ext_info;
> +
> +	if (!chan->channel->ext_info)
> +		return NULL;
> +
> +	for (ext_info = chan->channel->ext_info; ext_info->name; ++ext_info) {
> +		if (!strcmp(attr, ext_info->name))
> +			return ext_info;
> +	}
> +
> +	return NULL;
> +}
> +
> +ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
> +				  const char *attr, char *buf)
> +{
> +	const struct iio_chan_spec_ext_info *ext_info;
> +
> +	ext_info = iio_lookup_ext_info(chan, attr);
> +	if (!ext_info)
> +		return -EINVAL;
> +
> +	return ext_info->read(chan->indio_dev, ext_info->private,
> +			      chan->channel, buf);
> +}
> +EXPORT_SYMBOL_GPL(iio_read_channel_ext_info);
> +
> +ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
> +				   const char *buf, size_t len)
> +{
> +	const struct iio_chan_spec_ext_info *ext_info;
> +
> +	ext_info = iio_lookup_ext_info(chan, attr);
> +	if (!ext_info)
> +		return -EINVAL;
> +
> +	return ext_info->write(chan->indio_dev, ext_info->private,
> +			       chan->channel, buf, len);
> +}
> +EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 47eeec3218b5..5e347a9805fd 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -312,4 +312,41 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
>  int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
>  	int *processed, unsigned int scale);
>  
> +/**
> + * iio_get_channel_ext_info_count() - get number of ext_info attributes
> + *				      connected to the channel.
> + * @chan:		The channel being queried
> + *
> + * Returns the number of ext_info attributes
> + */
> +unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan);
> +
> +/**
> + * iio_read_channel_ext_info() - read ext_info attribute from a given channel
> + * @chan:		The channel being queried.
> + * @attr:		The ext_info attribute to read.
> + * @buf:		Where to store the attribute value. Assumed to hold
> + *			at least PAGE_SIZE bytes.
> + *
> + * Returns the number of bytes written to buf (perhaps w/o zero termination;
> + * it need not even be a string), or an error code.
> + */
> +ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
> +				  const char *attr, char *buf);
> +
> +/**
> + * iio_write_channel_ext_info() - write ext_info attribute from a given channel
> + * @chan:		The channel being queried.
> + * @attr:		The ext_info attribute to read.
> + * @buf:		The new attribute value. Strings needs to be zero-
> + *			terminated, but the terminator should not be included
> + *			in the below len.
> + * @len:		The size of the new attribute value.
> + *
> + * Returns the number of accepted bytes, which should be the same as len.
> + * An error code can also be returned.
> + */
> +ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
> +				   const char *buf, size_t len);
> +
>  #endif
> 
