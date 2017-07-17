From: thor.thayer@linux.intel.com
Subject: [PATCHv5 0/3] Add Altera I2C Controller Driver
Date: Mon, 17 Jul 2017 11:35:11 -0500
Message-ID: <1500309314-18464-1-git-send-email-thor.thayer@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:14257 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbdGQQcP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 17 Jul 2017 12:32:15 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, thor.thayer@linux.intel.com
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patch series adds the Altera I2C Controller driver for use in FPGAs.
This version includes cleanup and a bug fix noticed by the Linux
community.

Thor Thayer (3):
  MAINTAINERS: Add Altera I2C Controller Driver
  dt-bindings: i2c: Add Altera I2C Controller
  i2c: altera: Add Altera I2C Controller driver

 .../devicetree/bindings/i2c/i2c-altera.txt         |  39 ++
 MAINTAINERS                                        |   5 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-altera.c                    | 510 +++++++++++++++++++++
 5 files changed, 565 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt
 create mode 100644 drivers/i2c/busses/i2c-altera.c

-- 
2.7.4
