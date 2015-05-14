From: Ray Jui <rjui@broadcom.com>
Subject: [PATCH v2] Add suspend/resume support to the iProc I2C driver
Date: Thu, 14 May 2015 15:36:03 -0700
Message-ID: <1431642964-6948-1-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

Sorry I made a mistake in the previous patch (v1).

Changes from v1:
 - Fixed a compiling issue in the driver when suspend/resume support is added

Ray Jui (1):
  i2c: iproc: Add suspend/resume support

 drivers/i2c/busses/i2c-bcm-iproc.c |   57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

-- 
1.7.9.5
