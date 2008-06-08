From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3] New-style I2C and SMBus EEPROM driver (with
 device_ids)
Date: Sun, 8 Jun 2008 11:53:11 +0200
Message-ID: <20080608115311.30b27448@hyperion.delvare>
References: <20080605193103.GA13062@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080605193103.GA13062-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

And some more nit-picking for the road...

On Thu, 5 Jun 2008 21:31:03 +0200, Wolfram Sang wrote:
> --- /dev/null
> +++ linux-2.6.26-rc4/include/linux/i2c/at24.h
> @@ -0,0 +1,104 @@
> (...)
> + * If you set up a custom eeprom type, please make sure you
> + * have double-checked the parameters. Especially page_size needs extra care,

"Make sure" and "double-checked" are somewhat redundant.

> + * as you risk data loss if your value is bigger than what the chip actually
> + * supports! A typical custom type declaration would look similar to this:
> + *
> + *	struct const at24_platform_data my_eeprom_data {

const struct, in this order.

> + *		AT24_PLATFORM_DATA(byte_len, page_size, flags);
> + *	};

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
