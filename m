From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for Linux 3.1
Date: Mon, 25 Jul 2011 17:53:24 +0200
Message-ID: <20110725175324.137c340c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 3.1 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 drivers/i2c/busses/i2c-ali1535.c |   61 ++++++++++++++++++-------------------
 drivers/i2c/busses/i2c-cpm.c     |    7 +---
 drivers/i2c/busses/i2c-pxa.c     |    7 +---
 drivers/i2c/busses/i2c-s6000.c   |    5 +--
 drivers/i2c/i2c-core.c           |    5 +++
 5 files changed, 40 insertions(+), 45 deletions(-)

---------------

Grant Likely (1):
      i2c: Allow i2c_add_numbered_adapter() to assign a bus id

LABBE Corentin (1):
      i2c-ali1535: Fix style issues

Thanks,
-- 
Jean Delvare
