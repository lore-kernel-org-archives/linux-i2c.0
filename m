From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/6] Small corrections to lp552x led drivers
Date: Thu, 11 Nov 2010 10:21:49 +0200
Message-ID: <1289463715-12507-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Some macros changed to inline function. There is only 
one container_of it those functions.

Sleep times adjusted to shorter ones. Data sheet gives
some absolute minimum times but selected times contains
some margin to add overall robustness. Comments
added to sleep times.

Chips don't have HW reset line. If the chip is connected
to always on power rail, there is no power on ramp either
at system restart. It is possible that the chip is in some
odd state at restart and the detection may fail.
SW reset command is now send before detection to set chip
to known state for the detection.

Patches are done to top my lp5523 and lp5521 driver patches
which are waiting to go in.

Samu Onkalo (6):
  leds: lp5521: Change some macros to functions
  leds: lp5523: Change some macros to functions
  leds: lp5521: Adjust delays and add comments to them
  leds: lp5523: Adjust delays and add comments to them
  leds: lp5521: Perform SW reset before detection
  leds: lp5523: Perform SW reset before detection

 drivers/leds/leds-lp5521.c |   50 +++++++++++++++++++++++++++++---------------
 drivers/leds/leds-lp5523.c |   44 +++++++++++++++++++++-----------------
 2 files changed, 57 insertions(+), 37 deletions(-)
