From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.30
Date: Tue, 5 May 2009 08:49:32 +0200
Message-ID: <20090505084932.3fd1c519@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull the i2c subsystem fixes for Linux 2.6.30 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

 drivers/i2c/algos/i2c-algo-bit.c |    2 +-
 drivers/i2c/algos/i2c-algo-pca.c |   11 +++++++++++
 drivers/i2c/busses/i2c-ali1535.c |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c |    2 +-
 drivers/i2c/busses/i2c-amd756.c  |    4 ++--
 drivers/i2c/busses/i2c-i801.c    |    8 ++++----
 drivers/i2c/busses/i2c-isch.c    |    2 +-
 drivers/i2c/busses/i2c-nforce2.c |    2 +-
 drivers/i2c/busses/i2c-sis5595.c |    2 +-
 drivers/i2c/busses/i2c-sis630.c  |    2 +-
 drivers/i2c/busses/i2c-sis96x.c  |    2 +-
 11 files changed, 25 insertions(+), 14 deletions(-)

---------------

Dave Airlie (1):
      i2c-algo-bit: Fix timeout test

Enrik Berkhan (1):
      i2c-algo-pca: Let PCA9564 recover from unacked data byte (state 0x30)

Roel Kluin (1):
      i2c: Timeouts off by 1

Thanks,
-- 
Jean Delvare
