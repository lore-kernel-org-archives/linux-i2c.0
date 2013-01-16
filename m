From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: [GIT PULL] i2c: vt8500: Add support for Wondermedia I2C master-mode
Date: Wed, 16 Jan 2013 18:52:25 +1300
Message-ID: <1358315546-2201-1-git-send-email-linux@prisktech.co.nz>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

This patch has been floating around since 27 december with no replies so
here is a pull-request for it.

Regards
Tony Prisk

cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://server.prisktech.co.nz/git/linuxwmt.git tags/i2c-3.9

for you to fetch changes up to c24a4dd6d6ad85e5d5cdb4e20c623103360ea7e0:

  i2c: vt8500: Add support for Wondermedia I2C master-mode (2013-01-16 18:45:12 +1300)

----------------------------------------------------------------
i2c: vt8500: Add support for I2C on arch-vt8500

----------------------------------------------------------------
Tony Prisk (1):
      i2c: vt8500: Add support for Wondermedia I2C master-mode

 .../devicetree/bindings/i2c/i2c-vt8500.txt         |   24 +
 drivers/i2c/busses/Kconfig                         |    7 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-wmt.c                       |  636 ++++++++++++++++++++
 4 files changed, 668 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-vt8500.txt
 create mode 100644 drivers/i2c/busses/i2c-wmt.c
