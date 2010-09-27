From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c-nomadik: support smbus emulation
Date: Mon, 27 Sep 2010 18:09:42 +0900
Message-ID: <4CA05F56.9090803@renesas.com>
References: <1285225443-1036-1-git-send-email-linus.walleij@stericsson.com>	<4C9C1F43.4080105@renesas.com> <AANLkTimUWdKcMAA_1TrXNL4YDYJ7dUhVh9LLYQ_48NLh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimUWdKcMAA_1TrXNL4YDYJ7dUhVh9LLYQ_48NLh-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 9/27/2010 6:00 PM, Linus Walleij wrote:
> 2010/9/24 Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>:
>> On 9/23/2010 4:04 PM, Linus Walleij wrote:
>> Is this I2C core capable of I2C_FUNC_SMBUS_QUICK?  Unless it's capable
>> of full SMBus emulation, it would be better to turn off relevant flags
>> for safety.  I'm not objecting to the patch, but just wondered.
> 
> I have verified with the hardware engineer that this block is indeed
> capable of SMBUS_QUICK.

That's a nice block, no problem.
-- 
Shinya Kuribayashi
Renesas Electronics
