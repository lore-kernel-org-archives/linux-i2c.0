From: Divagar Mohandass <divagar.mohandass@intel.com>
Subject: [PATCH v3 0/3] enable eeprom "size" property and runtime pm
Date: Wed, 30 Aug 2017 09:41:03 +0530
Message-ID: <1504066266-30051-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39328 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750723AbdH3EK5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 30 Aug 2017 00:10:57 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, sakari.ailus@iki.fi
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, Divagar Mohandass <divagar.mohandass@intel.com>

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

[v3]
- Addressed comments from Sakari Ailus.
- Improved patch description.
- Improved pm support patch.

Divagar Mohandass (3):
  dt-bindings: add eeprom "size" property
  eeprom: at24: add support to fetch eeprom device property "size"
  eeprom: at24: enable runtime pm support

 .../devicetree/bindings/eeprom/eeprom.txt          |  2 +
 drivers/misc/eeprom/at24.c                         | 43 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)

-- 
1.9.1
