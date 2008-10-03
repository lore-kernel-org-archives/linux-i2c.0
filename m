From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)
Date: Fri, 3 Oct 2008 15:21:23 +0200
Message-ID: <20081003152123.489cd10c@hyperion.delvare>
References: <6601CF63C167F44A9A9E97E41EE4B16C902D37@CLUSTEREX.corporate.local>
	<20080926092846.63ac885a@hyperion.delvare>
	<6601CF63C167F44A9A9E97E41EE4B16C90304B@CLUSTEREX.corporate.local>
	<20080930092458.1c40edce@hyperion.delvare>
	<6601CF63C167F44A9A9E97E41EE4B16C903402@CLUSTEREX.corporate.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <6601CF63C167F44A9A9E97E41EE4B16C903402-5t2rvgrEeX4DiO1sSoDvakTPyXqlV3SlZkel5v8DVj8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Mortha, Prakash" <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Prakash,

On Wed, 1 Oct 2008 20:09:15 -0400, Mortha, Prakash wrote:
> Hi Jean,
> 
> Thank you very much for your corrections/advice.
> 
> Please find attached the patch files for i2c-viapro.c and i2c-core.c
> files for supporting I2C_SMBUS_PROC_CALL. 

For future patches, please make sure that I can apply them with patch
-p1. The header should look like:

--- linux-2.6.24.3/drivers/i2c/i2c-core.c.orig  2008-02-25 19:20:20.000000000 -0500
+++ linux-2.6.24.3/drivers/i2c/i2c-core.c       2008-10-01 19:48:25.771245369 -0400

If you're working with many patches, I can only recommend using
"quilt", so you always get the patch format right.

> 
> Please provide your comments.

Comments on the i2c-core patch:

> --- i2c-core.c	2008-02-25 19:20:20.000000000 -0500
> +++ ./../../../buildroot/build_i686/linux-2.6.24.3/drivers/i2c/i2c-core.c	2008-10-01 19:48:25.771245369 -0400
> @@ -1274,6 +1274,18 @@
>  }
>  EXPORT_SYMBOL(i2c_smbus_read_word_data);
>  
> +s32 i2c_smbus_process_call(struct i2c_client *client, u8 command, u16 value)
> +{
> +	union i2c_smbus_data data;
> +	data.word = value;
> +	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,I2C_SMBUS_WRITE,command, I2C_SMBUS_PROC_CALL, &data))

Line too long, you'll have to fold it, and there must be a space after
each comma. I recommend that you run scripts/checkpatch.pl on every
patch before you post them, this will catch formatting errors.

> +		return -1;

All these helper functions have been updated recently to transmit the
error code form i2c_smbus_xfer() instead of -1. Please do the same.
Please look at a recent kernel tree to use the same variable names so
that all the helper functions look the same.

> +	else
> +		return data.word;
> +}
> +EXPORT_SYMBOL(i2c_smbus_process_call);
> +

And please insert the new function _after_ i2c_smbus_write_word_data()
so that the two word functions stay next to each other.

> +
>  s32 i2c_smbus_write_word_data(struct i2c_client *client, u8 command, u16 value)
>  {
>  	union i2c_smbus_data data;

Documentation/i2c/smbus-protocol will also have to be updated to
mention this new function.

Comments on the i2c-viapro patch:

> --- i2c-viapro.c	2008-10-01 12:19:39.578169020 -0400
> +++ ./../../../../buildroot/build_i686/linux-2.6.24.3/drivers/i2c/busses/i2c-viapro.c	2008-10-01 19:49:02.460538263 -0400
> @@ -82,6 +82,7 @@
>  #define VT596_BYTE		0x04
>  #define VT596_BYTE_DATA		0x08
>  #define VT596_WORD_DATA		0x0C
> +#define VT596_PROC_CALL         0x10

Please use a tabulation instead of spaces.

>  #define VT596_BLOCK_DATA	0x14
>  #define VT596_I2C_BLOCK_DATA	0x34
>  
> @@ -231,6 +232,12 @@
>  		}
>  		size = VT596_WORD_DATA;
>  		break;
> +	case I2C_SMBUS_PROC_CALL:
> +		outb_p(command, SMBHSTCMD);
> +		outb_p((data->word & 0xff00) >> 8, SMBHSTDAT0);
> +		outb_p(data->word & 0xff, SMBHSTDAT1);

As already discussed, the bytes are in the wrong order. The SMBus
specification says that the LSB is always first.

> +		size = VT596_PROC_CALL;

I would add:

		read_write = I2C_SMBUS_READ;

This way...

> +		break;
>  	case I2C_SMBUS_I2C_BLOCK_DATA:
>  		if (!(vt596_features & FEATURE_I2CBLOCK))
>  			goto exit_unsupported;
> @@ -260,7 +267,7 @@
>  	if (vt596_transaction(size)) /* Error in transaction */
>  		return -1;
>  
> -	if ((read_write == I2C_SMBUS_WRITE) || (size == VT596_QUICK))
> +	if (((size != VT596_PROC_CALL) && (read_write == I2C_SMBUS_WRITE)) || (size == VT596_QUICK))

... you no longer have to change this. This is what i2c-core does for
the software emulation of SMBus over I2C, and some i2c bus drivers as
well.

>  		return 0;
>  
>  	switch (size) {
> @@ -269,6 +276,7 @@
>  		data->byte = inb_p(SMBHSTDAT0);
>  		break;
>  	case VT596_WORD_DATA:
> +	case VT596_PROC_CALL:
>  		data->word = inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) << 8);
>  		break;
>  	case VT596_I2C_BLOCK_DATA:
> @@ -293,7 +301,7 @@
>  {
>  	u32 func = I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
>  	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> -	    I2C_FUNC_SMBUS_BLOCK_DATA;
> +	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_SMBUS_PROC_CALL;

Nitpicking: I'd add I2C_SMBUS_PROC_CALL before
I2C_FUNC_SMBUS_BLOCK_DATA, because this is where readers will expect it.

>  
>  	if (vt596_features & FEATURE_I2CBLOCK)
>  		func |= I2C_FUNC_SMBUS_I2C_BLOCK;

Also note that, in order to apply your patches upstream, I will need
a proper summary, a description of what the patch is doing and why it
is needed, and your Signed-off-by line. See section 12 (Sign your work)
of Documentation/SubmittingPatches for details.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
