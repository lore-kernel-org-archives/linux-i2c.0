From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 0/4] ACPI bugfix + i2c-multi-instantiate pseudo driver
Date: Tue,  7 Aug 2018 10:05:35 +0200
Message-ID: <20180807080539.17811-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi All,

So here is my third attempt at dealing with multiple i2c devices being
described in a single ACPI fwnode.

Like the second attemp This is still based on having a special driver for
these corner cases which can be a module and only loaded when on hardware
which needs this.

New this time around is that this now is a platform driver, avoiding the
need for the I2C_CLIENT_IGNORE_BUSY hack and having 2 i2c-clients at
the address of the first i2c ACPI resource.

While working on the ACPI changes for enumerating ACPI nodes which
are handled by the new i2c-multi-instantiate driver as platform devices
I found a bug caused by a combination of my:
"ACPI / scan: Use acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs"
and the somewhat (but not much) later added:
"ACPI / scan: Do not enumerate Indirect IO host children"
commits, specifically the second one does not work because of the first
one, I guess it was tested against a kernel without the first commit.
My changes for enumerating relevant ACPI nodes as platform devices
hit the same problem.

Thus the first patch of this series is an ACPI bugfix for that problem.
The second patch changes acpi/scan.c to enumerate relevant ACPI nodes as
platform devices.
The third patch is an ACPI cleanup patch made possible by the first patch.
All 3 these patches are new in this version of this series.

And finally the fourth patch is the actual i2c-multi-instantiate driver,
now as platform driver living under drivers/platform/x86 .

Regards,

Hans
