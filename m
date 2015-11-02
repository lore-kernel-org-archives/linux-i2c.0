From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/3] at24: Support SMBus block writes to 16-bit devices
Date: Mon, 2 Nov 2015 14:42:09 +0100
Message-ID: <20151102144209.19256228@endymion.delvare>
References: <857238265.63776.1441301982531.JavaMail.zimbra@xes-inc.com>
	<1888937035.82162.1441309955075.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57654 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbbKBNmO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 08:42:14 -0500
In-Reply-To: <1888937035.82162.1441309955075.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>

Hi Aaron,

Sorry for the late reply.

On Thu, 3 Sep 2015 14:52:35 -0500 (CDT), Aaron Sierra wrote:
> Introduce at24_smbus_write_i2c_block_data() to allow very slow write
> access to 16-bit EEPROM devices attached to SMBus controllers like
> the Intel I801.

This would be very bad hardware design. Are there actual systems out
there which use large EEPROMs over SMBus? I would only consider adding
this feature to the at24 driver if there is a real-world use case.
Otherwise the same can be done from user-space with eeprog.

> 
> With an AT24C512 device:
>     248 B/s with 1-byte page (default)
>     3.9 KB/s with 128-byte* page (via platform data)
> 
> *limited to 16-bytes by I2C_SMBUS_BLOCK_MAX / 2.
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/misc/eeprom/at24.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2d3db81..4cf53a0 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -134,6 +134,34 @@ MODULE_DEVICE_TABLE(i2c, at24_ids);
>  /*-------------------------------------------------------------------------*/
>  
>  /*
> + * Write block data to an AT24 device using SMBus cycles.
> + */
> +static inline s32 at24_smbus_write_i2c_block_data(struct at24_data *at24,
> +	const struct i2c_client *client, u16 off, u8 len, const u8 *vals)
> +{
> +	u8 *addr16;
> +	s32 res;
> +
> +	if (!(at24->chip.flags & AT24_FLAG_ADDR16))
> +		return i2c_smbus_write_i2c_block_data(client, off, len, vals);
> +
> +	addr16 = kzalloc(len + 1, GFP_KERNEL);
> +	if (!addr16)
> +		return -ENOMEM;

Allocating and freeing memory with every transfer is a bad idea, as
this slows the operation even more and favors memory fragmentation.
Why don't you use at24_data.writebuf?

> +
> +	/* Insert extra address byte into data stream */
> +	addr16[0] = off & 0xff;
> +	memcpy(addr16 + 1, vals, len);
> +
> +	res = i2c_smbus_write_i2c_block_data(client,
> +		(off >> 8) & 0xff, len + 1, addr16);

Useless masking.

> +
> +	kfree(addr16);
> +
> +	return res;
> +}
> +
> +/*
>   * This routine supports chips which consume multiple I2C addresses. It
>   * computes the addressing information to be used for a given r/w request.
>   * Assumes that sanity checks for offset happened at sysfs-layer.
> @@ -369,8 +397,8 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
>  		if (at24->use_smbus_write) {
>  			switch (at24->use_smbus_write) {
>  			case I2C_SMBUS_I2C_BLOCK_DATA:
> -				status = i2c_smbus_write_i2c_block_data(client,
> -						offset, count, buf);
> +				status = at24_smbus_write_i2c_block_data(at24,
> +						client, offset, count, buf);
>  				break;
>  			case I2C_SMBUS_BYTE_DATA:
>  				status = i2c_smbus_write_byte_data(client,
> @@ -612,7 +640,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  			if (write_max > io_limit)
>  				write_max = io_limit;
>  			if (use_smbus && write_max > I2C_SMBUS_BLOCK_MAX)
> -				write_max = I2C_SMBUS_BLOCK_MAX;
> +				write_max = I2C_SMBUS_BLOCK_MAX >>
> +					!!(chip.flags & AT24_FLAG_ADDR16);

Looks bogus when AT24_FLAG_ADDR16 flag is set, in two ways:

1* I2C_SMBUS_BLOCK_MAX is 32. If write_max was 33, you'll set it to
   33 >> 1 = 16. But if write_max was 31, you'll leave it to 31. Makes
   no sense to me.

2* Why I2C_SMBUS_BLOCK_MAX >> 1 in the first place? You only need to
   steal one byte from the data buffer for the extra address byte, so
   I'd expect write_max to be capped at I2C_SMBUS_BLOCK_MAX - 1.

>  			at24->write_max = write_max;
>  
>  			/* buffer (data + address at the beginning) */

The code you added will never be executed anyway, because of this test
in at24_probe():

	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
		if (chip.flags & AT24_FLAG_ADDR16)
			return -EPFNOSUPPORT;


-- 
Jean Delvare
SUSE L3 Support
