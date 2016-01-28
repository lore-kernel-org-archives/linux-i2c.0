From: Ray Jui <rjui@broadcom.com>
Subject: [PATCH 0/3] iProc I2C driver enhancement
Date: Wed, 27 Jan 2016 16:27:19 -0800
Message-ID: <1453940842-9658-1-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>, Ray Jui <rjui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

This patch series 1) adds recovery support to the I2C host controller; 2) fix
a typo in the driver; and 3) adds support for large TX payload size

This patch series is based on Linux v4.5-rc1 and is available at:

repo: https://github.com/Broadcom/cygnus-linux.git
branch: iproc-i2c-large-tx

Ray Jui (3):
  i2c: iproc: Add recovery mechanism in error case
  i2c: iproc: Fix typo in the driver
  i2c: iproc: Support larger TX transfer

 drivers/i2c/busses/i2c-bcm-iproc.c | 97 ++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 10 deletions(-)

-- 
1.9.1
