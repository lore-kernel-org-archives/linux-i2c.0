From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 0/4] i2c-core improvements for acpi devices + ACPI INT33FE driver
Date: Wed,  5 Apr 2017 00:03:31 +0200
Message-ID: <20170404220335.9815-1-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi All,

Here is v5 of my patch-set for my i2c-core improvements for acpi
devices + the ACPI INT33FE platform driver.

New in this version are some minor fixed to the INT33FE driver.

The INT33FE driver depends on the i2c-core changes, so if
it is ok with Darren / Andy I believe it would be best for
this driver to be merged through the i2c subsys tree (with
their ack).

Regards,

Hans
