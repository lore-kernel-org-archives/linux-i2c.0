From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' for-linus/i2c-33 branch
Date: Tue, 17 Jan 2012 23:35:59 +0000
Message-ID: <E1RnIZL-0002P0-O0@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bjdooks-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit c2bc3a316a7281f67e36b34dac2802cbe36a9128:

  Merge branch 'x86/rdrand' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2012-01-16 18:23:09 -0800)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c-33

Alexander Aring (1):
      I2C: OMAP: correct SYSC register offset for OMAP4

Ben Dooks (1):
      Merge branches 'for-33/i2c/eg20t' and 'for-33/i2c/omap' into for-linus/i2c-33

Benoit Cousson (1):
      i2c: OMAP: Add DT support for i2c controller

Feng Tang (1):
      i2c-eg20t: use i2c_add_numbered_adapter to get a fixed bus number

Jan Weitzel (1):
      I2C: OMAP: NACK without STP

Tomoya MORINAGA (2):
      i2c-eg20t: Support new device LAPIS Semiconductor ML7831 IOH
      i2c-eg20t: Change-company-name-OKI-SEMICONDUCTOR to LAPIS Semiconductor

Toshiharu Okada (1):
      i2c-eg20t: modified the setting of transfer rate.

 Documentation/devicetree/bindings/i2c/omap-i2c.txt |   30 ++++++
 drivers/i2c/busses/Kconfig                         |   14 ++--
 drivers/i2c/busses/i2c-eg20t.c                     |   19 ++--
 drivers/i2c/busses/i2c-omap.c                      |  110 +++++++++++++-------
 4 files changed, 119 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt
