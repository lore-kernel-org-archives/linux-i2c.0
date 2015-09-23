From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/1] i2c: added FUNC flag for unsupported clock
 stretching
Date: Wed, 23 Sep 2015 11:04:28 +0200
Message-ID: <20150923110428.4771845c@endymion.delvare>
References: <1440758606-398-1-git-send-email-nicola@corna.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1440758606-398-1-git-send-email-nicola@corna.info>
Sender: linux-doc-owner@vger.kernel.org
To: Nicola Corna <nicola@corna.info>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 28 Aug 2015 12:43:26 +0200, Nicola Corna wrote:
> Added I2C_FUNC_NO_CLK_STRETCH, to be used when clock stretching is not
> supported.
> Added this flag to drivers/i2c/algos/i2c-algo-bit.c when getscl is not
> available.
> 
> Signed-off-by: Nicola Corna <nicola@corna.info>
> ---
>  Documentation/i2c/functionality  | 1 +
>  drivers/i2c/algos/i2c-algo-bit.c | 5 ++++-
>  include/uapi/linux/i2c.h         | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/i2c/functionality b/Documentation/i2c/functionality
> index 4aae8ed..f53807e 100644
> --- a/Documentation/i2c/functionality
> +++ b/Documentation/i2c/functionality
> @@ -21,6 +21,7 @@ For the most up-to-date list of functionality constants, please check
>                                    I2C_M_REV_DIR_ADDR and I2C_M_NO_RD_ACK
>                                    flags (which modify the I2C protocol!)
>    I2C_FUNC_NOSTART                Can skip repeated start sequence
> +  I2C_FUNC_NO_CLK_STRETCH         Does NOT support clock stretching
>    I2C_FUNC_SMBUS_QUICK            Handles the SMBus write_quick command
>    I2C_FUNC_SMBUS_READ_BYTE        Handles the SMBus read_byte command
>    I2C_FUNC_SMBUS_WRITE_BYTE       Handles the SMBus write_byte command
> diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
> index 899bede..82cad0b 100644
> --- a/drivers/i2c/algos/i2c-algo-bit.c
> +++ b/drivers/i2c/algos/i2c-algo-bit.c
> @@ -602,10 +602,13 @@ bailout:
>  
>  static u32 bit_func(struct i2c_adapter *adap)
>  {
> +	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
> +
>  	return I2C_FUNC_I2C | I2C_FUNC_NOSTART | I2C_FUNC_SMBUS_EMUL |
>  	       I2C_FUNC_SMBUS_READ_BLOCK_DATA |
>  	       I2C_FUNC_SMBUS_BLOCK_PROC_CALL |
> -	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING;
> +	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING |
> +	       (bit_adap->getscl ? 0 : I2C_FUNC_NO_CLK_STRETCH);
>  }
>  
>  
> diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
> index b0a7dd6..59e4b43 100644
> --- a/include/uapi/linux/i2c.h
> +++ b/include/uapi/linux/i2c.h
> @@ -88,6 +88,7 @@ struct i2c_msg {
>  #define I2C_FUNC_SMBUS_PEC		0x00000008
>  #define I2C_FUNC_NOSTART		0x00000010 /* I2C_M_NOSTART */
>  #define I2C_FUNC_SLAVE			0x00000020
> +#define I2C_FUNC_NO_CLK_STRETCH		0x00000040 /* No check for SCL low */
>  #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
>  #define I2C_FUNC_SMBUS_QUICK		0x00010000
>  #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
