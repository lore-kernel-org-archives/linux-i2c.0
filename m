From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: [PATCH v2 0/2] i2c_imc: New driver, at long last
Date: Mon,  9 Mar 2015 13:55:24 -0700
Message-ID: <cover.1425934386.git.luto@amacapital.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Alun Evans <alun-eX+YDEU5biwsV2N9l4h3zg@public.gmane.org>, Robert Elliott <Elliott-VXdhtT5mjnY@public.gmane.org>, Boaz Harrosh <boaz-/8YdC2HfS5554TAoqtyWWQ@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
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

Changes from last year:
 - This is an updated resubmission after about a year of thumb
   twiddling.

Andy Lutomirski (2):
  i2c_imc: New driver for Intel's iMC, found on LGA2011 chips
  i2c, i2c_imc: Add DIMM bus code

 drivers/i2c/busses/Kconfig    |  22 ++
 drivers/i2c/busses/Makefile   |   5 +
 drivers/i2c/busses/dimm-bus.c | 107 ++++++++
 drivers/i2c/busses/i2c-imc.c  | 570 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/dimm-bus.h  |  20 ++
 5 files changed, 724 insertions(+)
 create mode 100644 drivers/i2c/busses/dimm-bus.c
 create mode 100644 drivers/i2c/busses/i2c-imc.c
 create mode 100644 include/linux/i2c/dimm-bus.h

-- 
2.3.0
