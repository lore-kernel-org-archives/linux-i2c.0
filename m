From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] Late i2c updates for 2.6.37
Date: Sun, 31 Oct 2010 21:19:04 +0100
Message-ID: <20101031211904.7c0ab7c5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull late i2c subsystem updates for Linux 2.6.37 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

These depended on changes in other trees, which I had to wait for you
to merge before I could send them.

 Documentation/i2c/busses/i2c-i801   |    6 +-
 drivers/i2c/busses/Kconfig          |    1 +
 drivers/i2c/busses/i2c-i801.c       |  333 ++++++++++++++++++++---------------
 drivers/staging/tm6000/tm6000-i2c.c |    1 -
 include/linux/i2c.h                 |    2 -
 include/linux/pci_ids.h             |    1 +
 6 files changed, 196 insertions(+), 148 deletions(-)

---------------

David Woodhouse (2):
      i2c-i801: Handle multiple instances instead of keeping global state
      i2c-i801: Add PCI idents for Patsburg 'IDF' SMBus controllers

Jean Delvare (1):
      i2c: Drop unused I2C_CLASS_TV flags

Seth Heasley (1):
      i2c-i801: Add Intel Patsburg device ID

Thanks,
-- 
Jean Delvare
