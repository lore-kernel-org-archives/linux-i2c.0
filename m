From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 00/16] i2c: remove __dev* attributes for retirement of HOTPLUG
Date: Tue, 27 Nov 2012 15:59:37 -0500
Message-ID: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a respin of the patches to remove the __dev* attributes in the
i2c subsystem.

The attributes __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit are no longer needed since CONFIG_HOTPLUG is being
removed as an option.


Bill Pemberton (16):
  i2c/busses: remove __dev* attributes
  i2c: mux-gpio: remove __dev* attributes
  i2c: pnx: remove __dev* attributes
  i2c: scx200_acb: remove __dev* attributes
  i2c: i2c-cpm: remove __dev* attributes
  i2c: i2c-gpio: remove __dev* attributes
  i2c: i2c-parport-light: remove __dev* attributes
  i2c: ocores: remove __dev* attributes
  i2c: omap: remove __dev* attributes
  i2c: pca: remove __dev* attributes
  i2c: puv3: remove __dev* attributes
  i2c: i2c-pasemi: remove __dev* attributes
  i2c: sirf: remove __dev* attributes
  i2c-ali1563: remove __dev* attributes
  i2c-sis96x: remove __dev* attributes
  i2c: SMBus: remove __dev* attributes

 drivers/i2c/busses/i2c-ali1535.c            |  8 +++---
 drivers/i2c/busses/i2c-ali1563.c            |  8 +++---
 drivers/i2c/busses/i2c-ali15x3.c            |  8 +++---
 drivers/i2c/busses/i2c-amd756.c             |  6 ++---
 drivers/i2c/busses/i2c-amd8111.c            |  6 ++---
 drivers/i2c/busses/i2c-at91.c               | 14 +++++------
 drivers/i2c/busses/i2c-au1550.c             |  6 ++---
 drivers/i2c/busses/i2c-cpm.c                |  8 +++---
 drivers/i2c/busses/i2c-designware-pcidrv.c  |  6 ++---
 drivers/i2c/busses/i2c-designware-platdrv.c |  6 ++---
 drivers/i2c/busses/i2c-eg20t.c              |  6 ++---
 drivers/i2c/busses/i2c-elektor.c            |  8 +++---
 drivers/i2c/busses/i2c-gpio.c               |  8 +++---
 drivers/i2c/busses/i2c-highlander.c         |  6 ++---
 drivers/i2c/busses/i2c-hydra.c              |  6 ++---
 drivers/i2c/busses/i2c-i801.c               | 24 +++++++++---------
 drivers/i2c/busses/i2c-ibm_iic.c            |  8 +++---
 drivers/i2c/busses/i2c-intel-mid.c          |  6 ++---
 drivers/i2c/busses/i2c-isch.c               |  6 ++---
 drivers/i2c/busses/i2c-mpc.c                | 38 ++++++++++++++---------------
 drivers/i2c/busses/i2c-mv64xxx.c            | 18 +++++++-------
 drivers/i2c/busses/i2c-mxs.c                |  6 ++---
 drivers/i2c/busses/i2c-nforce2.c            | 10 ++++----
 drivers/i2c/busses/i2c-nuc900.c             |  6 ++---
 drivers/i2c/busses/i2c-ocores.c             |  6 ++---
 drivers/i2c/busses/i2c-octeon.c             | 10 ++++----
 drivers/i2c/busses/i2c-omap.c               |  6 ++---
 drivers/i2c/busses/i2c-parport-light.c      |  6 ++---
 drivers/i2c/busses/i2c-pasemi.c             |  6 ++---
 drivers/i2c/busses/i2c-pca-isa.c            |  8 +++---
 drivers/i2c/busses/i2c-pca-platform.c       |  6 ++---
 drivers/i2c/busses/i2c-piix4.c              | 20 +++++++--------
 drivers/i2c/busses/i2c-pmcmsp.c             |  6 ++---
 drivers/i2c/busses/i2c-pnx.c                |  6 ++---
 drivers/i2c/busses/i2c-powermac.c           | 16 ++++++------
 drivers/i2c/busses/i2c-puv3.c               |  6 ++---
 drivers/i2c/busses/i2c-pxa-pci.c            |  6 ++---
 drivers/i2c/busses/i2c-rcar.c               |  6 ++---
 drivers/i2c/busses/i2c-s6000.c              |  8 +++---
 drivers/i2c/busses/i2c-sh7760.c             |  8 +++---
 drivers/i2c/busses/i2c-sh_mobile.c          |  2 +-
 drivers/i2c/busses/i2c-sirf.c               |  8 +++---
 drivers/i2c/busses/i2c-sis5595.c            |  4 +--
 drivers/i2c/busses/i2c-sis630.c             |  8 +++---
 drivers/i2c/busses/i2c-sis96x.c             |  6 ++---
 drivers/i2c/busses/i2c-tegra.c              |  8 +++---
 drivers/i2c/busses/i2c-via.c                |  6 ++---
 drivers/i2c/busses/i2c-viapro.c             |  2 +-
 drivers/i2c/busses/i2c-viperboard.c         |  6 ++---
 drivers/i2c/busses/i2c-xiic.c               |  8 +++---
 drivers/i2c/busses/i2c-xlr.c                |  6 ++---
 drivers/i2c/busses/scx200_acb.c             | 16 ++++++------
 drivers/i2c/muxes/i2c-mux-gpio.c            | 14 +++++------
 drivers/i2c/muxes/i2c-mux-pinctrl.c         |  8 +++---
 54 files changed, 232 insertions(+), 232 deletions(-)

-- 
1.8.0.1
