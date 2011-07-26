From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull i2c updates for 3.1
Date: Wed, 27 Jul 2011 00:09:44 +0100
Message-ID: <E1Qlqky-0003yJ-LA@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit ba5b56cb3e3d2cab73d4fee9a022bb69462a8cd9:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client (2011-07-26 13:38:50 -0700)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git next-i2c

John Bonesio (1):
      i2c: Tegra: Add DeviceTree support

Tomoya MORINAGA (2):
      i2c-eg20t : Support Combined R/W transfer mode
      i2c-eg20t : Fix the issue of Combined R/W transfer mode

 drivers/i2c/busses/i2c-eg20t.c |   41 ++++++++++++++++++++-------------------
 drivers/i2c/busses/i2c-tegra.c |   17 +++++++++++++++-
 2 files changed, 37 insertions(+), 21 deletions(-)
