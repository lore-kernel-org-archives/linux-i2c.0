From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i2c-core: fix coding style issues in i2c-core.c
Date: Sun, 13 Oct 2013 12:29:59 -0700
Message-ID: <1381692599.25528.5.camel@joe-AO722>
References: <525AF0ED.7050209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <525AF0ED.7050209-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: RAGHAVENDRA GANIGA <ravi23ganiga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2013-10-14 at 00:43 +0530, RAGHAVENDRA GANIGA wrote:
[]
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
[]
> @@ -1737,9 +1735,10 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  	if (adap->algo->master_xfer) {
>  #ifdef DEBUG
>  		for (ret = 0; ret < num; ret++) {
> -			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, "
> -				"len=%d%s\n", ret, (msgs[ret].flags & I2C_M_RD)
> -				? 'R' : 'W', msgs[ret].addr, msgs[ret].len,
> +			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, len=%d%s\n",
> +				ret,
> +				((msgs[ret].flags & I2C_M_RD) ? 'R' : 'W'),
> +				msgs[ret].addr, msgs[ret].len,
>  				(msgs[ret].flags & I2C_M_RECV_LEN) ? "+" : "");
>  		}

You added an unnecessary set of parentheses here and
you made it different from the similar line below.

Neither test really needs any parenthesis and this
could be written as:

			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, len=%d%s\n",
				ret,
				msgs[ret].flags & I2C_M_RD ? 'R' : 'W',
				msgs[ret].addr, msgs[ret].len,
				msgs[ret].flags & I2C_M_RECV_LEN ? "+" : "";

> @@ -2118,7 +2120,7 @@ EXPORT_SYMBOL(i2c_smbus_read_byte);
>  s32 i2c_smbus_write_byte(const struct i2c_client *client, u8 value)
>  {
>  	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
> -	                      I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
> +				I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);

Not an improvement.

Yes, the deleted line should use tabs but
the alignment of the new line is not correct.
Please align the indentation to the open parenthesis

	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
			      I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);

Using maximal tabs at start of line, and up to 7 spaces
to align properly.

(using 3 tabs, 6 spaces)
