From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 06/21] i2c: diolan: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 08:50:37 -0700
Message-ID: <20180514155037.GA29550@roeck-us.net>
References: <20180514145330.4857-1-peda@axentia.se>
 <20180514145330.4857-7-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180514145330.4857-7-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 14, 2018 at 04:53:15PM +0200, Peter Rosin wrote:
> Because it looks neater and allows factoring out some code
> that is now common between if and else.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/i2c/busses/i2c-diolan-u2c.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
> index f718ee4e3332..3f28317cde39 100644
> --- a/drivers/i2c/busses/i2c-diolan-u2c.c
> +++ b/drivers/i2c/busses/i2c-diolan-u2c.c
> @@ -360,11 +360,11 @@ static int diolan_usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
>  			if (ret < 0)
>  				goto abort;
>  		}
> +		ret = diolan_i2c_put_byte_ack(dev,
> +					      i2c_8bit_addr_from_msg(pmsg));
> +		if (ret < 0)
> +			goto abort;
>  		if (pmsg->flags & I2C_M_RD) {
> -			ret =
> -			    diolan_i2c_put_byte_ack(dev, (pmsg->addr << 1) | 1);
> -			if (ret < 0)
> -				goto abort;
>  			for (j = 0; j < pmsg->len; j++) {
>  				u8 byte;
>  				bool ack = j < pmsg->len - 1;
> @@ -393,9 +393,6 @@ static int diolan_usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
>  				pmsg->buf[j] = byte;
>  			}
>  		} else {
> -			ret = diolan_i2c_put_byte_ack(dev, pmsg->addr << 1);
> -			if (ret < 0)
> -				goto abort;
>  			for (j = 0; j < pmsg->len; j++) {
>  				ret = diolan_i2c_put_byte_ack(dev,
>  							      pmsg->buf[j]);
> -- 
> 2.11.0
> 
