From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: [RFC 0/2] Request for help: Intel iMC (SNB Xeon) SMBUS driver
Date: Mon,  1 Jul 2013 16:30:06 -0700
Message-ID: <cover.1372720609.git.luto@amacapital.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rui Wang <rui.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Chen Gong <gong.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This adds support for the Intel iMC SMBUS controller.  It has some issues:

 - I haven't implemented bus/controller reset.  It's not entirely clear
   when a reset is appropriate.

 - This thing should really enumerate attached TSODs, but I'm not
   personally inclined to write a TSOD driver.

 - Ideally, the driver would encode enough information about the devices
   hanging off the bus that they could be automatically correlated with
   EDAC / DMI data.  I don't know how the I2C subsystem is supposed to
   handle this kind of use, though.

 - Writes are untested.  I don't currently have anything writable to
   test.

 - I'm not sure how the polling loops should work.  Any advice?  This
   device has no interrupt.

 - More importantly: It works fine on my Core i7 Extreme box, but it
   occasionally (1% of the time?) screws up on my E5-2690.  The error
   manifests itself as an incorrect byte read from the SPD that seems to
   take on one of two values that depend on the address being read.
   Adding a few ms delay after claiming the bus makes no difference.
   Telling the hardware that there are no TSODs attached does nothing
   either, and the error does not seem to line up with any particular
   value of the poll countdown.  Any Intel people or people with more
   experience have any ideas?

Amazingly, both of my machines with an iMC controller have writes enabled.
That might be because the write disable interface is sufficiently awkward
that BIOS doesn't bother.  Writing is tested and works (and now one of my
DIMMs' SPDs has burned through a few write cycles).

Andy Lutomirski (2):
  i2c: Allow SPD probing with READ_BYTE_DATA and improve logging
  i2c_imc: New driver for Intel's iMC, found on LGA2011 chips

 drivers/i2c/busses/Kconfig   |  14 ++
 drivers/i2c/busses/Makefile  |   1 +
 drivers/i2c/busses/i2c-imc.c | 462 +++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c       |   7 +-
 4 files changed, 483 insertions(+), 1 deletion(-)
 create mode 100644 drivers/i2c/busses/i2c-imc.c

-- 
1.8.1.4
