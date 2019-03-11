From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/2] intel-lpss-pci-i2c: Fix oops when there is no ACPI fwnode
Date: Mon, 11 Mar 2019 12:22:14 +0100
Message-ID: <20190311112216.31391-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi All,

Here is a patch series fixing an oops when there is no ACPI fwnode
associated with a PCI enumerated LPSS I2C controller:
https://bugzilla.redhat.com/show_bug.cgi?id=1687065

This is fixed by the first patch in this series, which modifies
i2c-designware-platdrv.c to fix this. The fix is enabled conditionally
because otherwise it might break things on platforms where i2c-designware
controllers are enumerated through e.g. devicetree.

The second patch modifies intel-lpss-pci.c to pass the new
"linux,use-dynamic-adapter-nr" devicetree property to activate the fix.

The first patch should be merged first, so that the devicetree prop name
is "stable", then the second patch can be merged independently through the
mfd tree.

Regards,

Hans
