From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: i2c bus multiplexing (Version 2).
Date: Thu,  5 Feb 2009 14:36:07 +0100
Message-ID: <1233840973-13268-1-git-send-email-giometti@linux.it>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch set adds to the I2C core the ability to handle multiplexed
I2C bus topologies by presenting each multiplexed segment as a I2C
adapter.

As you can see from the changelog I had to update i2c-core since when
a real adapter (not multiplexer) driver is inserted into the kernel
_after_ an i2c multiplxer one, function i2c_add_adapter() is called
recursively (and the same for i2c_del_adapter() during module removal)
causing a kernel hang due the i2c's "core_lock" mutex.

Changelog
=========

Version 1 -> 2:
---------------

* Fixes a bug related to recursive calls of i2c_(add|del)_adapter()
  functions when main adapter is inserted or removed _after_ slave
  adapetrs (i2c multiplexers).

  This goal has been achieved by:

  a) using rwsem instead of mutex for accessing board info data struct,

  b) ignoring any active client detaching faults (see relative patch for
     further info),

  c) removing "core_lock" mutex into adapters (de)registration code.

Rodolfo

--

 b/drivers/i2c/Kconfig         |   10 +
 b/drivers/i2c/Makefile        |    3 
 b/drivers/i2c/i2c-boardinfo.c |    6 
 b/drivers/i2c/i2c-core.c      |    4 
 b/drivers/i2c/i2c-core.h      |    2 
 b/drivers/i2c/i2c-mux.c       |  180 +++++++++++++++++++++++
 b/drivers/i2c/muxes/Kconfig   |    8 +
 b/drivers/i2c/muxes/Makefile  |    6
 b/drivers/i2c/muxes/pca954x.c |  325 ++++++++++++++++++++++++++++++++++++++++++
 b/include/linux/i2c-id.h      |    3
 b/include/linux/i2c.h         |   14 +
 b/include/linux/i2c/pca954x.h |   13 +
 drivers/i2c/i2c-core.c        |   78 ++++------
 drivers/i2c/muxes/Kconfig     |    9 +
 drivers/i2c/muxes/Makefile    |    2
 15 files changed, 615 insertions(+), 48 deletions(-)
