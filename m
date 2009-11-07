From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.32
Date: Sat, 7 Nov 2009 14:34:44 +0100
Message-ID: <20091107143444.44200912@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull some more i2c subsystem fixes for Linux 2.6.32 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 Documentation/i2c/busses/i2c-piix4 |    2 +-
 drivers/i2c/busses/Kconfig         |    2 +-
 drivers/i2c/busses/i2c-piix4.c     |    8 ++++----
 drivers/net/sfc/sfe4001.c          |    4 ++--
 include/linux/i2c.h                |   18 ++++++++++++++++++
 include/linux/pci_ids.h            |    2 +-
 6 files changed, 27 insertions(+), 9 deletions(-)

---------------

Crane Cai (1):
      i2c-piix4: Modify code name SB900 to Hudson-2

Jean Delvare (1):
      i2c: Add an interface to lock/unlock an I2C bus segment

Thanks,
-- 
Jean Delvare
