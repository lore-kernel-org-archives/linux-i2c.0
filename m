From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for Linux 3.2
Date: Wed, 23 Nov 2011 11:55:32 +0100
Message-ID: <20111123115532.1fa8c251@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 3.2 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 Documentation/i2c/ten-bit-addresses |   36 ++++++++++++++++++----------------
 drivers/i2c/algos/i2c-algo-bit.c    |    4 +-
 drivers/i2c/i2c-core.c              |    4 ++-
 drivers/i2c/i2c-dev.c               |    2 +-
 include/linux/i2c.h                 |    3 --
 5 files changed, 25 insertions(+), 24 deletions(-)

---------------

Jean Delvare (2):
      i2c: Fix device name for 10-bit slave address
      i2c: Delete ANY_I2C_BUS

Jeffrey (Sheng-Hui) Chu (1):
      i2c-algo-bit: Generate correct i2c address sequence for 10-bit target

Shubhrajyoti D (1):
      i2c: Make i2cdev_notifier_call static

Thanks,
-- 
Jean Delvare
