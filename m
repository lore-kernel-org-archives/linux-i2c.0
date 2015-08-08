From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/8] i2c: core: Add support for best effort block read
 emulation
Date: Sat, 8 Aug 2015 16:20:19 +0100
Message-ID: <55C61E33.1020205@kernel.org>
References: <1438697056-2946-1-git-send-email-irina.tirdea@intel.com>
 <1438697056-2946-2-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438697056-2946-2-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/08/15 15:04, Irina Tirdea wrote:
> There are devices that need to handle block transactions
> regardless of the capabilities exported by the adapter.
> For performance reasons, they need to use i2c read blocks
> if available, otherwise emulate the block transaction with word
> or byte transactions.
> 
> Add support for a helper function that would read a data block
> using the best transfer available: I2C_FUNC_SMBUS_READ_I2C_BLOCK,
> I2C_FUNC_SMBUS_READ_WORD_DATA or I2C_FUNC_SMBUS_READ_BYTE_DATA.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
I like this a lot.

Reviewed-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c.h    |  3 +++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index c83e4d1..79ba6a8 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2942,6 +2942,71 @@ trace:
>  }
>  EXPORT_SYMBOL(i2c_smbus_xfer);
>  
> +/**
> + * i2c_smbus_read_i2c_block_data_or_emulated - read block or emulate
> + * @client: Handle to slave device
> + * @command: Byte interpreted by slave
> + * @length: Size of data block; SMBus allows at most 32 bytes
> + * @values: Byte array into which data will be read; big enough to hold
> + *	the data returned by the slave.  SMBus allows at most 32 bytes.
> + *
> + * This executes the SMBus "block read" protocol if supported by the adapter.
> + * If block read is not supported, it emulates it using either word or byte
> + * read protocols depending on availability.
> + *
> + * The addresses of the I2C slave device that are accessed with this function
> + * must be mapped to a linear region, so that a block read will have the same
> + * effect as a byte read. Before using this function you must double-check
> + * if the I2C slave does support exchanging a block transfer with a byte
> + * transfer.
> + */
> +s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
> +					      u8 command, u8 length, u8 *values)
> +{
> +	u8 i;
> +	int status;
> +
> +	if (length > I2C_SMBUS_BLOCK_MAX)
> +		length = I2C_SMBUS_BLOCK_MAX;
> +
> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> +		return i2c_smbus_read_i2c_block_data(client, command, length, values);
> +
> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_WORD_DATA |
> +				    I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
> +		for (i = 0; (i + 2) <= length; i += 2) {
> +			status = i2c_smbus_read_word_data(client, command + i);
> +			if (status < 0)
> +				return status;
> +			values[i] = status & 0xff;
> +			values[i + 1] = status >> 8;
I was about to suggest we knew we were word aligned for both elements and hence could
use an endian conversion, but I guess we don't know that as values might not be word
aligned.  Hence what you have is the best we can do!
> +		}
> +		if (i < length) {
> +			status = i2c_smbus_read_byte_data(client, command + i);
> +			if (status < 0)
> +				return status;
> +			values[i] = status;
> +			i++;
> +		}
> +		return i;
> +	}
> +
> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
> +		for (i = 0; i < length; i++) {
> +			status = i2c_smbus_read_byte_data(client, command + i);
> +			if (status < 0)
> +				return status;
> +			values[i] = status;
> +		}
> +		return i;
> +	}
> +
> +	dev_err(&client->adapter->dev, "Unsupported transactions\n");
> +
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data_or_emulated);
> +
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>  int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
>  {
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index e83a738..faf518d 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -121,6 +121,9 @@ extern s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client,
>  extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
>  					  u8 command, u8 length,
>  					  const u8 *values);
> +extern s32
> +i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
> +					  u8 command, u8 length, u8 *values);
>  #endif /* I2C */
>  
>  /**
> 
