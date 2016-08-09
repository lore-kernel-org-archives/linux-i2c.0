From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v4 0/2] Add support for the TI SM-USB-DIG
Date: Tue, 9 Aug 2016 09:55:15 -0500
Message-ID: <20160809145517.22815-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:39447 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbcHIOzX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 9 Aug 2016 10:55:23 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>

Hello all,

This series adds initial support for the TI SM-USB-DIG, this is a USB
to I2C/SPI/1Wire/GPIO adapter, we only add support for I2C here, drivers
for the other protocols are still in the works.

Thanks,
Andrew

Changes from v3:
 - Rebased on v4.8-rc1
 - Added this cover letter to track series changes

Changes from v2:
 - Rename sm-usb-dig -> ti-smusbdig
 - Inline helper functions in header
 - Alphabetize includes

Changes from v1:
 - Added missing dependency on USB to Kconfig

Andrew F. Davis (2):
  mfd: ti-smusbdig: Add support for the TI SM-USB-DIG
  i2c: ti-smusbdig: add TI SM-USB-DIG I2C bus driver

 drivers/i2c/busses/Kconfig           |  10 ++
 drivers/i2c/busses/Makefile          |   1 +
 drivers/i2c/busses/i2c-ti-smusbdig.c | 189 +++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                  |   9 ++
 drivers/mfd/Makefile                 |   2 +
 drivers/mfd/ti-smusbdig.c            | 138 +++++++++++++++++++++++++
 include/linux/mfd/ti-smusbdig.h      |  75 ++++++++++++++
 7 files changed, 424 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-ti-smusbdig.c
 create mode 100644 drivers/mfd/ti-smusbdig.c
 create mode 100644 include/linux/mfd/ti-smusbdig.h

-- 
2.9.2
