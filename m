From: alanx.chiang@intel.com
Subject: [PATCH v3 0/2] Add a property in at24.c
Date: Wed, 27 Jun 2018 13:46:23 +0800
Message-ID: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: andy.yeh@intel.com, sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Alan Chiang <alanx.chiang@intel.com>
List-Id: linux-i2c@vger.kernel.org

From: Alan Chiang <alanx.chiang@intel.com>

In at24.c, it uses 8-bit addressing by default. In this patch,
add a property address-width that provides a flexible method to
pass the information to the driver.

Alan Chiang (2):
  dt-bindings: at24: Add address-width property
  eeprom: at24: Add support for address-width property

 Documentation/devicetree/bindings/eeprom/at24.txt |  2 ++
 drivers/misc/eeprom/at24.c                        | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.7.4
