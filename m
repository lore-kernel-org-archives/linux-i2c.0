From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.30
Date: Tue, 21 Apr 2009 21:05:57 +0200
Message-ID: <20090421210557.66bd41f4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull the i2c subsystem fixes for Linux 2.6.30 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

 drivers/staging/go7007/go7007-driver.c  |   11 +++-
 drivers/staging/go7007/go7007-i2c.c     |   83 -------------------------------
 drivers/staging/go7007/go7007-priv.h    |    1 +
 drivers/staging/go7007/go7007-usb.c     |   14 ++++-
 drivers/staging/go7007/s2250-board.c    |   71 +++++++++++---------------
 drivers/staging/go7007/wis-i2c.h        |    9 ---
 drivers/staging/go7007/wis-ov7640.c     |   56 ++++++--------------
 drivers/staging/go7007/wis-saa7113.c    |   60 +++++++---------------
 drivers/staging/go7007/wis-saa7115.c    |   60 +++++++---------------
 drivers/staging/go7007/wis-sony-tuner.c |   60 +++++++----------------
 drivers/staging/go7007/wis-tw2804.c     |   57 +++++++--------------
 drivers/staging/go7007/wis-tw9903.c     |   60 +++++++---------------
 drivers/staging/go7007/wis-uda1342.c    |   52 ++++++--------------
 13 files changed, 176 insertions(+), 418 deletions(-)

---------------

Jean Delvare (1):
      go7007: Convert to the new i2c device binding model

Thanks,
-- 
Jean Delvare
