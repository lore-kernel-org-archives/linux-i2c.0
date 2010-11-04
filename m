From: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 0/1] NFC: PN544 driver.
Date: Thu,  4 Nov 2010 17:32:02 +0200
Message-ID: <1288884723-12156-1-git-send-email-matti.j.aaltonen@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi.

Removed the erroneous reference to SWP (Single Wire Protocol) from 
the patch description and the document file.

Cheers,
Matti

Matti J. Aaltonen (1):
  NFC: Driver for NXP Semiconductors PN544 NFC chip.

 Documentation/nfc/nfc-pn544.txt |  114 +++++
 drivers/Kconfig                 |    2 +
 drivers/Makefile                |    2 +-
 drivers/nfc/Kconfig             |   30 ++
 drivers/nfc/Makefile            |    5 +
 drivers/nfc/pn544.c             |  891 +++++++++++++++++++++++++++++++++++++++
 include/linux/nfc/pn544.h       |   97 +++++
 7 files changed, 1140 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/nfc/nfc-pn544.txt
 create mode 100644 drivers/nfc/Kconfig
 create mode 100644 drivers/nfc/Makefile
 create mode 100644 drivers/nfc/pn544.c
 create mode 100644 include/linux/nfc/pn544.h
