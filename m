From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [PULL] please pull bjdooks' i2c-pnx-fixes branch
Date: Fri, 20 Nov 2009 00:29:43 +0000
Message-ID: <20091120002943.GA19796@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 648f4e3e50c4793d9dbf9a09afa193631f76fa26:
  Linus Torvalds (1):
        Linux 2.6.32-rc8

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux i2c-pnx-fixes

Kevin Wells (3):
      i2c: i2c-pnx: Limit minimum jiffie timeout to 2
      i2c: i2c-pnx: Made buf type unsigned to prevent sign extension
      i2c: i2c-pnx: Added missing mach/i2c.h and linux/io.h header file includes

 drivers/i2c/busses/i2c-pnx.c |    5 +++++
 include/linux/i2c-pnx.h      |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
