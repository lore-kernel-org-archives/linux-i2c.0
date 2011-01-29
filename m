From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2ctools: Add capability to write block command
Date: Sat, 29 Jan 2011 17:43:54 +0100
Message-ID: <20110129174354.2b146a19@endymion.delvare>
References: <20110125162106.GA8024@ericsson.com>
	<20110125174922.4c802f49@endymion.delvare>
	<20110127160058.GA16853@ericsson.com>
	<20110127175908.488edda3@endymion.delvare>
	<20110127195842.GA17775@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110127195842.GA17775-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

On Thu, 27 Jan 2011 11:58:42 -0800, Guenter Roeck wrote:
> Add support to write SMBus and I2C block data to i2cset.
> 
> Rev 2: Included review feedback

Two remaining minor issues:

> @@ -78,6 +80,19 @@
>  			return -1;
>  		}
>  		break;
> +
> +	case I2C_SMBUS_BLOCK_DATA:
> +		if (!(funcs & I2C_FUNC_SMBUS_WRITE_BLOCK_DATA)) {
> +			fprintf(stderr, MISSING_FUNC_FMT, "SMBus block read");

"SMBus block write"

> +			return -1;
> +		}
> +		break;
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		if (!(funcs & I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
> +			fprintf(stderr, MISSING_FUNC_FMT, "I2C block read");

"I2C block write"

> +			return -1;
> +		}
> +		break;
>  	}
>  
>  	if (pec

Other than that, it looks alright, feel free to commit (I've just added
you to the list of committers - same credentials as lm-sensors
repository.)

Next, I think we can remove the old method for setting the mask. Then
we'll see if some code cleanup or reorganization makes sense.

-- 
Jean Delvare
