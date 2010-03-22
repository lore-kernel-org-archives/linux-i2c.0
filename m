From: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
Subject: Re: [PATCH 22/24] staging/iio/light: fix dangling pointers
Date: Mon, 22 Mar 2010 12:41:42 +0000
Message-ID: <4BA76586.6040200@jic23.retrosnub.co.uk>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-23-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1269094385-16114-23-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org
List-Id: linux-i2c@vger.kernel.org

On 03/20/10 14:13, Wolfram Sang wrote:
> Fix I2C-drivers which missed setting clientdata to NULL before freeing the
> structure it points to. Also fix drivers which do this _after_ the structure
> was freed already.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Thanks for this one as well!
> ---
> 
> Found using coccinelle, then reviewed. Full patchset is available via
> kernel-janitors, linux-i2c, and LKML.
> ---
>  drivers/staging/iio/light/tsl2563.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
> index 78b9432..286559d 100644
> --- a/drivers/staging/iio/light/tsl2563.c
> +++ b/drivers/staging/iio/light/tsl2563.c
> @@ -681,6 +681,7 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
>  fail2:
>  	iio_device_unregister(chip->indio_dev);
>  fail1:
> +	i2c_set_clientdata(client, NULL);
>  	kfree(chip);
>  	return err;
>  }
> @@ -691,6 +692,7 @@ static int tsl2563_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(chip->indio_dev);
>  
> +	i2c_set_clientdata(client, NULL);
>  	kfree(chip);
>  	return 0;
>  }
