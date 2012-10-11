From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/3] Add support for sparc, custom set and get functions, and the GRLIB port of the controller
Date: Thu, 11 Oct 2012 16:11:16 +0200
Message-ID: <1349964679-23244-1-git-send-email-andreas@gaisler.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!

This patchset adds support for sparc, for custom setreg and getreg functions,
and for the GRLIB port of the controller.

On sparc, irq is not present as an IORESOURCE in the struct platform_device
representation. Therefore, irq_of_parse_and_map() is used instead, which for
sparc simply returns an irq number.

The GRLIB port of the controller needs custom getreg and setreg functions to
allow for big endian register access and to deal with the fact that the PRELOW
and PREHIGH registers have been merged into one register.

Cheers,
Andreas

Andreas Larsson (3):
  i2c-ocores: Add irq support for sparc
  i2c-ocores: Add support for custom getreg and setreg functions
  i2c-ocores: Add support for the GRLIB port of the controller.

 drivers/i2c/busses/i2c-ocores.c |   74 +++++++++++++++++++++++++++++++++++---
 1 files changed, 68 insertions(+), 6 deletions(-)
