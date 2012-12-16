From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for Linux 3.8
Date: Sun, 16 Dec 2012 21:23:18 +0100
Message-ID: <20121216212318.5b08ee4a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 3.8 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

This is my last pull request for the i2c subsystem. It includes all
the patches I collected between kernel v3.7-rc1 and me passing i2c
maintenance duties over to Wolfram. Future patches to the many i2c bus
drivers I still maintain will go through Wolfram's tree.

 Documentation/i2c/smbus-protocol |   40 +++++++++++++++++++++++++++++--------
 MAINTAINERS                      |    2 +-
 drivers/i2c/busses/i2c-i801.c    |   13 ++---------
 drivers/i2c/busses/i2c-piix4.c   |    5 +--
 4 files changed, 37 insertions(+), 23 deletions(-)

---------------

Cesar Eduardo Barros (1):
      MAINTAINERS: Fix drivers/i2c/busses/i2c-stub.c

Jean Delvare (2):
      i2c-i801: Enable interrupts for all post-ICH5 chips
      i2c: Mention functionality flags in SMBus protocol documentation

Joe Perches (1):
      i2c-piix4: Convert dev_printk(KERN_<LEVEL> to dev_<level>(

Thierry Reding (1):
      i2c-i801: Add device tree support

Thanks,
-- 
Jean Delvare
