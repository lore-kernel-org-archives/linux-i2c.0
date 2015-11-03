From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 3/3] at24: Support 16-bit devices on SMBus
Date: Tue, 3 Nov 2015 11:33:53 +0100
Message-ID: <20151103113353.0b62c5e1@endymion.delvare>
References: <1001500768.63909.1441302107931.JavaMail.zimbra@xes-inc.com>
	<361739546.82254.1441310010061.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46011 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbbKCKd4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 3 Nov 2015 05:33:56 -0500
In-Reply-To: <361739546.82254.1441310010061.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>

Hi Aaron,

On Thu, 3 Sep 2015 14:53:30 -0500 (CDT), Aaron Sierra wrote:
> Previously, the at24 driver would bail out in the case of a 16-bit
> addressable EEPROM attached to an SMBus controller. This is because
> SMBus block reads and writes don't map to I2C multi-byte reads and
> writes when the offset portion is 2 bytes.
> 
> Instead of bailing out, this patch settles for functioning with single
> byte read SMBus cycles. Writes can be block or single-byte, depending on
> SMBus controller features.
> 
> This patch introduces at24_smbus_read_byte_data to transparently handle
> single-byte reads from 8-bit and 16-bit devices.
> 
> Functionality has been tested with the following devices:
> 
>     AT24CM01 attached to Intel ISCH SMBus (1.8 KB/s)
>     AT24C512 attached to Intel I801 SMBus (1.4 KB/s)
> 
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/misc/eeprom/Kconfig |  4 +++-
>  drivers/misc/eeprom/at24.c  | 40 +++++++++++++++++++++++++++++++++++-----
>  2 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index 04f2e1f..bc79a44 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -22,7 +22,9 @@ config EEPROM_AT24
>  
>  	  If you use this with an SMBus adapter instead of an I2C adapter,
>  	  full functionality is not available.  Only smaller devices are
> -	  supported (24c16 and below, max 4 kByte).
> +	  supported via block reads (24c16 and below, max 4 kByte).
> +	  Larger devices that use 16-bit addresses will only work with
> +	  individual byte reads, which is very slow.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called at24.
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index b92ee6e..457f49c 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -134,6 +134,32 @@ MODULE_DEVICE_TABLE(i2c, at24_ids);
>  /*-------------------------------------------------------------------------*/
>  
>  /*
> + * Read a byte from an AT24 device using SMBus cycles.
> + */
> +static inline s32 at24_smbus_read_byte_data(struct at24_data *at24,
> +	struct i2c_client *client, u16 offset)
> +{
> +	s32 res;
> +
> +	if (!(at24->chip.flags & AT24_FLAG_ADDR16))
> +		return i2c_smbus_read_byte_data(client, offset);
> +
> +	/*
> +	 * Emulate I2C multi-byte read by using SMBus "write byte" and
> +	 * "receive byte".  This isn't optimal since there is an
> +	 * unnecessary STOP involved, but it's the only way to

It's not just non-optimal, it's also slightly unsafe. You do not hold
any lock on the I2C bus, so it is possible that another I2C transaction
happens between setting the EEPROM internal pointer and reading the
value from the register. I would hope that all AT24-compliant EEPROMs
handle this case gracefully, but you would better check. Also, on
multi-master I2C buses, it is possible that another master initiates a
transaction in between, possibly to the same EEPROM, in which case you
are screwed because the internal pointer will be changed by that
third-party transaction.

This limitation is the key reason why I'm not thrilled by this patch
set. If it is accepted then the risk above should be clearly documented.

> +	 * work on many SMBus controllers when talking to EEPROMs

s/many SMBus/SMBus-only/

This is really a design limitation of SMBus itself.

> +	 * with multi-byte addresses.
> +	 */
> +	res = i2c_smbus_write_byte_data(client,
> +		((offset >> 8) & 0xff), (offset & 0xff));

Useless masking.

> +	if (res)
> +		return res;
> +
> +	return i2c_smbus_read_byte(client);

If you go that route then you may be able to get less slow reads by not
issuing the SMBus "write byte" for every byte you want to read. All
AT24-like EEPROMs I've seen so far implement internal pointer
auto-increment, so consecutive SMBus "receive byte" will return the
data bytes from the following offsets. This is i2cdump's "c" mode. As
you are already on the unsafe side, it makes no difference on that
front, but it should more than double your read rate.

I'm just not sure it this is part of the AT24 "specification" or if it
works by accident.

> +}
> +
> +/*
>   * Write a byte to an AT24 device using SMBus cycles.
>   */
>  static inline s32 at24_smbus_write_byte_data(struct at24_data *at24,
> @@ -290,7 +316,8 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
>  			}
>  			break;
>  		case I2C_SMBUS_BYTE_DATA:
> -			status = i2c_smbus_read_byte_data(client, offset);
> +			status = at24_smbus_read_byte_data(at24,
> +				client, offset);
>  			if (status >= 0) {
>  				buf[0] = status;
>  				status = count;
> @@ -584,10 +611,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  	/* Use I2C operations unless we're stuck with SMBus extensions. */
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> -		if (chip.flags & AT24_FLAG_ADDR16)
> -			return -EPFNOSUPPORT;
> -
> -		if (i2c_check_functionality(client->adapter,
> +		if (chip.flags & AT24_FLAG_ADDR16) {
> +			/*
> +			 * This will be slow, but better than nothing
> +			 * (e.g. read @ 1.4 KiB/s).
> +			 */
> +			use_smbus = I2C_SMBUS_BYTE_DATA;
> +		} else if (i2c_check_functionality(client->adapter,
>  				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>  			use_smbus = I2C_SMBUS_I2C_BLOCK_DATA;
>  		} else if (i2c_check_functionality(client->adapter,

-- 
Jean Delvare
SUSE L3 Support
