From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 0/10] Fixes and API additions for firmware nodes
Date: Tue, 30 Jun 2015 16:54:58 +0200
Message-ID: <1435676108-20590-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, devicetree@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, devel@acpica.org
List-Id: linux-i2c@vger.kernel.org

Hi,

this series makes it possible to extract device dependencies from firmware data
with fwnode, thus not depending on the particular format of that data.

The first patches are about making sure that we can reach the fwnode
handle of the firmware data associated with a given device, and the rest
add API that makes dependency extraction possible.

Thanks,

Tomeu


Tomeu Vizoso (10):
  of/platform: Set fwnode field for new devices
  i2c: core: Have clients point to their firmware nodes
  mfd: Have child devices point to their firmware nodes
  device property: add fwnode_get_parent()
  device property: add fwnode_get_name()
  ACPI / scan: Add acpi_dev_get_next_child()
  device property: Add fwnode_get_next_child_node()
  device property: add fwnode_is_compatible()
  device: property: add fwnode_driver_match_device()
  core: platform: use fwnode_driver_match_device()

 drivers/acpi/scan.c      |  5 +--
 drivers/base/platform.c  |  8 +---
 drivers/base/property.c  | 95 ++++++++++++++++++++++++++++++++++++++++++++----
 drivers/i2c/i2c-core.c   |  1 +
 drivers/mfd/mfd-core.c   |  1 +
 drivers/of/platform.c    |  1 +
 include/acpi/acpi_bus.h  |  5 +++
 include/linux/acpi.h     | 22 ++++++++++-
 include/linux/property.h | 17 +++++++++
 9 files changed, 136 insertions(+), 19 deletions(-)

-- 
2.4.1

