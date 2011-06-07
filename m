From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] staging iio: Replace kmalloc with local variable
Date: Tue, 07 Jun 2011 14:00:23 +0100
Message-ID: <4DEE20E7.4020008@cam.ac.uk>
References: <1307450354.1516.23.camel@anish-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1307450354.1516.23.camel@anish-desktop>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: anish <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: gregkh-l3A5Bk7waGM@public.gmane.org, manuel.stahl-GeUHRtUQU7nSyEMIgutvibNAH6kLmebB@public.gmane.org, lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 06/07/11 13:39, anish wrote:
> From: anish kumar <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> replaced kmalloc with local variable as I2C(in this case) doesn't require
> kmalloc memory it can do with stack memory.
I've cc'd linux-i2c just to check I'm right about the whole i2c doesn't need
dma safe buffers bit...
> 
> Signed-off-by: anish kumar <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> ---
>  drivers/staging/iio/adc/max1363_core.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
> index 1037087..9462230 100644
> --- a/drivers/staging/iio/adc/max1363_core.c
> +++ b/drivers/staging/iio/adc/max1363_core.c
> @@ -207,15 +207,12 @@ static int max1363_write_basic_config(struct i2c_client *client,
>  				      unsigned char d2)
>  {
>  	int ret;
> -	u8 *tx_buf = kmalloc(2, GFP_KERNEL);
> +	u8 tx_buf[2];
>  
> -	if (!tx_buf)
> -		return -ENOMEM;
>  	tx_buf[0] = d1;
>  	tx_buf[1] = d2;
>  
>  	ret = i2c_master_send(client, tx_buf, 2);
> -	kfree(tx_buf);
>  
>  	return (ret > 0) ? 0 : ret;
>  }
