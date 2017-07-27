From: divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Subject: [PATCH 0/3] enable new "size" property and runtime pm
Date: Thu, 27 Jul 2017 22:13:06 +0530
Message-ID: <1501173789-25959-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

This series adds support for new "size" property which will be read by the
driver for eeprom size. The existing ACPI has a different default size which
can be overridden with a DSD property value provided by the platform FW.

This series also adds support for runtime PM. The eeprom driver currently
did not have support for runtime PM and the device was kept in D0 throughout.

Divagar Mohandass (3):
  dt-bindings: add "size" property.
  eeprom: at24: add support to fetch device property "size"
  eeprom: at24: enable runtime pm support

 .../devicetree/bindings/eeprom/eeprom.txt          |  2 ++
 drivers/misc/eeprom/at24.c                         | 38 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
