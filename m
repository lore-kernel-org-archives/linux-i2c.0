From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] i2c: designware: Implement support for SMBus block
 read and write
Date: Mon, 07 Nov 2016 16:11:02 +0200
Message-ID: <1478527862.5295.69.camel@linux.intel.com>
References: <1477896677-13085-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62258 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752648AbcKGOLI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 7 Nov 2016 09:11:08 -0500
In-Reply-To: <1477896677-13085-1-git-send-email-tnhuynh@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: tnhuynh@apm.com, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com

On Mon, 2016-10-31 at 13:51 +0700, tnhuynh@apm.com wrote:
> From: Tin Huynh <tnhuynh@apm.com>
> 
> Free and Open IPMI use SMBUS BLOCK Read/Write to support SSIF
> protocol.
> However, I2C Designware Core Driver doesn't handle the case at the
> moment.
> The below patch supports this feature.

My comments below.


> @@ -543,6 +543,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev
> *dev)
>  	intr_mask = DW_IC_INTR_DEFAULT_MASK;
>  
>  	for (; dev->msg_write_idx < dev->msgs_num; dev-
> >msg_write_idx++) {
> +		u32 flags = msgs[dev->msg_write_idx].flags;

+ empty line.

>  		/*
>  		 * if target address has changed, we need to
>  		 * reprogram the target address in the i2c

> @@ -588,8 +589,15 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev
> *dev)
>  			 * detected from the registers so we set it
> always
>  			 * when writing/reading the last byte.
>  			 */
> +
> +			/*
> +			 * i2c-core.c always set the buffer length of

set -> sets

> +			 * I2C_FUNC_SMBUS_BLOCK_DATA to 1. The length
> will
> +			 * be adjusted when receiving the first byte.
> +			 * Thus we can't stop the transaction here.
> +			 */
> 

> @@ -635,6 +648,25 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev
> *dev)
>  	dw_writel(dev, intr_mask,  DW_IC_INTR_MASK);
>  }
>  
> +static u8
> +i2c_dw_recv_len(struct dw_i2c_dev *dev, u8 len)
> +{
> +	struct i2c_msg *msgs = dev->msgs;
> +	u32 flags = msgs[dev->msg_read_idx].flags;
> +
> +	/*
> +	 * Adjust the buffer length and mask the flag
> +	 * after receiving the first byte

Add dot to the end, please.

> +	 */
> +	len = (flags & I2C_CLIENT_PEC) ? len + 2 : len + 1;

len += flags & I2C_CLIENT_PEC ? 2 : 1;

> +	dev->tx_buf_len = len > dev->rx_outstanding ?
> +		len - dev->rx_outstanding : 0;

Can be len more than twice longer as rx_outstanding?

Would it be better to write as
tx_buf_len = len - min(len, rx_outstanding);
?

> +	msgs[dev->msg_read_idx].len = len;
> +	msgs[dev->msg_read_idx].flags &= ~I2C_M_RECV_LEN;
> +
> +	return len;
> +}
> +
>  static void
>  i2c_dw_read(struct dw_i2c_dev *dev)
>  {
> @@ -659,7 +691,14 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev
> *dev)
>  		rx_valid = dw_readl(dev, DW_IC_RXFLR);
>  
>  		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
> -			*buf++ = dw_readl(dev, DW_IC_DATA_CMD);
> +			u32 flags = msgs[dev->msg_read_idx].flags;

+ empty line.

> +			*buf = dw_readl(dev, DW_IC_DATA_CMD);
> +			/* Ensure length byte is a valid value */
> +			if (flags & I2C_M_RECV_LEN &&
> +				*buf <= I2C_SMBUS_BLOCK_MAX && *buf >
> 0) {

Is it my mail client or indentation is wrong?

> +				len = i2c_dw_recv_len(dev, *buf);
> +			}
> +			buf++;
>  			dev->rx_outstanding--;
>  		}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
