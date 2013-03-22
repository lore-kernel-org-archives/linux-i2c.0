From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 3.9
Date: Fri, 22 Mar 2013 23:22:01 +0100
Message-ID: <20130322222201.GA10797@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Linus,

please pull the updates for the 3.9 kernel. There is one bugfix for the
tegra driver. There are two updates regarding email addresses and
MAINTAINERS which I like to have up-to-date so people can be reached
immediately. While we are here, there is on PCI_ID addition.

Thanks,

   Wolfram


The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 888f2804e46377b54f283707f87c09922ef87eb2:

  MAINTAINERS: add maintainer entry for atmel i2c driver (2013-03-22 11:19:59 +0100)

----------------------------------------------------------------
Guenter Roeck (1):
      i2c: Fix my e-mail address in drivers and documentation

Laxman Dewangan (1):
      i2c: tegra: check the clk_prepare_enable() return value

Ludovic Desroches (1):
      MAINTAINERS: add maintainer entry for atmel i2c driver

Seth Heasley (1):
      i2c: iSMT: add Intel Avoton DeviceIDs

 Documentation/i2c/busses/i2c-diolan-u2c |    2 +-
 MAINTAINERS                             |    6 ++++++
 drivers/i2c/busses/i2c-ismt.c           |    2 ++
 drivers/i2c/busses/i2c-tegra.c          |   13 +++++++++++--
 drivers/i2c/muxes/i2c-mux-pca9541.c     |    2 +-
 5 files changed, 21 insertions(+), 4 deletions(-)
