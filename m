From: Corey Minyard <cminyard-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Non-blocking driver interface for I2C
Date: Fri, 28 Mar 2014 14:45:06 -0500
Message-ID: <5335D142.3030607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiandi An <anjiandi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I have been maintaining, for quite some time, changes to the I2C driver
that allow a non-blocking interface if the lower level driver supports
it.  Basically, it allows the user of the I2C driver to send a message
and have the send call immediately return.  The I2C driver calls a
callback to return the response.  And (what I really care about) the
driver can be polled and work after a panic occurs.

I care about this because the IPMI driver has a few functions that are
designed to work after a panic.  Things like storing panic information
in the IPMI event log.  To support those on SMBus, I need some way to
poll the interface when the system can't schedule.

The changes aren't small, over 1000 lines of patch for the core driver. 
Around 900 lines of patch for the i801 driver.  The existing lower level
drivers and user interface work, so no change to anything else is
required unless some user needs a non-blocking interface on a system.

Another option I originally considered was having some way of using the
current interface and having not sleep if a panic occurs.  Use udelay or
whatever.  That sounded risky to me, though.  If an operation was in
progress when the panic occurred, it would have to be aborted somehow,
and with what I've seen of I2C devices, that's taking a risk that they
will lock the bus.  So I didn't choose that path.  What I have will
finish the previous operation.

Before I post patches, is this something that the I2C maintainers would
consider?  It would only be for the IPMI driver for now, though perhaps
other uses might surface.  Like storing panic information in a EEPROM. 
I might even write a driver for that, it sounds useful.

Thanks,

-corey
