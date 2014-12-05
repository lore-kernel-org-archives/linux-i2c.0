From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Add i2c mux for by pass
Date: Fri, 05 Dec 2014 08:03:18 -0800
Message-ID: <1417795398.1851.17.camel@spandruv-desktop.jf.intel.com>
References: <1417734625-13739-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1417734625-13739-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20141205070313.GA1197@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141205070313.GA1197@katana>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2014-12-05 at 08:03 +0100, Wolfram Sang wrote: 
> On Thu, Dec 04, 2014 at 03:10:25PM -0800, Srinivas Pandruvada wrote:
> > This chip allows some limited number of sensors connected to it as
> > slaves, which can be directly accessed by register interface of this
> > driver.But the current upstream driver doesn't support such mode.
> > To attach such slaves to main processor i2c bus, chip has to be set
> > up in bypass mode. This change adds i2c mux, which will enable/disable
> > this mode for transaction to/from such slave devices.
> > This was discussed for a while in mailing list, this was the outcome:
> > Reference:
> > http://www.spinics.net/lists/linux-iio/msg12126.html
> > http://comments.gmane.org/gmane.linux.kernel.iio/11470
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Only minor nits, in general:
> 
> Reviewed-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> 
> > +static int inv_mpu6050_create_mux(struct iio_dev *indio_dev)
> > +{
> > +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> > +	struct i2c_client *client = st->client;
> > +
> > +	st->mux_adapter = i2c_add_mux_adapter(client->adapter,
> > +					      &client->dev,
> > +					      indio_dev,
> > +					      0, 0, 0,
> > +					      inv_mpu6050_select_bypass,
> > +					      inv_mpu6050_deselect_bypass);
> > +	if (st->mux_adapter == NULL) {
> > +		dev_err(&st->client->dev, "Mux create Failed\n");
> 
> i2c_add_mux_adapter prints error messages on its own, so this is not
> needed.
> 
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void inv_mpu6050_destroy_mux(struct iio_dev *indio_dev)
> > +{
> > +	struct inv_mpu6050_state *mpu_st = iio_priv(indio_dev);
> > +
> > +	if (mpu_st->mux_adapter)
> > +		i2c_del_mux_adapter(mpu_st->mux_adapter);
> > +}
> 
> Since those two functions are only called once and don't encapsulate
> much, I'd rather put the commands directly into the calling functions.
Agree. I will move them to the caller and submit another version.
I hope, I can still use reviewed-by tag, after this change.

Thanks,
Srinivas 
> 
