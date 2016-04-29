From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 0/2] i2c_imc: New driver, at long last
Date: Thu, 28 Apr 2016 18:03:23 -0700
Message-ID: <cover.1461891499.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Christoph Hellwig <hch@infradead.org>
Cc: Boaz Harrosh <boaz@plexistor.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rui Wang <ruiv.wang@gmail.com>, Jean Delvare <jdelvare@suse.de>, Alun Evans <alun@badgerous.net>, Robert Elliott <Elliott@hp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Paul Bolle <pebolle@tiscali.nl>, Tony Luck <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-i2c@vger.kernel.org

A few weeks ago, hch reminded me that there are lots of real live
production users of iMC's SMBUS.  They're currently using low-quality
userspace hacks or low-quality non-public kernels drivers.  Let's fix
that.

This adds i2c_imc, a driver for the SMBUS lines on DIMM slots on
modern Intel server chips.  Conceptually, I like it a lot -- it's a
driver for a bus for which we know the exact topology a priori.
That means that we can actually enumerate the things on the bus
reasonably cleanly.

This driver is a bit weird, but I don't think that merging it will
cause problems, and there are Real Users (tm) of this hardware on
Linux, many of whom would benefit from using a reasonably
high-quality in-tree driver over the various awful userspace hacks
that are floating around.

It has two caveats.

Big caveat: Lots of things like to touch this bus, such as a BMC,
the memory controller power management stuff, and maybe even SMM
code.  Intel forgot to define a way to arbitrate between them, nor
are the SMBUS master regs designed to be poked by multiple things at
once.  The upshot is that loading this driver is generally unsafe.
The driver takes some measures to detect contention for the
registers and shut itself down, but no one should rely on that.

My understanding is that there is or was work in ACPI land to define
an arbitration mechanism.  Once this happens, we can support it in
this driver.  In the mean time, this driver has actual users, and
there are motherboards specifically designed to be used with a
driver like this.  (I have such a board, and you can even buy them
on regular online shopping sutes.)

Therefore, I added a module parameter called allow_unsafe_access.  If
unset, the driver will refuse to load with an informative message.  If
set, the driver will pr_warn and load.

Little caveat: This submission only supposts Sandy Bridge.  I'd rather
get it merged without Ivy Bridge and Haswell support and add them later
(should be easy) rather than trying to make the driver support all
possible hardware before merging it.

Changes from v2:
 - Rebased and re-tested.

Changes from v1:
 - Fix checkpatch license nits.
 - Fix MODULE_LICENSE.
 - Add missing parentheses to macros.
 - Tidy up imc_wait_not_busy.
 - Clean up post-transaction-completion handling code.
 - Downgrade a bunch of message severities.
 - Misc checkpatch stuff.
 - Move select I2C_DIMM_BUS where it belongs.
 - Improve comments.

Changes from much earlier:
 - This was an updated resubmission after about a year of thumb
   twiddling.
   
Andy Lutomirski (2):
  i2c_imc: New driver for Intel's iMC, found on LGA2011 SNB chips
  i2c, i2c_imc: Add DIMM bus code

 drivers/i2c/busses/Kconfig    |  23 ++
 drivers/i2c/busses/Makefile   |   5 +
 drivers/i2c/busses/dimm-bus.c | 107 ++++++++
 drivers/i2c/busses/i2c-imc.c  | 570 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/dimm-bus.h  |  20 ++
 5 files changed, 725 insertions(+)
 create mode 100644 drivers/i2c/busses/dimm-bus.c
 create mode 100644 drivers/i2c/busses/i2c-imc.c
 create mode 100644 include/linux/i2c/dimm-bus.h

-- 
2.5.5
