From: "Heasley, Seth" <seth.heasley@intel.com>
Subject: RE: [PATCH 1/1] i2c-ismt: add the support of the
 I2C_SMBUS_I2C_BLOCK_DATA transaction type
Date: Tue, 19 Nov 2013 00:09:08 +0000
Message-ID: <DEC3922D1904474A8862C7BFF516EA9A865BF201@ORSMSX101.amr.corp.intel.com>
References: <5285704e.jwiZWyk8R3ZEoySS%robert.valiquette@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5285704e.jwiZWyk8R3ZEoySS%robert.valiquette@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Valiquette, Robert" <robert.valiquette@intel.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Ralston, James D" <james.d.ralston@intel.com>
List-Id: linux-i2c@vger.kernel.org

> This patch adds the support of the I2C_SMBUS_I2C_BLOCK_DATA
> transaction type for the iSMT SMBus Controller.
> 
> Signed-off-by: Robert Valiquette <robert.valiquette@intel.com>
> ---
> --- a/drivers/i2c/busses/i2c-ismt.c	2013-11-14 11:36:15.830322000 -0500
> +++ b/drivers/i2c/busses/i2c-ismt.c	2013-11-14 16:01:56.532356000 -0500
> @@ -344,6 +344,7 @@
>  			data->word = dma_buffer[0] | (dma_buffer[1] << 8);
>  			break;
>  		case I2C_SMBUS_BLOCK_DATA:
> +		case I2C_SMBUS_I2C_BLOCK_DATA:
>  			memcpy(&data->block[1], dma_buffer, desc-
> >rxbytes);
>  			data->block[0] = desc->rxbytes;
>  			break;
> @@ -509,6 +510,41 @@
>  		}
>  		break;
> 
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		/* Make sure the lenght is valid */
> +		if (data->block[0] < 1)
> +			data->block[0] = 1;
> +
> +		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
> +			data->block[0] = I2C_SMBUS_BLOCK_MAX;
> +
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			/* i2c Block Write */
> +			dev_dbg(dev, "I2C_SMBUS_I2C_BLOCK_DATA:
> WRITE\n");
> +			dma_size = data->block[0] + 1;
> +			dma_direction = DMA_TO_DEVICE;
> +			desc->wr_len_cmd = dma_size;
> +			desc->control |= ISMT_DESC_I2C;
> +			priv->dma_buffer[0] = command;
> +			memcpy(&priv->dma_buffer[1], &data->block[1],
> dma_size);
> +		} else {
> +			/* i2c Block Read */
> +			dev_dbg(dev, "I2C_SMBUS_I2C_BLOCK_DATA:
> READ\n");
> +			dma_size = data->block[0];
> +			dma_direction = DMA_FROM_DEVICE;
> +			desc->rd_len = dma_size;
> +			desc->wr_len_cmd = command;
> +			desc->control |= (ISMT_DESC_I2C |
> ISMT_DESC_CWRL);
> +			/*
> +			 * Per the "Table 15-15. I2C Commands",
> +			 * in the External Design Specification (EDS),
> +			 * (Document Number: 508084, Revision: 2.0),
> +			 * the _rw bit must be 0
> +			 */
> +			desc->tgtaddr_rw = ISMT_DESC_ADDR_RW(addr, 0);
> +		}
> +		break;
> +
>  	default:
>  		dev_err(dev, "Unsupported transaction %d\n",
>  			size);
> @@ -582,6 +618,7 @@
>  	       I2C_FUNC_SMBUS_WORD_DATA		|
>  	       I2C_FUNC_SMBUS_PROC_CALL		|
>  	       I2C_FUNC_SMBUS_BLOCK_DATA	|
> +	       I2C_FUNC_SMBUS_I2C_BLOCK		|
>  	       I2C_FUNC_SMBUS_PEC;
>  }
> 
Acked-by: Seth Heasley <seth.heasley@intel.com>
