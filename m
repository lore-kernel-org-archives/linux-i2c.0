From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 18 Mar 2011 11:40:23 +0100
Message-ID: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Waldemar Rymarkiewicz <waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Updated patch after Arnd's comments.

Waldek

Waldemar Rymarkiewicz (1):
  NFC: Driver for Inside Secure MicroRead NFC chip

 Documentation/nfc/nfc-microread.txt |   46 ++++
 drivers/nfc/Kconfig                 |   10 +
 drivers/nfc/Makefile                |    1 +
 drivers/nfc/microread.c             |  465 +++++++++++++++++++++++++++++++++++
 include/linux/nfc/microread.h       |   31 +++
 5 files changed, 553 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/nfc/nfc-microread.txt
 create mode 100644 drivers/nfc/microread.c
 create mode 100644 include/linux/nfc/microread.h
