From: thor.thayer@linux.intel.com
Subject: [PATCH 0/3] Add Altera I2C Controller Driver
Date: Tue, 11 Apr 2017 11:02:24 -0500
Message-ID: <1491926547-29510-1-git-send-email-thor.thayer@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:50637 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752757AbdDKP7Y (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 11 Apr 2017 11:59:24 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh@kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the Altera I2C Controller driver for use in FPGAs.

Thor Thayer (3):
  MAINTAINERS: Add Altera I2C Controller Driver
  Documentation: dt: i2c: Add Altera I2C Controller
  i2c: altera: Add Altera I2C Controller driver

 .../devicetree/bindings/i2c/i2c-altera.txt         |  37 ++
 MAINTAINERS                                        |   5 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-altera.c                    | 509 +++++++++++++++++++++
 5 files changed, 562 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt
 create mode 100644 drivers/i2c/busses/i2c-altera.c

-- 
1.9.1
