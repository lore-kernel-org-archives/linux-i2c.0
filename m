From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.34
Date: Tue, 4 May 2010 11:12:30 +0200
Message-ID: <20100504111230.04ffe803@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 2.6.34 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 Documentation/i2c/writing-clients |    5 +++
 drivers/i2c/i2c-core.c            |   63 +++++++++++++++++++++++-------------
 include/linux/i2c.h               |    2 +
 3 files changed, 47 insertions(+), 23 deletions(-)

---------------

Jean Delvare (2):
      i2c: Fix probing of FSC hardware monitoring chips
      i2c-core: Use per-adapter userspace device lists

Wolfram Sang (1):
      i2c-core: Erase pointer to clientdata on removal

Thanks,
-- 
Jean Delvare
