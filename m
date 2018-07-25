From: alanx.chiang@intel.com
Subject: [RESEND PATCH v4 0/2] Add aproperty in at24.c
Date: Wed, 25 Jul 2018 11:20:20 +0800
Message-ID: <1532488822-5622-1-git-send-email-alanx.chiang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: andy.yeh@intel.com, sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, rpjday@crashcourse.ca, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Alan Chiang <alanx.chiang@intel.com>
List-Id: linux-i2c@vger.kernel.org

From: Alan Chiang <alanx.chiang@intel.com>

The RESEND PATCH modifies the commit message and adds the Reviewed-by.

In at24.c, it uses 8-bit addressing by default. In this patch add a
property address-width that provides a flexible method to pass the
information to the driver.

Alan Chiang (2):
  dt-bindings: at24: Add address-width property
  eeprom: at24: Add support for address-width property

 Documentation/devicetree/bindings/eeprom/at24.txt |  2 ++
 drivers/misc/eeprom/at24.c                        | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

-- 
2.7.4
