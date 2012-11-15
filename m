From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v4 0/2] i2c: i2c-ocores: Add support for sparc, custom set and get functions, and the GRLIB port of the controller
Date: Thu, 15 Nov 2012 11:22:57 +0100
Message-ID: <1352974979-22638-1-git-send-email-andreas@gaisler.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-i2c@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, software@gaisler.com
List-Id: linux-i2c@vger.kernel.org

On sparc, irqs are not present as an IORESOURCE in the struct platform_device
representation. By using platform_get_irq instead of platform_get_resource the
driver works for sparc.

The GRLIB port of the ocores i2c controller needs custom getreg and setreg
functions to allow for big endian register access and to deal with the fact that
the PRELOW and PREHIGH registers have been merged into one register.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>

 Changes since v3:
 - Use a separate entry in the of match table for the grlib variant and trigger
   grlib function usage on type put in the data field of that table entry

Andreas Larsson (2):
  i2c: i2c-ocores: Add irq support for sparc
  i2c: i2c-ocores: Add support for the GRLIB port of the controller and
    custom getreg and setreg functions

 .../devicetree/bindings/i2c/i2c-ocores.txt         |    2 +-
 drivers/i2c/busses/i2c-ocores.c                    |   90 ++++++++++++++++++--
 2 files changed, 83 insertions(+), 9 deletions(-)
