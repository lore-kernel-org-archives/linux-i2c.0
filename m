From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Fri, 11 Apr 2008 14:24:55 +0200
Message-ID: <ftnlao$o2r$1@ger.gmane.org>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1207914198-8561-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

I'll just review myself to ask for some comments where I think some more 
opinions would be good. I also tried to contact David Brownell as the 
original author directly last week, but all my mails got blocked; I hope 
we can negotiate through this list.

I tested this version of the driver on a blackfin based board with a 
24c02. In the next days, a powerpc based board with a X24645 (strange 
one) will follow. On x86 and x86-64, it builds without warnings.

> + * at24.c - handle most I2C EEPROMs
Maybe rename the driver? at24 is vendor-specific. 24xx? 24cxx? 
eeprom-ng? I'd go for 24xx.

> +/* One chip may consume up to this numbe of clients */
> +#define AT24_MAX_CLIENTS 8
> +
> +struct at24_data {
> +	struct at24_platform_data	chip;
> +	bool				use_smbus;
> +
> +	/* Lock protects against activities from other Linux tasks,
> +	 * but not from changes by other I2C masters.
> +	 */
> +	struct mutex		lock;
> +	struct bin_attribute	bin;
> +
> +	/* Some chips tie up multiple I2C addresses; dummy devices reserve
> +	 * them for ourselves, and we'll use them with SMBus calls.
> +	 */
> +	struct i2c_client	*client[AT24_MAX_CLIENTS];
> +
> +	u8			*writebuf;
> +	unsigned		write_max;
> +};
To support the X24645, it would be necessary to raise AT24_MAX_CLIENTS 
to 32 (what a beast!). Then again, most eeproms will just need one 
client, so this would cause quite some overhead in most use-cases. Maybe 
it pays off to hande this dynamically?

> +/*
> + * This routine supports chips which consume multiple I2C addresess.  It
> + * computes the addressing information to be used for a given r/w request.
> + */
> +static struct i2c_client *at24_ee_address(
> +	struct at24_data	*at24,
> +	u16			*addr,
> +	unsigned		*offset
> +)
> +{
> +	unsigned			per_address = 256;
> +	struct at24_platform_data	*chip = &at24->chip;
> +	unsigned			i;
> +
> +	if (*offset >= chip->byte_len)
> +		return NULL;
> +
> +	if (chip->flags & AT24_EE_ADDR2)
> +		per_address = 64 * 1024;
> +	*addr = at24->client[0]->addr;
> +	for (i = 0; *offset >= per_address; i++) {
> +		(*addr)++;
> +		*offset -= per_address;
> +	}
> +
> +	return at24->client[i];
> +}
I would suggest shortening it like this, unless I fail to see a drawback:

---

static struct i2c_client *at24_ee_address(
	struct at24_data	*at24,
	u16			*addr,
	unsigned		*offset
)
{
	const struct chip_desc	*chip = &at24->chip;
	unsigned		i;

	if (*offset >= chip->byte_len)
		return NULL;

	if (chip->flags & EE_ADDR2) {
		i = *offset >> 16;
		*offset &= 0xffff;
	} else {
		i = *offset >> 8;
		*offset &= 0x00ff;
	}

	*addr = at24->client[i]->addr;
	return at24->client[i];
}

---

This will save the for-loop and a variable.

> +	/* Export the EEPROM bytes through sysfs, since that's convenient.
> +	 * By default, only root should see the data (maybe passwords etc)
> +	 */
> +	at24->bin.attr.name = "eeprom";
> +	at24->bin.attr.mode = S_IRUSR;
> +	at24->bin.attr.owner = THIS_MODULE;
> +	at24->bin.read = at24_bin_read;
> +
> +	at24->bin.size = at24->chip.byte_len;
Use C99 initialization in struct at24_data above?

I guess, there is more to come during the discussion. But hopefully, 
this is a start to get it into 2.6.26... That would be great!

Kind regards,

    Wolfram

-- 
   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
