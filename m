From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: current state of next i2c merge
Date: Sun, 14 Jun 2009 14:19:39 +0100
Message-ID: <20090614131939.GA19738@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is the current contents of my git tree, which since
Mike's blackfin patch is marked urget I would like to get
pushed in the next day or so.

If you have anything urgent, or can sort out any of the
patches that have had feedback but no new version, then
please get these sorted as soon as possible.

Basically, unless anything else turns up, this will be sent
to Linus on Tuesday afternoon (BST).

The following changes since commit 44b7532b8b464f606053562400719c9c21276037:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../jejb/scsi-rc-fixes-2.6

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git next-i2c

Ben Dooks (1):
      i2c-s3c2410: use resource_size()

Linus Walleij (2):
      i2c: ST DDC I2C U300 bus driver v3
      i2c: Use resource_size macro

Mike Frysinger (1):
      i2c-bfin-twi: pull in io.h for ioremap()

 drivers/i2c/busses/Kconfig            |   12 +
 drivers/i2c/busses/Makefile           |    1 +
 drivers/i2c/busses/i2c-at91.c         |    8 +-
 drivers/i2c/busses/i2c-au1550.c       |    2 +-
 drivers/i2c/busses/i2c-bfin-twi.c     |    3 +-
 drivers/i2c/busses/i2c-highlander.c   |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c      |    2 +-
 drivers/i2c/busses/i2c-ocores.c       |    8 +-
 drivers/i2c/busses/i2c-omap.c         |    2 +-
 drivers/i2c/busses/i2c-pca-platform.c |   10 +-
 drivers/i2c/busses/i2c-pmcmsp.c       |    8 +-
 drivers/i2c/busses/i2c-pxa.c          |    9 +-
 drivers/i2c/busses/i2c-s3c2410.c      |    4 +-
 drivers/i2c/busses/i2c-stu300.c       | 1029 +++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-versatile.c    |    6 +-
 15 files changed, 1073 insertions(+), 33 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stu300.c

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
