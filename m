From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] Short timeout for I2C transfers
Date: Wed, 13 Oct 2010 16:45:08 +0300
Message-ID: <1286977510-16702-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

There are chips which doesn't work perfectly in certain
I2C operations. For example lp5523 led driver chip causes
always I2C timeout when SW reset is commanded to the chip.

Patches add a possibility to tell that this access is likely
to cause time out and there is no need to wait normal time.
For example in omap time out is 1 second and the bus is reserved
all the time.
By setting I2C_M_SHORT_TIMEOUT flag to i2c-message, adapter is
requested to use shorter timeout.

Samu Onkalo (2):
  drivers: i2c-core: Add a flag to allow short timeout
  drivers: i2c-omap: Add support for shorten I2C timeout

 drivers/i2c/busses/i2c-omap.c |    9 ++++++++-
 drivers/i2c/i2c-core.c        |    2 +-
 include/linux/i2c.h           |    1 +
 3 files changed, 10 insertions(+), 2 deletions(-)
