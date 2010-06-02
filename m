From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Subject: Re: Registering I2C devices on X86
Date: Wed, 02 Jun 2010 13:29:36 +0200
Message-ID: <4C0640A0.9070103@pelagicore.com>
References: <4C062E70.3090409@pelagicore.com>	<20100602103650.GA4876@pengutronix.de> <20100602130408.1e732a0a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100602130408.1e732a0a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Thanks for quick feedback!

On 06/02/2010 01:04 PM, Jean Delvare wrote:
> On Wed, 2 Jun 2010 12:36:50 +0200, Wolfram Sang wrote:
>>> Any ideas or suggestions?
>>
>> Do it in userspace, or is this too late?
>
> The user-space interface only works for simple cases: you can't pass
> platform data or irq numbers. If someone needs to do this, we need an
> extended interface, probably using configfs.

Yeah I think it's a common case to provide platform data and interrupt numbers. At least I see the 
need for it on our platforms.

>
>> Documentation/i2c/instantiating-devices lists all options you have.
>
> Richard, look at drivers/i2c/busses/i2c-i801.c, function i801_probe():
> you'll see an example of per-platform I2C device instantiation on x86.
> I'm not claiming it is elegant, but it works.

The "problem" I see is that the CPU and the chipset + I2C chip will be populated on several 
different boards. It would mean that the I2C bus driver would need knowledge of all the boards where 
it is used. And the bus driver itself can not really detect which board it's running on.

That is why I kept the I2C device setup in a separate driver. So each board would have a separate 
"setup" driver. Isn't that the most clean solution right now?

Thanks
--Richard
