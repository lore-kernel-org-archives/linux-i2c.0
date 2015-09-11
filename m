From: Pavel Roskin <plroskin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fix for Dell P57G touchpad found, need advice on patch
Date: Thu, 10 Sep 2015 23:11:41 -0700
Message-ID: <CAN_72e1BBk_s1BRBHJYuA7+2nbfYf1bCoD9fqatmTxRM_w=myg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi!

I'm using Dell Inspiron 13, model P57G. It has a problem with the
touchpad under Linux. Approximately half of the time, the touchpad is
not working at all - the mouse cursor is not moving. In this case,
there are error messages written to the kernel log every second:

[   53.127339] i2c_designware INT3433:00: controller timed out
[   54.219336] i2c_designware INT3433:00: controller timed out
[   55.311346] i2c_designware INT3433:00: controller timed out
[   56.403326] i2c_designware INT3433:00: controller timed out

There is a simple fix - blacklist the driver
(i2c_designware_platform). In this case, the touchpad words as a mouse
and used IRQ 12. Googling for "blackist i2c_designware_platform" shows
that I'm not the one using that approach.

I started looking at the driver in git. A patch by Romain Baeriswyl
applied on 2014-08-20 adds support for the "standard" mode with the
100kHz clock, as opposed to the 400kHz "fast" mode. Unfortunately,
that patch only affects OpenFirmware systems, and I have ACPI. As soon
as I set the clock to 100kHz, the touchpad started working every time.

One fix would be to have a module parameter to force slower clock. It
would still require users to deal with modprobe, so it's not optimal.

I noticed that dev->get_clk_rate_khz(dev) returns 100000, but that
would be 100000kHz = 100MHz. Not sure is somebody confused the units
or it's the correct clock.

Considering that I have no other systems to test, what would be the
best approach? Set the clock to 100kHz for INT3433? Recognize Dell
P57G system specifically? How? Preserve the original clock by reading
the DW_IC_CON register and keeping some bits?

Pavel
