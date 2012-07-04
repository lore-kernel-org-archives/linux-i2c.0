From: Qiao Zhou <zhouqiao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/4 V2] add 88pm80x mfd driver
Date: Wed,  4 Jul 2012 16:55:11 +0800
Message-ID: <1341392115-9425-1-git-send-email-zhouqiao@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: arnd-r2nGTMty4D4@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, yu.tang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, wilbur.wang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Qiao Zhou <zhouqiao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

change log [v2->v1]:
1, split 88pm80x-core.c into 88pm800-core.c and 88pm805.c, per Arnd's
suggestion. after the re-arch, 88pm80x-i2c handles the 800 & 805 common
parts, while 800-core.c & 805-core.c handle the specific parts in each
chip.
2, add details about the workaround adding a i2c companion between 800 &
805, and make a separate patch for it, per Arnd's suggestion.
3, remove callback in pdata. but still keep the pdata currently.
4, only keep necessary register in 88pm80x.h, including registers for
regulator/rtc/onkey/power/codec etc, and remove other registers from global
visibility.
5, exported r/w API which requires regmap handle. as currently the pm800
chip has 3 i2c device, only passing a pm80x_chip info can't ensure r/w the
register in correct i2c device.

change log [v1]:
1, pm800 and pm805 are decoupled and probed separately;
2, re-used the most of API for pm800 and pm805 per Arnd's comments;
3, use regmap_irq, instead of previous 88pm80x_irq_data per Mark's comments.
use regmap_add_irq_chip, and remove previous 88pm80x irq handling.
4, remove callback function in rtc pdata per Arnd's comments.
5, updated some coding style issue.

Qiao Zhou (4):
  mfd: support 88pm80x in 80x driver
  mfd: workaround: add companion chip in 88pm80x
  rtc: add rtc support to 88PM80X PMIC
  input: add onkey support to 88PM80X PMIC

 drivers/input/misc/88pm80x_onkey.c |  190 +++++++++++++
 drivers/input/misc/Kconfig         |   10 +
 drivers/input/misc/Makefile        |    1 +
 drivers/mfd/88pm800-core.c         |  492 +++++++++++++++++++++++++++++++++
 drivers/mfd/88pm805-core.c         |  273 +++++++++++++++++++
 drivers/mfd/88pm80x-i2c.c          |  231 ++++++++++++++++
 drivers/mfd/Kconfig                |   12 +
 drivers/mfd/Makefile               |    2 +
 drivers/rtc/Kconfig                |   10 +
 drivers/rtc/Makefile               |    1 +
 drivers/rtc/rtc-88pm80x.c          |  366 +++++++++++++++++++++++++
 include/linux/mfd/88pm80x.h        |  522 ++++++++++++++++++++++++++++++++++++
 12 files changed, 2110 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/88pm80x_onkey.c
 create mode 100644 drivers/mfd/88pm800-core.c
 create mode 100644 drivers/mfd/88pm805-core.c
 create mode 100644 drivers/mfd/88pm80x-i2c.c
 create mode 100644 drivers/rtc/rtc-88pm80x.c
 create mode 100644 include/linux/mfd/88pm80x.h
