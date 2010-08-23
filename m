From: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH RFC 0/1] MISC: Broadcom BCM4751 GPS driver
Date: Mon, 23 Aug 2010 17:00:25 +0300
Message-ID: <1282572026-14905-1-git-send-email-matti.j.aaltonen@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

This is a driver for Broadcom's BCM4751 GPS chip and
this is the first time this driver is sent for review, 
all comments are welcome.

Thanks,
Matti A.

Matti J. Aaltonen (1):
  MISC: Broadcom BCM4751 GPS driver

 drivers/misc/Kconfig            |   11 +
 drivers/misc/Makefile           |    1 +
 drivers/misc/bcm4751-gps.c      |  490 +++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/bcm4751-gps.h |   59 +++++
 4 files changed, 561 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/bcm4751-gps.c
 create mode 100644 include/linux/i2c/bcm4751-gps.h
