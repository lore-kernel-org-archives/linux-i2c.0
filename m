From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c tree
Date: Sat, 19 Sep 2009 23:46:44 +0100
Message-ID: <E1Mp8hY-0006EA-7X@kira.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: apkm-LbGehh/F0aFj/JC5u5XAOISLwOllVvif@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 78f28b7c555359c67c2a0d23f7436e915329421e:
  Linus Torvalds (1):
        Merge branch 'x86-platform-for-linus' of git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git next-i2c

Mikael Pettersson (1):
      i2c-mv64xxx: correct mv64xxx_i2c_intr() return type

Wolfram Sang (1):
      i2c-imx: make bus available early

 drivers/i2c/busses/i2c-imx.c     |    3 +--
 drivers/i2c/busses/i2c-mv64xxx.c |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)
