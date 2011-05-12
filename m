From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: please pull bjdooks' i2c fixes
Date: Fri, 13 May 2011 00:12:05 +0100
Message-ID: <20110512231205.GA28409@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Please pull the following commit:

The following changes since commit ca1376d10810bc2c20c8d0821a9ee04ca2507c01:

  Merge branch 'fix/asoc' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6 (2011-05-12 12:41:30 -0700)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-2639-rc7/i2c-fixes

Wolfram Sang (1):
      i2c: pnx: Fix crash due to wrong init of timer->data

 drivers/i2c/busses/i2c-pnx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
