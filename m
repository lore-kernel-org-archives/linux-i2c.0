From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-powermac: Refactor i2c_powermac_smbus_xfer
Date: Sun, 11 Oct 2009 10:05:31 +1100
Message-ID: <1255215931.2192.11.camel@pasglop>
References: <20091010141908.0be884a5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091010141908.0be884a5-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 2009-10-10 at 14:19 +0200, Jean Delvare wrote:
> I wanted to add some error logging to the i2c-powermac driver, but
> found that it was very difficult due to the way the
> i2c_powermac_smbus_xfer function is organized. Refactor the code in
> this function so that each low-level function is only called once.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
> ---
> This needs testing! Thanks.

Ok, will give it a go next week.

Cheers,
Ben.

>  drivers/i2c/busses/i2c-powermac.c |   85 +++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 44 deletions(-)
> 
> --- linux-2.6.32-rc3.orig/drivers/i2c/busses/i2c-powermac.c	2009-10-10 14:08:39.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/i2c/busses/i2c-powermac.c	2009-10-10 14:13:04.000000000 +0200
> @@ -49,48 +49,38 @@ static s32 i2c_powermac_smbus_xfer(	stru
>  	int			rc = 0;
>  	int			read = (read_write == I2C_SMBUS_READ);
>  	int			addrdir = (addr << 1) | read;
> +	int			mode, subsize, len;
> +	u32			subaddr;
> +	u8			*buf;
>  	u8			local[2];
>  
> -	rc = pmac_i2c_open(bus, 0);
> -	if (rc)
> -		return rc;
> +	if (size == I2C_SMBUS_QUICK || size == I2C_SMBUS_BYTE) {
> +		mode = pmac_i2c_mode_std;
> +		subsize = 0;
> +		subaddr = 0;
> +	} else {
> +		mode = read ? pmac_i2c_mode_combined : pmac_i2c_mode_stdsub;
> +		subsize = 1;
> +		subaddr = command;
> +	}
>  
>  	switch (size) {
>          case I2C_SMBUS_QUICK:
> -		rc = pmac_i2c_setmode(bus, pmac_i2c_mode_std);
> -		if (rc)
> -			goto bail;
> -		rc = pmac_i2c_xfer(bus, addrdir, 0, 0, NULL, 0);
> +		buf = NULL;
> +		len = 0;
>  	    	break;
>          case I2C_SMBUS_BYTE:
> -		rc = pmac_i2c_setmode(bus, pmac_i2c_mode_std);
> -		if (rc)
> -			goto bail;
> -		rc = pmac_i2c_xfer(bus, addrdir, 0, 0, &data->byte, 1);
> -	    	break;
>          case I2C_SMBUS_BYTE_DATA:
> -		rc = pmac_i2c_setmode(bus, read ?
> -				      pmac_i2c_mode_combined :
> -				      pmac_i2c_mode_stdsub);
> -		if (rc)
> -			goto bail;
> -		rc = pmac_i2c_xfer(bus, addrdir, 1, command, &data->byte, 1);
> +		buf = &data->byte;
> +		len = 1;
>  	    	break;
>          case I2C_SMBUS_WORD_DATA:
> -		rc = pmac_i2c_setmode(bus, read ?
> -				      pmac_i2c_mode_combined :
> -				      pmac_i2c_mode_stdsub);
> -		if (rc)
> -			goto bail;
>  		if (!read) {
>  			local[0] = data->word & 0xff;
>  			local[1] = (data->word >> 8) & 0xff;
>  		}
> -		rc = pmac_i2c_xfer(bus, addrdir, 1, command, local, 2);
> -		if (rc == 0 && read) {
> -			data->word = ((u16)local[1]) << 8;
> -			data->word |= local[0];
> -		}
> +		buf = local;
> +		len = 2;
>  	    	break;
>  
>  	/* Note that these are broken vs. the expected smbus API where
> @@ -105,28 +95,35 @@ static s32 i2c_powermac_smbus_xfer(	stru
>  	 * a repeat start/addr phase (but not stop in between)
>  	 */
>          case I2C_SMBUS_BLOCK_DATA:
> -		rc = pmac_i2c_setmode(bus, read ?
> -				      pmac_i2c_mode_combined :
> -				      pmac_i2c_mode_stdsub);
> -		if (rc)
> -			goto bail;
> -		rc = pmac_i2c_xfer(bus, addrdir, 1, command, data->block,
> -				   data->block[0] + 1);
> -
> +		buf = data->block;
> +		len = data->block[0] + 1;
>  		break;
>  	case I2C_SMBUS_I2C_BLOCK_DATA:
> -		rc = pmac_i2c_setmode(bus, read ?
> -				      pmac_i2c_mode_combined :
> -				      pmac_i2c_mode_stdsub);
> -		if (rc)
> -			goto bail;
> -		rc = pmac_i2c_xfer(bus, addrdir, 1, command,
> -				   &data->block[1], data->block[0]);
> +		buf = &data->block[1];
> +		len = data->block[0];
>  		break;
>  
>          default:
> -	    	rc = -EINVAL;
> +		return -EINVAL;
> +	}
> +
> +	rc = pmac_i2c_open(bus, 0);
> +	if (rc)
> +		return rc;
> +
> +	rc = pmac_i2c_setmode(bus, mode);
> +	if (rc)
> +		goto bail;
> +
> +	rc = pmac_i2c_xfer(bus, addrdir, subsize, subaddr, buf, len);
> +	if (rc)
> +		goto bail;
> +
> +	if (size == I2C_SMBUS_WORD_DATA && read) {
> +		data->word = ((u16)local[1]) << 8;
> +		data->word |= local[0];
>  	}
> +
>   bail:
>  	pmac_i2c_close(bus);
>  	return rc;
> 
> 
