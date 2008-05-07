From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80,
Date: Wed, 7 May 2008 01:20:03 -0700
Message-ID: <200805070120.03821.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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
To: "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch is way too big for what it does.  Lots of whitespace
and similar noise (did those headers *need* rearranging?).


But most importantly, that driver already uses SMBus calls.
So you shouldn't *stop* it from using them by adding wrapper
code like this:

> +static int m41t80_write_byte_data(struct i2c_client *client, u8 reg, u8 val)
> +{ 
> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return m41t80_i2c_transfer(client, 1, reg, 1, &val);
> +	else
> +		return i2c_smbus_write_byte_data(client, reg, val);
> +}

That's because if an I2C controller can execute that protocol,
it can do so through the SMBus calls too.  And the current code
already verifies that will work ... those wrappers are pointless,
as well as untested.


The chip docs basically tell us that if the underlying SMBus
controller can issue i2c_smbus_read_i2c_block_data() and its
write-side sibling, it can *easily* talk to this chip.

So wouldn't it be a better idea to just replace the existing
calls to i2c_transfer() with those pseudo-SMBus block calls?

And then *separately* add workarounds for i2c-sibyte, and
similar controllers that don't offer block transfers?  Maybe
using your existing structure ... just not replacing those
existing perfectly-fine SMBus calls.

- Dave



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
