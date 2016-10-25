From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] I2C Designware Core Supports SMBUS BLOCK
Date: Tue, 25 Oct 2016 14:50:25 +0300
Message-ID: <20161025115025.GI1476@lahna.fi.intel.com>
References: <1477370113-15145-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477370113-15145-1-git-send-email-tnhuynh@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tnhuynh@apm.com
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 25, 2016 at 11:35:13AM +0700, tnhuynh@apm.com wrote:
> From: Tin Huynh <tnhuynh@apm.com>
> 
> Free and Open IPMI use SMBUS BLOCK Read/Write to support SSIF protocol.
> However, I2C Designwave Core Driver doesn't handle the case at the moment.
> The below patch supports this feature.
> 
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c    |   42 +++++++++++++++++++++++++--
>  drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
>  2 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 1fe93c4..3abf0e5 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -588,8 +588,17 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>  			 * detected from the registers so we set it always
>  			 * when writing/reading the last byte.
>  			 */
> +
> +			/*
> +			 * i2c-core.c always set the buffer length of
> +			 * I2C_FUNC_SMBUS_BLOCK_DATA to 1. The length will
> +			 * be adjusted when receiving the first byte.
> +			 * Thus we can't stop the transaction here.
> +			 */
> +

No empty line here.

>  			if (dev->msg_write_idx == dev->msgs_num - 1 &&
> -			    buf_len == 1)
> +			    buf_len == 1 &&
> +			    !(msgs[dev->msg_write_idx].flags & I2C_M_RECV_LEN))

Why not store flags somewhere in local variable. Then you do not need
the ugly line splitting above.

So instead
			if (dev->msg_write_idx == dev->msgs_num -1 &&
			    buf_len == 1 && !(flags & I2C_M_RECV_LEN))

but even that starts to require small helper function, I think.

>  				cmd |= BIT(9);
>  
>  			if (need_restart) {
> @@ -614,7 +623,14 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>  		dev->tx_buf = buf;
>  		dev->tx_buf_len = buf_len;
>  
> -		if (buf_len > 0) {
> +		/*
> +		 * Because we don't know the buffer length in the
> +		 * I2C_FUNC_SMBUS_BLOCK_DATA case, we can't stop
> +		 * the transcation here.
                       ^^^^^^^^^^^
		       transaction

> +		 */
> +

No empty line here.

> +		if (buf_len > 0 ||
> +			msgs[dev->msg_write_idx].flags & I2C_M_RECV_LEN) {

Here also same comments about "flags".

>  			/* more bytes to be written */
>  			dev->status |= STATUS_WRITE_IN_PROGRESS;
>  			break;
> @@ -659,7 +675,27 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>  		rx_valid = dw_readl(dev, DW_IC_RXFLR);
>  
>  		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
> -			*buf++ = dw_readl(dev, DW_IC_DATA_CMD);
> +			*buf = dw_readl(dev, DW_IC_DATA_CMD);
> +			/* ensure length byte is a valid value */
> +			if (msgs[dev->msg_read_idx].flags & I2C_M_RECV_LEN
> +				&& *buf <= I2C_SMBUS_BLOCK_MAX  && *buf > 0) {

And here. Also you have "  " between I2C_SMBUS_BLOCK_MAX and &&.

> +				/*
> +				 * Adjust the buffer length and mask the flag
> +				 * after receiving the first byte
> +				 */
> +				msgs[dev->msg_read_idx].flags &=
> +								~I2C_M_RECV_LEN;

And here.

Actually you should move the whole block into a helper function.

> +				len = *buf + 1;
> +				/* Increase one with PEC flag */
> +				if (msgs[dev->msg_read_idx].flags &
> +							I2C_CLIENT_PEC)
> +					len++;
> +
> +				dev->tx_buf_len = len > dev->rx_outstanding ?
> +					len - dev->rx_outstanding : 0;
> +				msgs[dev->msg_read_idx].len = len;
> +			}
> +			buf++;
>  			dev->rx_outstanding--;
>  		}
>  
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 0b42a12..886fb62 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -220,6 +220,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  		I2C_FUNC_SMBUS_BYTE |
>  		I2C_FUNC_SMBUS_BYTE_DATA |
>  		I2C_FUNC_SMBUS_WORD_DATA |
> +		I2C_FUNC_SMBUS_BLOCK_DATA |
>  		I2C_FUNC_SMBUS_I2C_BLOCK;
>  
>  	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
> -- 
> 1.7.1
> 
> 
> -- 
> CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
> for the sole use of the intended recipient(s) and contains information that 
> is confidential and proprietary to Applied Micro Circuits Corporation or 
> its subsidiaries. It is to be used solely for the purpose of furthering the 
> parties' business relationship. All unauthorized review, use, disclosure or 
> distribution is prohibited. If you are not the intended recipient, please 
> contact the sender by reply e-mail and destroy all copies of the original 
> message.

Yeah, right.
