From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2.6.26.5] rtc-ds1307 : SMBus compatibility
Date: Mon, 13 Oct 2008 17:32:06 +0200
Message-ID: <20081013173206.6b7a5e1e@hyperion.delvare>
References: <C1C62166118DFA4A8BBA01A2411F0D170E9BE59E27@PRI-MBX-101.dom1.vinci-energies.net>
	<20081010133344.653431af@hyperion.delvare>
	<C1C62166118DFA4A8BBA01A2411F0D170E9BE5A032@PRI-MBX-101.dom1.vinci-energies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <C1C62166118DFA4A8BBA01A2411F0D170E9BE5A032-iGzfJtNnmHkUlixSki3fykIJAyBIbWHDnAJcWxkt5PDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: BARRE Sebastien <sbarre-6lXSvc0s5hDQT0dZR+AlfA@public.gmane.org>
Cc: frederic Rodo <f.rodo-6YL8BHNr0ZqHdZQakrT3ElaPQRlvutdw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sebastien,

On Fri, 10 Oct 2008 15:46:11 +0200, BARRE Sebastien wrote:
> Thanks for your advices.
> Fixed patch is in attachement to avoid tabs replacement.
> Other comments are welcome.

Note: you need to include a comment describing what your patch does, as
well as your Signed-off-by line. Here's a second review from me. After
that it will be up to Alessandro and the RTC folks.

> --- a/drivers/rtc/rtc-ds1307.c	2008-09-08 19:40:20.000000000 +0200
> +++ b/drivers/rtc/rtc-ds1307.c	2008-10-10 16:30:59.000000000 +0200
> @@ -17,8 +17,6 @@
>  #include <linux/rtc.h>
>  #include <linux/bcd.h>
>  
> -
> -

Unrelated white space change, please revert.

>  /* We can't determine type by probing, but if we expect pre-Linux code
>   * to have set the chip up as a clock (turning on the oscillator and
>   * setting the date and time), Linux can ignore the non-clock features.
> @@ -38,7 +36,6 @@ enum ds_type {
>  	// rs5c372 too?  different address...
>  };
>  
> -

Unrelated white space change, please revert.

>  /* RTC registers don't differ much, except for the century flag */
>  #define DS1307_REG_SECS		0x00	/* 00-59 */
>  #	define DS1307_BIT_CH		0x80
> @@ -85,14 +82,11 @@ enum ds_type {
>  #	define DS1337_BIT_A1I		0x01
>  #define DS1339_REG_TRICKLE	0x10
>  
> -
> -

Unrelated white space change, please revert.

>  struct ds1307 {
>  	u8			reg_addr;

reg_addr is unused after your changes, so you should remove it as well.

>  	bool			has_nvram;
>  	u8			regs[8];
>  	enum ds_type		type;
> -	struct i2c_msg		msg[2];
>  	struct i2c_client	*client;
>  	struct i2c_client	dev;
>  	struct rtc_device	*rtc;
> @@ -138,12 +132,9 @@ static int ds1307_get_time(struct device
>  	int		tmp;
>  
>  	/* read the RTC date and time registers all at once */
> -	ds1307->msg[1].flags = I2C_M_RD;
> -	ds1307->msg[1].len = 7;
> -
> -	tmp = i2c_transfer(to_i2c_adapter(ds1307->client->dev.parent),
> -			ds1307->msg, 2);
> -	if (tmp != 2) {
> +	tmp = i2c_smbus_read_i2c_block_data(ds1307->client,
> +			DS1307_REG_SECS, 7, ds1307->regs);
> +	if (tmp != 7) {
>  		dev_err(dev, "%s error %d\n", "read", tmp);
>  		return -EIO;
>  	}
> @@ -181,8 +172,6 @@ static int ds1307_set_time(struct device
>  {
>  	struct ds1307	*ds1307 = dev_get_drvdata(dev);
>  	int		result;
> -	int		tmp;
> -	u8		*buf = ds1307->regs;
>  
>  	dev_dbg(dev, "%s secs=%d, mins=%d, "
>  		"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
> @@ -190,44 +179,41 @@ static int ds1307_set_time(struct device
>  		t->tm_hour, t->tm_mday,
>  		t->tm_mon, t->tm_year, t->tm_wday);
>  
> -	*buf++ = 0;		/* first register addr */
> -	buf[DS1307_REG_SECS] = BIN2BCD(t->tm_sec);
> -	buf[DS1307_REG_MIN] = BIN2BCD(t->tm_min);
> -	buf[DS1307_REG_HOUR] = BIN2BCD(t->tm_hour);
> -	buf[DS1307_REG_WDAY] = BIN2BCD(t->tm_wday + 1);
> -	buf[DS1307_REG_MDAY] = BIN2BCD(t->tm_mday);
> -	buf[DS1307_REG_MONTH] = BIN2BCD(t->tm_mon + 1);
> +	ds1307->regs[DS1307_REG_SECS] = BIN2BCD(t->tm_sec);
> +	ds1307->regs[DS1307_REG_MIN] = BIN2BCD(t->tm_min);
> +	ds1307->regs[DS1307_REG_HOUR] = BIN2BCD(t->tm_hour);
> +	ds1307->regs[DS1307_REG_WDAY] = BIN2BCD(t->tm_wday + 1);
> +	ds1307->regs[DS1307_REG_MDAY] = BIN2BCD(t->tm_mday);
> +	ds1307->regs[DS1307_REG_MONTH] = BIN2BCD(t->tm_mon + 1);

This change makes the patch larger (and thus harder to review) with
almost no benefit. Same for many changes below... Why don't you keep
the buf pointer? Please keep in mind that your patch should do just one
thing and do it well.

>  
>  	/* assume 20YY not 19YY */
> -	tmp = t->tm_year - 100;
> -	buf[DS1307_REG_YEAR] = BIN2BCD(tmp);
> +	ds1307->regs[DS1307_REG_YEAR] = BIN2BCD(t->tm_year - 100);
>  
>  	switch (ds1307->type) {
>  	case ds_1337:
>  	case ds_1339:
> -		buf[DS1307_REG_MONTH] |= DS1337_BIT_CENTURY;
> +		ds1307->regs[DS1307_REG_MONTH] |= DS1337_BIT_CENTURY;
>  		break;
>  	case ds_1340:
> -		buf[DS1307_REG_HOUR] |= DS1340_BIT_CENTURY_EN
> -				| DS1340_BIT_CENTURY;
> +		ds1307->regs[DS1307_REG_HOUR] |= DS1340_BIT_CENTURY_EN
> +						| DS1340_BIT_CENTURY;
>  		break;
>  	default:
>  		break;
>  	}
>  
> -	ds1307->msg[1].flags = 0;
> -	ds1307->msg[1].len = 8;
> -
>  	dev_dbg(dev, "%s: %02x %02x %02x %02x %02x %02x %02x\n",
> -		"write", buf[0], buf[1], buf[2], buf[3],
> -		buf[4], buf[5], buf[6]);
> -
> -	result = i2c_transfer(to_i2c_adapter(ds1307->client->dev.parent),
> -			&ds1307->msg[1], 1);
> -	if (result != 1) {
> -		dev_err(dev, "%s error %d\n", "write", tmp);
> -		return -EIO;
> +		"write", ds1307->regs[0], ds1307->regs[1],
> +		ds1307->regs[2], ds1307->regs[3],
> +		ds1307->regs[4], ds1307->regs[5], ds1307->regs[6]);
> +
> +	result = i2c_smbus_write_i2c_block_data(ds1307->client,
> +			0, 7, ds1307->regs);
> +	if (result < 0) {
> +		dev_err(dev, "%s error %d\n", "write", result);
> +		return result;
>  	}
> +
>  	return 0;
>  }
>  
> @@ -246,7 +232,6 @@ ds1307_nvram_read(struct kobject *kobj, 
>  {
>  	struct i2c_client	*client;
>  	struct ds1307		*ds1307;
> -	struct i2c_msg		msg[2];
>  	int			result;
>  
>  	client = kobj_to_i2c_client(kobj);
> @@ -259,24 +244,13 @@ ds1307_nvram_read(struct kobject *kobj, 
>  	if (unlikely(!count))
>  		return count;
>  
> -	msg[0].addr = client->addr;
> -	msg[0].flags = 0;
> -	msg[0].len = 1;
> -	msg[0].buf = buf;
> -
> -	buf[0] = 8 + off;
> -
> -	msg[1].addr = client->addr;
> -	msg[1].flags = I2C_M_RD;
> -	msg[1].len = count;
> -	msg[1].buf = buf;
> -
> -	result = i2c_transfer(to_i2c_adapter(client->dev.parent), msg, 2);
> -	if (result != 2) {
> -		dev_err(&client->dev, "%s error %d\n", "nvram read", result);
> -		return -EIO;
> +	result = i2c_smbus_read_i2c_block_data(client, 8 + off, count, buf);
> +	if (result < 0) {
> +		dev_err(&client->dev, "%s error %d\n", "read", result);

Why did you change this error message for a less specific one?

> +		return result;
>  	}
> -	return count;
> +
> +	return result;
>  }

Note that "return result" can be factored out.

>  
>  static ssize_t
> @@ -284,8 +258,7 @@ ds1307_nvram_write(struct kobject *kobj,
>  		char *buf, loff_t off, size_t count)
>  {
>  	struct i2c_client	*client;
> -	u8			buffer[NVRAM_SIZE + 1];
> -	int			ret;
> +	int			result;
>  
>  	client = kobj_to_i2c_client(kobj);
>  
> @@ -296,11 +269,12 @@ ds1307_nvram_write(struct kobject *kobj,
>  	if (unlikely(!count))
>  		return count;
>  
> -	buffer[0] = 8 + off;
> -	memcpy(buffer + 1, buf, count);
> -
> -	ret = i2c_master_send(client, buffer, count + 1);
> -	return (ret < 0) ? ret : (ret - 1);
> +	result = i2c_smbus_write_i2c_block_data(client, 8 + off, count, buf);
> +	if (result < 0) {
> +		dev_err(&client->dev, "%s error %d\n", "write", result);

I'd use "nvram write" in the error message.

> +		return result;
> +	}
> +	return count;
>  }
>  
>  static struct bin_attribute nvram = {
> @@ -325,11 +299,14 @@ static int __devinit ds1307_probe(struct
>  	struct ds1307		*ds1307;
>  	int			err = -ENODEV;
>  	int			tmp;
> +	u8			*buf;
> +
>  	const struct chip_desc	*chip = &chips[id->driver_data];
>  	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
>  
>  	if (!i2c_check_functionality(adapter,
> -			I2C_FUNC_I2C | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
> +			I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +			I2C_FUNC_SMBUS_I2C_BLOCK))
>  		return -EIO;
>  
>  	if (!(ds1307 = kzalloc(sizeof(struct ds1307), GFP_KERNEL)))
> @@ -338,35 +315,21 @@ static int __devinit ds1307_probe(struct
>  	ds1307->client = client;
>  	i2c_set_clientdata(client, ds1307);
>  
> -	ds1307->msg[0].addr = client->addr;
> -	ds1307->msg[0].flags = 0;
> -	ds1307->msg[0].len = 1;
> -	ds1307->msg[0].buf = &ds1307->reg_addr;
> -
> -	ds1307->msg[1].addr = client->addr;
> -	ds1307->msg[1].flags = I2C_M_RD;
> -	ds1307->msg[1].len = sizeof(ds1307->regs);
> -	ds1307->msg[1].buf = ds1307->regs;
> -
>  	ds1307->type = id->driver_data;
>  
>  	switch (ds1307->type) {
>  	case ds_1337:
>  	case ds_1339:
> -		ds1307->reg_addr = DS1337_REG_CONTROL;
> -		ds1307->msg[1].len = 2;
> -
> +		buf = &ds1307->regs[DS1337_REG_CONTROL];
>  		/* get registers that the "rtc" read below won't read... */
> -		tmp = i2c_transfer(adapter, ds1307->msg, 2);
> +		tmp = i2c_smbus_read_i2c_block_data(ds1307->client,
> +				DS1337_REG_CONTROL, 2, buf);
>  		if (tmp != 2) {
>  			pr_debug("read error %d\n", tmp);
>  			err = -EIO;
>  			goto exit_free;
>  		}
>  
> -		ds1307->reg_addr = 0;
> -		ds1307->msg[1].len = sizeof(ds1307->regs);
> -
>  		/* oscillator off?  turn it on, so clock can tick. */
>  		if (ds1307->regs[0] & DS1337_BIT_nEOSC)
>  			i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL,
> @@ -385,9 +348,9 @@ static int __devinit ds1307_probe(struct
>  
>  read_rtc:
>  	/* read RTC registers */
> -
> -	tmp = i2c_transfer(adapter, ds1307->msg, 2);
> -	if (tmp != 2) {
> +	buf = ds1307->regs;
> +	tmp = i2c_smbus_read_i2c_block_data(ds1307->client, 0, 8, buf);
> +	if (tmp != 8) {
>  		pr_debug("read error %d\n", tmp);
>  		err = -EIO;
>  		goto exit_free;
> @@ -430,7 +393,7 @@ read_rtc:
>  		tmp = i2c_smbus_read_byte_data(client, DS1340_REG_FLAG);
>  		if (tmp < 0) {
>  			pr_debug("read error %d\n", tmp);
> -			err = -EIO;
> +			err = tmp;
>  			goto exit_free;
>  		}
>  
> 

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
