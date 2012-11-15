From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v5 0/2] i2c: i2c-ocores: Add support for sparc, custom set and get functions, and the GRLIB port of the controller
Date: Thu, 15 Nov 2012 15:09:06 +0100
Message-ID: <1352988548-10138-1-git-send-email-andreas@gaisler.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On sparc, irqs are not present as an IORESOURCE in the struct platform_device
representation. By using platform_get_irq instead of platform_get_resource the
driver works for sparc.

The GRLIB port of the ocores i2c controller needs custom getreg and setreg
functions to allow for big endian register access and to deal with the fact that
the PRELOW and PREHIGH registers have been merged into one register.

Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>

Changes since v4:
- Replace the ocores_get_type function with inline code in the probe function
- Replace the oc_(get|set)reg functions with oc_(get|set)reg_(8|16|32)
  functions and always use the function pointers to call them.

Andreas Larsson (2):
  i2c: i2c-ocores: Add irq support for sparc
  i2c: i2c-ocores: Add support for the GRLIB port of the controller and
    use function pointers for getreg and setreg functions

 .../devicetree/bindings/i2c/i2c-ocores.txt         |    2 +-
 drivers/i2c/busses/i2c-ocores.c                    |  187 ++++++++++++++------
 2 files changed, 138 insertions(+), 51 deletions(-)
