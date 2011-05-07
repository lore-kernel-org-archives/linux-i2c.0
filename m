From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: How to use one I2C device from two modules?
Date: Sat, 7 May 2011 15:28:32 +0200
Message-ID: <20110507152832.25276ac6@endymion.delvare>
References: <842687.69100.qm@web30208.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <842687.69100.qm-sMamaaD5nQOvuULXzWHTWIglqE1Y4D90QQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars Michael <lh_post-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lars,

On Fri, 6 May 2011 04:30:33 -0700 (PDT), Lars Michael wrote:
> On our custom board we have an I2C GPIO port expander. This is used for different things like power supply control and button control. Hence I wrote two modules; pscontrol and button. 
> 
> In the modules I use i2c_new_device to create the device and to get the i2c_client struct that I later use in the smbus calls. This works fine, one module at the time. Together the last insmod fails, because the device at that address is already created.
> 
> But how do I access the same I2C device from several modules? Ideally I want to specify the adapter and slave address. If a client is found, I get the i2c_client otherwise I have to create it by i2c_new_device (or probe it). Is it possible?
> 
> Since I know the I2C bus and slave addresses in advance, would it be better to predeclare them by i2c_register_board_info? And in that case, how do I get the i2c_client struct in the module?

In general I would have pointed you to drivers/mfd and told you to
write a mfd core driver for your chip. However in your case I don't
think you have a multifunction device. You have a single function
device (GPIO) with multiple users. So I suggest that you simply write a
proper gpio driver for your chip, and get the device registered as an
I2C GPIO device. Then, in your function drivers (power supply control
and button control) get a reference to the gpio device in question, and
use it.

FWIW, we already have support for many I2C-based GPIO chip families.
Take a look in drivers/gpio, files adp5588-gpio.c, max7300.c,
max732x.c, pca953x.c, pcf857x.c and sx150x.c. With some luck, your chip
is already supported, so all you have to do is instantiate it in your
platform code.

-- 
Jean Delvare
