From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.36
Date: Fri, 1 Oct 2010 14:06:19 +0200
Message-ID: <20101001140619.28d96040@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 2.6.36 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 drivers/i2c/busses/i2c-cpm.c           |    5 +++
 drivers/i2c/busses/i2c-ibm_iic.c       |    3 ++
 drivers/i2c/busses/i2c-mpc.c           |    1 +
 drivers/i2c/busses/i2c-pca-isa.c       |   12 +++++--
 drivers/i2c/busses/i2c-pca-platform.c  |   11 ++++--
 drivers/i2c/i2c-core.c                 |   54 ++++++++++++++-----------------
 drivers/misc/bh1780gli.c               |    1 -
 drivers/regulator/ad5398.c             |    1 -
 drivers/regulator/isl6271a-regulator.c |    2 -
 drivers/rtc/rtc-ds3232.c               |    2 -
 10 files changed, 48 insertions(+), 44 deletions(-)

---------------

Grant Likely (1):
      of/i2c: Fix module load order issue caused by of_i2c.c

Rajendra Nayak (1):
      i2c: Fix checks which cause legacy suspend to never get called

Vishwanath BS (1):
      i2c: Fix for suspend/resume issue

Wolfram Sang (1):
      i2c: Remove obsolete cleanup for clientdata

Yegor Yefremov (1):
      i2c-pca: Fix waitforcompletion() return value

Thanks,
-- 
Jean Delvare
