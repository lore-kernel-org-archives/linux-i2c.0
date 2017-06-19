From: thor.thayer@linux.intel.com
Subject: [PATCHv4 0/3] Add Altera I2C Controller Driver
Date: Mon, 19 Jun 2017 15:36:55 -0500
Message-ID: <1497904618-27010-1-git-send-email-thor.thayer@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33354 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbdFSUdu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 16:33:50 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, thor.thayer@linux.intel.com
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patch series adds the Altera I2C Controller driver for use in FPGAs.
The device tree patch was removed in this version because this I2C is not
the default I2C master.

Thor Thayer (3):
  MAINTAINERS: Add Altera I2C Controller Driver
  dt-bindings: i2c: Add Altera I2C Controller
  i2c: altera: Add Altera I2C Controller driver

 .../devicetree/bindings/i2c/i2c-altera.txt         |  39 ++
 MAINTAINERS                                        |   5 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-altera.c                    | 511 +++++++++++++++++++++
 5 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt
 create mode 100644 drivers/i2c/busses/i2c-altera.c

-- 
2.7.4
