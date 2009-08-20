From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c-fixes
Date: Thu, 20 Aug 2009 22:32:29 +0100
Message-ID: <E1MeFFF-0003wj-Iw@kira.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 64f1607ffbbc772685733ea63e6f7f4183df1b16:
  Linus Torvalds (1):
        Linux 2.6.31-rc6

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-fixes-rc6

Linus Walleij (1):
      i2c-stu300: I2C STU300 stability updates

Moiz Sonasath (2):
      i2c-omap: ACK pending [R/X]DR and [R/X]RDY interrupts
      i2c-omap: Enable workaround for Errata 1.153 based on

Nishanth Menon (1):
      i2c-omap: Fix I2C status ACK

 drivers/i2c/busses/i2c-omap.c   |   14 +++-
 drivers/i2c/busses/i2c-stu300.c |  157 +++++++++++++++++++++++----------------
 2 files changed, 104 insertions(+), 67 deletions(-)
