From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 0/3] i2c: Hookup typec power-negotation to the PMIC and charger
Date: Wed, 11 Oct 2017 11:41:18 +0200
Message-ID: <20171011094121.6108-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi All,

These are the last 3 patches from all my work to add support for
USB PD charging to Intel Cherry Trail devices with a Whiskey Cove PMIC
and fusb302 Type-C controller.

With these 3 patches these devices change from slowly discharging
at 5V 0.5A to actually charging at 12V 2A, so getting these upstream
is important for users of these devices.

Wolfram does not really have time to review the first 2 patches, so if
someone else (from the people in the Cc) can review the first 2 patches
and esp. the first patch, so that we can get this merged for 4.15, then
that would be great.

Regards,

Hans
