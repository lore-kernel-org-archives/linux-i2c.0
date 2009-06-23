From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c-next tree
Date: Wed, 24 Jun 2009 00:22:05 +0100
Message-ID: <20090623232205.GA2866@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, apkm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

If possible, is there an oportunity to get this last pull before
the end of the merge window done to add the Synopsys Designware
controller driver?

The following changes since commit d888a4c76c51092993643f8992bf55b3c28da483:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../vapier/blackfin

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git next-i2c

Baruch Siach (1):
      i2c: driver for the Synopsys DesignWare I2C controller

 drivers/i2c/busses/Kconfig          |    9 +
 drivers/i2c/busses/Makefile         |    1 +
 drivers/i2c/busses/i2c-designware.c |  624 +++++++++++++++++++++++++++++++++++
 3 files changed, 634 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware.c
