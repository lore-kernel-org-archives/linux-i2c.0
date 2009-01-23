From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Implementing a new driver
Date: Fri, 23 Jan 2009 21:25:06 +0100
Message-ID: <20090123212506.7997e4ee@hyperion.delvare>
References: <49798DAD.1070100@manoweb.com>
	<20090123103909.281770dd@hyperion.delvare>
	<4979FEF2.1090006@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4979FEF2.1090006-+h0hele9I7BBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alessio Sangalli <alesan-+h0hele9I7BBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Alessio,

On Fri, 23 Jan 2009 09:31:30 -0800, Alessio Sangalli wrote:
> Jean Delvare wrote:
> 
> > As a quick starting point I recommend this FAQ item:
> > http://i2c.wiki.kernel.org/index.php/Linux_2.6_I2C_development_FAQ#New_I2C_bus_drivers
> 
> Thanks, this will be useful to get started; anyway, it implies a
> knowledge of what is a "bus driver" or a "chip driver". I've read other
> articles but I'm still a bit confused. Could you give me a very very
> quick description of all kind of i2c-related drivers?

Basically, the bus drivers give you access to the I2C bus, while the
chip drivers are specific to devices which are connected to the bus.
This is essentially similar to USB, where you need a driver for the
host controller, and then a driver for devices connected to the USB
ports.

You may want to read this page on the wiki:
http://i2c.wiki.kernel.org/index.php/Driver_Architecture
and the document linked at the bottom of the page.

Examples of I2C bus drivers can be found under drivers/i2c/busses.
Examples of I2C chip drivers can be found under drivers/rtc (for RTC
chips), drivers/hwmon (for hardware monitoring chips) or drivers/gpio
(for I/O expanders.)

> What is the preferred way to actually test the driver, I am quite
> comfortable with a solder iron if I have to connect a simple device to
> try a connection

If you have an AT24C02 EEPROM at hand or similar, you'll be able to
test most of the transaction types. But actually, any I2C or SMBus chip
you can connect to the bus should be good enough to test the basics of
your i2c bus driver.

-- 
Jean Delvare
