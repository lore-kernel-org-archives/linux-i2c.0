From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c tree
Date: Mon, 22 Jun 2009 01:50:42 +0100
Message-ID: <E1MIXkA-0005wC-2l@kira.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: apkm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit f234012f52a37e48f2330e1ca2df69800e797c3b:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../drzeus/mmc

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git next-i2c

Michael Trimarchi (1):
      i2c: Fix stuck transaction on cpm-i2c driver

Tony Lindgren (1):
      i2c-omap: Fix build breaking typo cpu_is_omap_2430

 drivers/i2c/busses/i2c-cpm.c  |    6 +++---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
