From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: (mpc) Add support for SMBUS_READ_BLOCK_DATA
Date: Tue, 15 Nov 2011 09:54:45 +0100
Message-ID: <20111115095445.3d34e99e@endymion.delvare>
References: <1321338462-6138-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1321338462-6138-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tang Yuantian <B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

On Mon, 14 Nov 2011 22:27:42 -0800, Guenter Roeck wrote:
> Add support for SMBUS_READ_BLOCK_DATA to the i2c-mpc bus driver.
> Required to support the PMBus zl6100 driver with i2c-mpc.
> 
> Reported-by: Tang Yuantian <B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Tang Yuantian <B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mpc.c |   33 +++++++++++++++++++++++++--------
>  1 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 107397a..77aade7 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -454,7 +454,7 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
>  }
>  
>  static int mpc_read(struct mpc_i2c *i2c, int target,
> -		    u8 *data, int length, int restart)
> +		    u8 *data, int length, int restart, bool block)

bool block would be better named bool recv_len IMHO. It will be set to
0 for I2C block reads, which is confusing.

>  {
>  	unsigned timeout = i2c->adap.timeout;
>  	int i, result;
> @@ -470,7 +470,7 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
>  		return result;
>  
>  	if (length) {
> -		if (length == 1)
> +		if (length == 1 && !block)
>  			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_TXAK);
>  		else
>  			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA);
> @@ -479,17 +479,28 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
>  	}
>  
>  	for (i = 0; i < length; i++) {
> +		u8 byte;
> +
>  		result = i2c_wait(i2c, timeout, 0);
>  		if (result < 0)
>  			return result;
>  
> +		byte = readb(i2c->base + MPC_I2C_DR);
> +		/*
> +		 * Adjust length if first received byte is length
> +		 */
> +		if (i == 0 && block) {
> +			if (byte == 0 || byte > I2C_SMBUS_BLOCK_MAX)
> +				return -EPROTO;
> +			length += byte;
> +		}
> +		data[i] = byte;
>  		/* Generate txack on next to last byte */
>  		if (i == length - 2)
>  			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_TXAK);
>  		/* Do not generate stop on last byte */
>  		if (i == length - 1)
>  			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX);
> -		data[i] = readb(i2c->base + MPC_I2C_DR);
>  	}

This needs careful testing (which I can't do.) There may have been a
reason why the read was done after the writes. Swapping the commands
may be the wrong thing to do. The dummy read earlier in this function
suggests that maybe changes to CCR do not take effect until you read
from (or write to) the DR register.

Can't the above be rewritten to keep the order of the commands as it
was before? AFAICS it would only take one or two extra tests.

Note that the hardware implementation may make it difficult or even
impossible to properly support SMBus block reads of 1 byte. Not sure
what should be done when this can be supported and still happens...
Returning -EOPNOTSUPP I guess, and then probably the I2C engine needs
some form of reset.

>  
>  	return length;
> @@ -532,12 +543,17 @@ static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  			"Doing %s %d bytes to 0x%02x - %d of %d messages\n",
>  			pmsg->flags & I2C_M_RD ? "read" : "write",
>  			pmsg->len, pmsg->addr, i + 1, num);
> -		if (pmsg->flags & I2C_M_RD)
> -			ret =
> -			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
> -		else
> +		if (pmsg->flags & I2C_M_RD) {
> +			bool block = pmsg->flags & I2C_M_RECV_LEN;

Here again I'd rather name it bool recv_len for clarity.

> +
> +			ret = mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i,
> +				       block);

That's a lot of parameters, most coming from pmsg. It would be more
efficient to pass pmsg itself. Not directly related to your patch,
admittedly, but it makes the problem more obvious. Maybe a cleanup for
later.

> +			if (block && ret > 0)
> +				pmsg->len = ret;
> +		} else {
>  			ret =
>  			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
> +		}
>  	}
>  	mpc_i2c_stop(i2c);
>  	return (ret < 0) ? ret : num;
> @@ -545,7 +561,8 @@ static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  
>  static u32 mpc_functionality(struct i2c_adapter *adap)
>  {
> -	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
> +	  | I2C_FUNC_SMBUS_READ_BLOCK_DATA;

You could add I2C_FUNC_SMBUS_BLOCK_PROC_CALL too, even though I
don't know of any slave driver using it.

>  }
>  
>  static const struct i2c_algorithm mpc_algo = {


-- 
Jean Delvare
