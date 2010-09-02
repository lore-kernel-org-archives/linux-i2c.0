From: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v2 0/2] i2c: QUP based bus driver for Qualcomm MSM chipsets
Date: Thu,  2 Sep 2010 17:44:18 -0600
Message-ID: <1283471059-22262-1-git-send-email-kheitke@codeaurora.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

These patches incorporated requested changes from the v1 revision.

[PATCH 1/2] is for the header file that defines the platform data used
by the driver.  This patch can be picked up by the i2c maintainers but
also needs to be acked by the msm maintainers (linux-arm-msm).

[PATCH 2/2] contains the QUP I2C driver.

Revision history:
v2: incorporated feedback from the following people:
	ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
	srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org
	tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org

Kenneth Heitke (2):
  msm: i2c: Add msm_qup_i2c.h
  i2c: QUP based bus driver for Qualcomm MSM chipsets

 arch/arm/mach-msm/include/mach/msm_qup_i2c.h |   28 +
 drivers/i2c/busses/Kconfig                   |   12 +
 drivers/i2c/busses/Makefile                  |    1 +
 drivers/i2c/busses/i2c-qup.c                 | 1105 ++++++++++++++++++++++++++
 4 files changed, 1146 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-msm/include/mach/msm_qup_i2c.h
 create mode 100644 drivers/i2c/busses/i2c-qup.c

--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
