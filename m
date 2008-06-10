From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v3] New-style I2C and SMBus EEPROM driver (with
	device_ids)
Date: Tue, 10 Jun 2008 14:02:44 -0700
Message-ID: <200806101402.44392.david-b@pacbell.net>
References: <20080605193103.GA13062@pengutronix.de>
	<20080608115033.5dd91786@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080608115033.5dd91786-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sunday 08 June 2008, Jean Delvare wrote:
> You need to include <linux/bitops.h> for BIT().

That's handled by <linux/kernel.h> ... I rather think it's OK
to rely on a few basics like that.


> You're going to quite some extent to obfuscate simple things ;) All
> these defines are for the sole internal purpose of the at24 driver
> (custom eeprom types would use platform data instead) and should
> not be in the public header file... if they should defined at all.

The original notion was to get the driver out of the business of
holding a large table of device parameters including worst-case
pagesizes (e.g. Microchip pages being half or a quarter the size
of Atmel pages) and address consumption (e.g. Atmel 24c01 vs 24c01a,
or the SOT23 versions doing who-knows-undocumented-what).

So I think those #defines are somewhat a legacy of having had to
change direction mid-steam to cope with the new "i2c_device_id"
and its expectation that drivers *would* have such large tables
with worst-case parameters.

Just so you know.  :)

- Dave
 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
