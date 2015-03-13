From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 0/6] i2c: qup: Add support for v2 tags and bam dma
Date: Fri, 13 Mar 2015 23:19:46 +0530
Message-ID: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

QUP from version 2.1.1 onwards, supports a new format of
i2c command tags. Tag codes instructs the controller to
perform a operation like read/write. This new tagging version
supports and is required for adding bam dma capabilities.
v2 tags supports transfer of more than 256 bytes in a single
i2c transaction. Also adding bam dma support facilitates
transferring each i2c_msg in i2c_msgs without a 'stop' bit
in between which is required for some of the clients.

This series depends on the below bam dma bug fix
 https://lkml.org/lkml/2015/2/20/47

Tested this series on apq8074 dragon board eeprom client
on i2c bus1

Andy Gross (1):
  i2c: qup: Add V2 tags support

Sricharan R (5):
  i2c: qup: Change qup_wait_writeready function to use for all timeouts
  i2c: qup: Add bam dma capabilities
  i2c: qup: Transfer every i2c_msg in i2c_msgs without stop
  dts: msm8974: Add blsp2_bam dma node
  dts: msm8974: Add dma channels for blsp2_i2c1 node

 arch/arm/boot/dts/qcom-msm8974.dtsi |  12 +
 drivers/i2c/busses/i2c-qup.c        | 783 +++++++++++++++++++++++++++++++++---
 2 files changed, 741 insertions(+), 54 deletions(-)

-- 
1.8.2.1
