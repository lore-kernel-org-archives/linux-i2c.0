From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 0/2] i2c_imc: New driver, at long last
Date: Fri,  6 Mar 2015 18:50:52 -0800
Message-ID: <cover.1425695891.git.luto@amacapital.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>, Rui Wang <ruiv.wang@gmail.com>, Tony Luck <tony.luck@intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alun Evans <alun@badgerous.net>, Robert Elliott <Elliott@hp.com>, Boaz Harrosh <boaz@plexistor.com>, Andy Lutomirski <luto@amacapital.net>
List-Id: linux-i2c@vger.kernel.org

This adds i2c_imc, a driver for the SMBUS lines on DIMM slots on modern
Intel server chips.  Conceptually, I like it a lot -- it's a driver for
a bus for which we know the exact topology a priori.  That means that we
can actually enumerate the things on the bus reasonably cleanly.

This driver is weird, but I don't think that merging it will cause
problems, and I believe that there are Real Users (tm) of this driver.

It has two caveats.

Big caveat: Lots of things like to touch this bus, such as a BMC, the
memory controller power management stuff, and maybe even SMM code.
Intel forgot to define a way to arbitrate between them, nor are the
SMBUS master regs designed to be poked by multiple things at once.  The
upshot is that loading this driver is generally unsafe.  The driver
takes some measures to detect contention for the registers and shut
itself down, but no one should rely on that.

My understanding is that there's work in ACPI land to define an
arbitration mechanism.  Once this happens, we can support it in this
driver.  In the mean time, this driver has actual users, and there are
motherboards specifically designed to be used with a driver like this.
(I have such a board, and you can even buy them on regular online
shopping sutes.)

Therefore, I added a module parameter called allow_unsafe_access.  If
unset, the driver will refuse to load with an informative message.  If
set, the driver will pr_warn and load.

Little caveat: This submission only supposts Sandy Bridge.  I'd rather
get it merged without Ivy Bridge and Haswell support and add them later
(should be easy) rather than trying to make the driver support all
possible hardware before merging it.

Changes: This is an updated resubmission after about a year of thumb
twiddling.

Andy Lutomirski (2):
  i2c_imc: New driver for Intel's iMC, found on LGA2011 chips
  i2c, i2c_imc: Add DIMM bus code

 drivers/i2c/busses/Kconfig    |  22 ++
 drivers/i2c/busses/Makefile   |   5 +
 drivers/i2c/busses/dimm-bus.c |  97 +++++++
 drivers/i2c/busses/i2c-imc.c  | 586 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/dimm-bus.h  |  24 ++
 5 files changed, 734 insertions(+)
 create mode 100644 drivers/i2c/busses/dimm-bus.c
 create mode 100644 drivers/i2c/busses/i2c-imc.c
 create mode 100644 include/linux/i2c/dimm-bus.h

-- 
2.1.0
