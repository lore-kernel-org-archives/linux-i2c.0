From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 0/3] iProc I2C driver enhancement
Date: Fri, 12 Feb 2016 13:10:40 -0800
Message-ID: <1455311443-30590-1-git-send-email-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>, Ray Jui <rjui@broadcom.com>, Ray Jui <ray.jui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

This patch series 1) adds recovery support to the I2C host controller; 2) fix
a typo in the driver; and 3) adds support for large TX payload size

This patch series is based on Linux v4.5-rc1 and is available at:

repo: https://github.com/Broadcom/cygnus-linux.git
branch: iproc-i2c-large-tx-v2

Changes from v1:
 - Get rid of redundant function prototypes by placing functions in the right
order
 - Get rid of redundant setting of member 'max_write_len' from
'struct i2c_adapter_quirks'

Ray Jui (3):
  i2c: iproc: Add recovery mechanism in error case
  i2c: iproc: Fix typo in the driver
  i2c: iproc: Support larger TX transfer

 drivers/i2c/busses/i2c-bcm-iproc.c | 177 ++++++++++++++++++++++++++-----------
 1 file changed, 124 insertions(+), 53 deletions(-)

-- 
1.9.1
