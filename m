From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for Linux 3.4
Date: Mon, 26 Mar 2012 22:49:32 +0200
Message-ID: <20120326224932.7b4272e2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 3.4 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 Documentation/i2c/busses/i2c-i801 |    1 +
 drivers/i2c/algos/i2c-algo-bit.c  |    5 +++--
 drivers/i2c/algos/i2c-algo-pca.c  |    3 ++-
 drivers/i2c/algos/i2c-algo-pcf.c  |    3 ++-
 drivers/i2c/algos/i2c-algo-pcf.h  |    3 ++-
 drivers/i2c/busses/Kconfig        |    1 +
 drivers/i2c/busses/i2c-gpio.c     |    3 +--
 drivers/i2c/busses/i2c-i801.c     |   27 +++++++++++++++------------
 drivers/i2c/busses/i2c-isch.c     |   10 +++++-----
 drivers/i2c/i2c-boardinfo.c       |    3 ++-
 drivers/i2c/i2c-core.c            |    3 ++-
 drivers/i2c/i2c-core.h            |    3 ++-
 drivers/i2c/i2c-dev.c             |    3 ++-
 drivers/i2c/i2c-smbus.c           |    3 ++-
 drivers/i2c/muxes/pca9541.c       |   13 +------------
 drivers/i2c/muxes/pca954x.c       |   13 +------------
 include/linux/i2c-algo-bit.h      |    3 ++-
 include/linux/i2c-algo-pcf.h      |    3 ++-
 include/linux/i2c-dev.h           |    3 ++-
 include/linux/i2c-mux.h           |    3 ++-
 include/linux/i2c-smbus.h         |    3 ++-
 include/linux/i2c.h               |    3 ++-
 22 files changed, 56 insertions(+), 59 deletions(-)

---------------

Axel Lin (1):
      i2c: Convert drivers/i2c/muxes/* to use module_i2c_driver()

Jean Delvare (3):
      i2c-i801: Use usleep_range to wait for command completion
      i2c: Update the FSF address
      i2c-algo-bit: Don't resched on clock stretching

Mark Brown (1):
      i2c-gpio: Use linux/gpio.h rather than asm/gpio.h

Olivier Sobrie (1):
      i2c-isch: Decrease delay in command completion check loop

Seth Heasley (1):
      i2c-i801: Add device IDs for Intel Lynx Point

Thanks,
-- 
Jean Delvare
