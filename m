From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for Linux 3.3
Date: Thu, 12 Jan 2012 20:37:04 +0100
Message-ID: <20120112203704.14400201@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 3.3 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 MAINTAINERS                                |    4 +++
 drivers/i2c/busses/i2c-ali1535.c           |   38 +++++++++++++++++++--------
 drivers/i2c/busses/i2c-ali1563.c           |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c           |    2 +-
 drivers/i2c/busses/i2c-amd756.c            |    2 +-
 drivers/i2c/busses/i2c-amd8111.c           |    2 +-
 drivers/i2c/busses/i2c-at91.c              |   17 +-----------
 drivers/i2c/busses/i2c-au1550.c            |   13 +---------
 drivers/i2c/busses/i2c-cpm.c               |   13 +---------
 drivers/i2c/busses/i2c-designware-pcidrv.c |    2 +-
 drivers/i2c/busses/i2c-eg20t.c             |    2 +-
 drivers/i2c/busses/i2c-highlander.c        |   13 +---------
 drivers/i2c/busses/i2c-hydra.c             |    2 +-
 drivers/i2c/busses/i2c-i801.c              |    2 +-
 drivers/i2c/busses/i2c-ibm_iic.c           |   13 +---------
 drivers/i2c/busses/i2c-intel-mid.c         |    2 +-
 drivers/i2c/busses/i2c-iop3xx.c            |   16 +-----------
 drivers/i2c/busses/i2c-isch.c              |   13 +---------
 drivers/i2c/busses/i2c-ixp2000.c           |   13 +---------
 drivers/i2c/busses/i2c-mpc.c               |   13 +---------
 drivers/i2c/busses/i2c-mv64xxx.c           |   15 +----------
 drivers/i2c/busses/i2c-nforce2.c           |    4 +-
 drivers/i2c/busses/i2c-ocores.c            |   17 +-----------
 drivers/i2c/busses/i2c-octeon.c            |   16 +-----------
 drivers/i2c/busses/i2c-pasemi.c            |    2 +-
 drivers/i2c/busses/i2c-pca-platform.c      |   14 +---------
 drivers/i2c/busses/i2c-piix4.c             |    2 +-
 drivers/i2c/busses/i2c-pmcmsp.c            |   17 +-----------
 drivers/i2c/busses/i2c-powermac.c          |   19 +------------
 drivers/i2c/busses/i2c-pxa-pci.c           |    2 +-
 drivers/i2c/busses/i2c-sh7760.c            |   13 +---------
 drivers/i2c/busses/i2c-simtec.c            |   18 +-----------
 drivers/i2c/busses/i2c-sis5595.c           |    6 ++--
 drivers/i2c/busses/i2c-sis630.c            |    8 ++++-
 drivers/i2c/busses/i2c-sis96x.c            |    2 +-
 drivers/i2c/busses/i2c-via.c               |    2 +-
 drivers/i2c/busses/i2c-viapro.c            |    9 ++++--
 drivers/i2c/busses/i2c-xiic.c              |   18 +-----------
 drivers/i2c/busses/scx200_acb.c            |    2 +-
 drivers/i2c/i2c-dev.c                      |   13 +++------
 drivers/i2c/muxes/gpio-i2cmux.c            |   13 +---------
 41 files changed, 92 insertions(+), 304 deletions(-)

---------------

Axel Lin (3):
      i2c: Convert to DEFINE_PCI_DEVICE_TABLE
      i2c/busses: Use module_platform_driver()
      i2c/gpio-i2cmux: Convert to use module_platform_driver()

Jean Delvare (2):
      i2c: Fix error value returned by several bus drivers
      MAINTAINERS: List i2c-omap and i2c-davinci drivers

Thomas Meyer (1):
      i2c-dev: Use memdup_user

Wolfram Sang (1):
      MAINTAINERS: i2c: Add third maintainer

corentin.labbe (1):
      i2c-ali1535: enable SPARC support

Thanks,
-- 
Jean Delvare
