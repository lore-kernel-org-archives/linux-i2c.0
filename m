From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c-nomadik: support smbus emulation
Date: Fri, 24 Sep 2010 12:47:15 +0900
Message-ID: <4C9C1F43.4080105@renesas.com>
References: <1285225443-1036-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285225443-1036-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 9/23/2010 4:04 PM, Linus Walleij wrote:
> We can do smbus emulation so flag this and drop the duplicate
> flags implied from smbus emulation.

> @@ -803,10 +803,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
>  
>  static unsigned int nmk_i2c_functionality(struct i2c_adapter *adap)
>  {
> -	return I2C_FUNC_I2C
> -		| I2C_FUNC_SMBUS_BYTE_DATA
> -		| I2C_FUNC_SMBUS_WORD_DATA
> -		| I2C_FUNC_SMBUS_I2C_BLOCK;
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>  }
>  
>  static const struct i2c_algorithm nmk_i2c_algo = {

(failed to figure out from the driver, so would like to make sure)
Is this I2C core capable of I2C_FUNC_SMBUS_QUICK?  Unless it's capable
of full SMBus emulation, it would be better to turn off relevant flags
for safety.  I'm not objecting to the patch, but just wondered.
-- 
Shinya Kuribayashi
Renesas Electronics
