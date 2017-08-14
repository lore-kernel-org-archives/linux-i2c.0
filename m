From: Divagar Mohandass <divagar.mohandass@intel.com>
Subject: [PATCH v2 0/3] enable eeprom "size" property and runtime pm
Date: Tue, 15 Aug 2017 00:11:56 +0530
Message-ID: <1502736119-32084-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, Divagar Mohandass <divagar.mohandass@intel.com>
List-Id: linux-i2c@vger.kernel.org

This series adds support for eeprom "size" property which will be read by the
driver for eeprom size. The existing ACPI has a different default size which
can be overridden with a DSD property value provided by the platform FW.

This series also adds support for runtime PM. The eeprom driver currently
did not have support for runtime PM and the device was kept in D0 throughout.

[v1]
- Add support for eeprom "size" property.
- Add runtime PM support to the driver.

[v2]
- Improved the patch subject.


Divagar Mohandass (3):
  dt-bindings: add eeprom "size" property
  eeprom: at24: add support to fetch eeprom device property "size"
  eeprom: at24: enable runtime pm support

 .../devicetree/bindings/eeprom/eeprom.txt          |  2 ++
 drivers/misc/eeprom/at24.c                         | 38 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
1.9.1
