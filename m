From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 0/4] i2c-multi-instantiate pseudo driver
Date: Thu,  9 Aug 2018 13:40:42 +0200
Message-ID: <20180809114046.21366-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi All,

Here is v6 of my patch-series for dealing with multiple independent i2c
devices being described in a single ACPI fwnode.

Changes in v6:
-Added some Reviewed-by and Acked-by-s to patches 2-4
-4th patch "platform/x86: Add ACPI i2c-multi-instantiate pseudo driver":
 -s/irq_idx/gpio_irq_idx/

Changes in v5:
-Only changes in the 4th patch "platform/x86: Add ACPI i2c-multi-instantiate pseudo driver":
 -s/no_clients/num_clients/

Changes in v4:
-Rewrite commit message of first patch as this is NOT a bug fix for
 acpi_is_indirect_io_slave() as I thought at first, it is still necessary
 as a preperation patch for the rest of the series
-MAINTAINER and Kconfig entry fixes
-Some minor coding style fixes

Changes in v3:
-Drop the patch adding the I2C_CLIENT_IGNORE_BUSY flag/hack
-Add patches to make ACPI fwnode-s with affected acpi_ids get enumerated as
 platform device instead of i2c-client
-Change the i2c-multi-instantiate driver to a platform driver

Changes in v2:
-Rebase on 4.18-rc2

Changes in v1:
-Second attempt at dealing with this using a new design where a separate
 driver (which can be build as a module) is used to instantiate the
 i2c-clients instead of modifying the i2c core
-Add an I2C_CLIENT_IGNORE_BUSY flag to make it possible for this driver to bind
 to the client instantiated for the first i2c resource and still create a new
 client using the i2c_client_id for the actual driver for the first resource,
 resulting in 2 clients at the same address (of which one is inactive)

Regards,

Hans
