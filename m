From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' for-linus/i2c-32-rc6 branch
Date: Sun, 18 Dec 2011 11:49:01 +0000
Message-ID: <E1RcFEj-0002WA-PP@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bjdooks-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit a36bfddd65b58dd8c8364dba919c04922e04f2f5:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jbarnes/pci (2011-12-17 10:40:51 -0800)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c-32-rc6

Feng Tang (1):
      i2c-eg20t: correct the driver init order of pch_i2c_probe()

Mark Brown (1):
      i2c: i2c-s3c2410: Add a cpu_relax() to busy wait for bus idle

Shubhrajyoti D (1):
      I2C: OMAP: fix FIFO usage for OMAP4

Tushar Behera (1):
      i2c-s3c2410: Fix return code of s3c24xx_i2c_parse_dt_gpio

 drivers/i2c/busses/i2c-eg20t.c   |   22 ++++++++++++----------
 drivers/i2c/busses/i2c-omap.c    |   11 ++++++-----
 drivers/i2c/busses/i2c-s3c2410.c |    3 ++-
 3 files changed, 20 insertions(+), 16 deletions(-)
