From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Thu, 15 May 2008 19:16:31 +0200
Message-ID: <20080515191631.7791346c@hyperion.delvare>
References: <200805012046.07885.david-b@pacbell.net>
	<20080510225548.36297637@hyperion.delvare>
	<200805120943.04899.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805120943.04899.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Mon, 12 May 2008 09:43:04 -0700, David Brownell wrote:
> --- g26.orig/drivers/i2c/busses/i2c-ali1563.c	2008-05-11 17:55:01.000000000 -0700
> +++ g26/drivers/i2c/busses/i2c-ali1563.c	2008-05-11 17:55:08.000000000 -0700
> @@ -106,8 +106,11 @@ static int ali1563_transaction(struct i2
>   	}
>  
>  	/* device error - no response, ignore the autodetection case */
> -	if ((data & HST_STS_DEVERR) && (size != HST_CNTL2_QUICK)) {
> -		dev_err(&a->dev, "Device error!\n");
> +	if (data & HST_STS_DEVERR) {
> +		if (size != HST_CNTL2_QUICK)
> +			dev_err(&a->dev, "Device error!\n");
> +		else
> +			return -ENXIO;
>  	}

This one doesn't look right. You should return -ENXIO in all cases (but
only print the error message on size != HST_CNTL2_QUICK.) The right way
to do this, I think, would be to move this specific check at the end of
the function, so that the other error checks are still done in all
cases.

>  
>  	/* bus collision */
> @@ -122,13 +125,14 @@ static int ali1563_transaction(struct i2
>  		outb_p(0x0,SMB_HST_CNTL2);
>  	}
>  
> -	return -1;
> +	return -EIO;
>  }
>  
>  static int ali1563_block_start(struct i2c_adapter * a)
>  {
>  	u32 data;
>  	int timeout;
> +	int status = -EIO;
>  
>  	dev_dbg(&a->dev, "Block (pre): STS=%02x, CNTL1=%02x, "
>  		"CNTL2=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, DAT1=%02x\n",
> @@ -164,13 +168,17 @@ static int ali1563_block_start(struct i2
>  
>  	if (timeout && !(data & HST_STS_BAD))
>  		return 0;
> +
> +	if (timeout == 0 && !(data & HST_STS_DONE))
> +		status = -ETIMEDOUT;

That's pretty strange to check for both timeout == 0 and !(data &
HST_STS_DONE), given that the former implies the latter if I read the
code correctly. The same strangeness is present in the code below, if
we print "Timeout" then we will also print "Transaction Never Finished".

> +
>  	dev_err(&a->dev, "SMBus Error: %s%s%s%s%s\n",
>  		timeout ? "Timeout " : "",

BTW, isn't there a bug here? I think the test should be timeout == 0.

>  		data & HST_STS_FAIL ? "Transaction Failed " : "",
>  		data & HST_STS_BUSERR ? "No response or Bus Collision " : "",
>  		data & HST_STS_DEVERR ? "Device Error " : "",
>  		!(data & HST_STS_DONE) ? "Transaction Never Finished " : "");
> -	return -1;
> +	return status;
>  }

I thought we had agreed that we would return -ENXIO for HST_STS_DEVERR,
as we already do in ali1563_transaction()?

> --- g26.orig/drivers/i2c/busses/i2c-viapro.c	2008-05-11 17:55:01.000000000 -0700
> +++ g26/drivers/i2c/busses/i2c-viapro.c	2008-05-11 17:55:08.000000000 -0700
> @@ -152,7 +152,7 @@ static int vt596_transaction(u8 size)
> (...)
>  	if (temp & 0x04) {
>  		int read = inb_p(SMBHSTADD) & 0x01;
> -		result = -1;
> +		result = -EIO;
>  		/* The quick and receive byte commands are used to probe
>  		   for chips, so errors are expected, and we don't want
>  		   to frighten the user. */
>  		if (!((size == VT596_QUICK && !read) ||
>  		      (size == VT596_BYTE && read)))
>  			dev_err(&vt596_adapter.dev, "Transaction error!\n");
> +		else
> +			result = -ENXIO;
>  	}

This is not correct, the result is always -ENXIO, whether you display
an error message or not.

All the rest looks fine now. BTW, I can test i2c-piix4, i2c-i801,
i2c-viapro and i2c-nforce2 here, and will do soon.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
