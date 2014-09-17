From: Corey Minyard <cminyard-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: I2c modifications for IPMI operations at panic time
Date: Tue, 16 Sep 2014 19:30:27 -0500
Message-ID: <5418D623.5010803@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I've been carrying along modifications to the I2C subsystem to allow an
IPMI interface over SMBus (per the IPMI standard).  I have these
modification because the IPMI driver has functions that it performs at
panic/shutdown time, like handling poiwer, extending the watchdog on a
panic, and storing panic information in the IPMI event log.

I haven't really cared much about the SMBus IPMI driver because very few
systems have one of these.  I've been keeping it up to date and testing
it periodically, but that's about it.  However, it looks like more
systems are going to be using this interface, so I need to do something.

The changes I have are fairly large, but they mainly move code around to
allow the I2C core to be event driven or polled without duplicating a
lot of code.  They create an event-driven interface on top of and
underneath the driver.  You can use the polled interface into the top of
the driver and talk to a polled or event-driven driver, the I2C core
takes care of the translation from a polled user to an event-driven
driver.  You have to have an event-driven driver to use the event-driven
interface.

The code is in git://git.code.sf.net/p/openipmi/linux-ipmi
openipmi-linux-ipmi in the ipmi-i2c branch.  It needs a little work at
this point, but nothing big.  It has modifications to the i801 and piix4
drivers to make them event-driven, too.

Would such changes be acceptable?  I"m not sure anything else has a use
for this.  Maybe a driver to store panic information in an I2C EEPROM,
or anything that would need to get to I2C at panic time.

I'd prefer to have the full function of the IPMI driver, of course, and
I need to do something to the I2C code to get this.  I've debated
different ways, but I haven't come up with anything better.

I could also give up those functions and implement over the I2C driver
as is.  I'm just looking for the best way to go now.

Thanks,

-corey
