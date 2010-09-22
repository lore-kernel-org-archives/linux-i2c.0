From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c-fixes
Date: Wed, 22 Sep 2010 02:11:52 +0100
Message-ID: <E1OyDsG-0000XG-A7@ben-laptop>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 2422084a94fcd5038406261b331672a13c92c050:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../mattst88/alpha-2.6

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c/2636-rc5

Mathias Nyman (1):
      i2c-omap: Make sure i2c bus is free before setting it to idle

 drivers/i2c/busses/i2c-omap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)
