From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' for-31-rc5/i2c-fixes branch
Date: Wed, 07 Sep 2011 00:14:18 +0100
Message-ID: <E1R14qQ-0006ue-4I@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 9e79e3e9dd9672b37ac9412e9a926714306551fe:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2011-08-30 11:28:18 -0700)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-31-rc5/i2c-fixes

Axel Lin (1):
      i2c-pxa2xx: return proper error code in ce4100_i2c_probe error paths

Doug Anderson (1):
      i2c-tegra: fix possible race condition after tx

John Bonesio (1):
      i2c-tegra: Add of_match_table

Mike Rapoport (1):
      i2c-tegra: add I2C_FUNC_SMBUS_EMUL

 drivers/i2c/busses/i2c-pxa-pci.c |    5 ++-
 drivers/i2c/busses/i2c-tegra.c   |   60 ++++++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 16 deletions(-)
