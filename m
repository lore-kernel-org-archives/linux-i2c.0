From: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Subject: Re: [PATCH 21/24] staging/iio/adc: fix dangling pointers
Date: Mon, 22 Mar 2010 12:41:12 +0000
Message-ID: <4BA76568.4070002@jic23.retrosnub.co.uk>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-22-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269094385-16114-22-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/20/10 14:13, Wolfram Sang wrote:
> Fix I2C-drivers which missed setting clientdata to NULL before freeing the
> structure it points to. Also fix drivers which do this _after_ the structure
> was freed already.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>

Thanks,
> ---
> 
> Found using coccinelle, then reviewed. Full patchset is available via
> kernel-janitors, linux-i2c, and LKML.
> ---
>  drivers/staging/iio/adc/max1363_core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
> index 9703881..1682fd0 100644
> --- a/drivers/staging/iio/adc/max1363_core.c
> +++ b/drivers/staging/iio/adc/max1363_core.c
> @@ -556,6 +556,7 @@ error_put_reg:
>  	if (!IS_ERR(st->reg))
>  		regulator_put(st->reg);
>  error_free_st:
> +	i2c_set_clientdata(client, NULL);
>  	kfree(st);
>  
>  error_ret:
> @@ -573,6 +574,7 @@ static int max1363_remove(struct i2c_client *client)
>  		regulator_disable(st->reg);
>  		regulator_put(st->reg);
>  	}
> +	i2c_set_clientdata(client, NULL);
>  	kfree(st);
>  
>  	return 0;
