From: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/2] MAX8997/8966 MFD (PMIC+RTC+...) Initial Release
Date: Fri, 14 Jan 2011 15:53:36 +0900
Message-ID: <1294988018-25100-1-git-send-email-myungjoo.ham@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

MAX8997/8966 has
- PMIC
- RTC
- MUIC (usb switch)
- Flash control
- Haptic control
- Fuel Gauge (MAX17042 compatible)
- Battery charger control

This patch adds an initial driver for Maxim Semiconductor 8997/8966's
PMIC function.

MyungJoo Ham (2):
  MAX8997/8966 MFD Driver Initial Release (PMIC+RTC+MUIC+Haptic+...)
  MAX8997/8966 PMIC Regulator Driver Initial Release

 drivers/mfd/Kconfig                 |   12 +
 drivers/mfd/Makefile                |    1 +
 drivers/mfd/max8997.c               |  211 +++++++++
 drivers/regulator/Kconfig           |    9 +
 drivers/regulator/Makefile          |    1 +
 drivers/regulator/max8997.c         |  867 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/max8997-private.h |  238 ++++++++++
 include/linux/mfd/max8997.h         |  106 +++++
 8 files changed, 1445 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/max8997.c
 create mode 100644 drivers/regulator/max8997.c
 create mode 100644 include/linux/mfd/max8997-private.h
 create mode 100644 include/linux/mfd/max8997.h
