From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] i2c: at91: Fix compilation warning.
Date: Wed, 31 May 2017 14:18:10 +0200
Message-ID: <20170531121810.cub3ta5pl5rjo3uv@rfolt0960.corp.atmel.com>
References: <ad09a3e39508817a96e9a9477b62e992031d5b69.1496214450.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49083 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbdEaMSM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 31 May 2017 08:18:12 -0400
Content-Disposition: inline
In-Reply-To: <ad09a3e39508817a96e9a9477b62e992031d5b69.1496214450.git.arvind.yadav.cs@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: ludovic.desroches@microchip.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 31, 2017 at 12:45:38PM +0530, Arvind Yadav wrote:
> Replace '%d' by '%zu' to fix the following compilation warning:-
> 
> drivers/i2c/busses/i2c-at91.c:277:2: warning: format ‘%d’ expects argument of type ‘int’, but argument 5 has type ‘size_t’ [-Wformat=]
>   dev_dbg(dev->dev, "wrote 0x%x, to go %d\n", *dev->buf, dev->buf_len);
>   ^
> drivers/i2c/busses/i2c-at91.c: In function ‘at91_twi_read_next_byte’:
> drivers/i2c/busses/i2c-at91.c:405:4: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘size_t’ [-Wformat=]
>     dev_dbg(dev->dev, "received block length %d\n",
>     ^
> drivers/i2c/busses/i2c-at91.c:418:2: warning: format ‘%d’ expects argument of type ‘int’, but argument 5 has type ‘size_t’ [-Wformat=]
>   dev_dbg(dev->dev, "read 0x%x, to go %d\n", *dev->buf, dev->buf_len);
>   ^
> drivers/i2c/busses/i2c-at91.c: In function ‘at91_do_twi_transfer’:
> drivers/i2c/busses/i2c-at91.c:625:2: warning: format ‘%d’ expects argument of type ‘int’, but argument 5 has type ‘size_t’ [-Wformat=]
>   dev_dbg(dev->dev, "transfer: %s %d bytes.\n",
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
>  drivers/i2c/busses/i2c-at91.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 2525cd9..38dd61d 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -274,7 +274,7 @@ static void at91_twi_write_next_byte(struct at91_twi_dev *dev)
>  		if (!dev->use_alt_cmd)
>  			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
>  
> -	dev_dbg(dev->dev, "wrote 0x%x, to go %d\n", *dev->buf, dev->buf_len);
> +	dev_dbg(dev->dev, "wrote 0x%x, to go %zu\n", *dev->buf, dev->buf_len);
>  
>  	++dev->buf;
>  }
> @@ -402,7 +402,7 @@ static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
>  			dev->msg->flags &= ~I2C_M_RECV_LEN;
>  			dev->buf_len += *dev->buf;
>  			dev->msg->len = dev->buf_len + 1;
> -			dev_dbg(dev->dev, "received block length %d\n",
> +			dev_dbg(dev->dev, "received block length %zu\n",
>  					 dev->buf_len);
>  		} else {
>  			/* abort and send the stop by reading one more byte */
> @@ -415,7 +415,7 @@ static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
>  	if (!dev->use_alt_cmd && dev->buf_len == 1)
>  		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
>  
> -	dev_dbg(dev->dev, "read 0x%x, to go %d\n", *dev->buf, dev->buf_len);
> +	dev_dbg(dev->dev, "read 0x%x, to go %zu\n", *dev->buf, dev->buf_len);
>  
>  	++dev->buf;
>  }
> @@ -622,7 +622,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  	 * writing the corresponding bit into the Control Register.
>  	 */
>  
> -	dev_dbg(dev->dev, "transfer: %s %d bytes.\n",
> +	dev_dbg(dev->dev, "transfer: %s %zu bytes.\n",
>  		(dev->msg->flags & I2C_M_RD) ? "read" : "write", dev->buf_len);
>  
>  	reinit_completion(&dev->cmd_complete);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
