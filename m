From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/3] i2c: i801: Fix iTCO_wdt resource creation if PMC is not present
Date: Tue, 25 Feb 2020 15:37:59 +0300
Message-ID: <20200225123802.88984-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Martin Volf <martin.volf.42@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

This series aims to fix the issue reported by Martin Volf [1] that prevents
the nct6775 driver from loading.

I added Fixes tag to the last patch but not stable tag because the other
two patches it depends are not really stable material IMO. Please let me
know if there is a better way to organize these :)

[1] https://lore.kernel.org/linux-hwmon/CAM1AHpQ4196tyD=HhBu-2donSsuogabkfP03v1YF26Q7_BgvgA@mail.gmail.com/

Mika Westerberg (3):
  watchdog: iTCO_wdt: Export vendorsupport
  watchdog: iTCO_wdt: Make ICH_RES_IO_SMI optional
  i2c: i801: Do not add ICH_RES_IO_SMI if PMC device is not present

 drivers/i2c/busses/i2c-i801.c          | 45 +++++++++++++++-----------
 drivers/watchdog/iTCO_vendor.h         |  2 ++
 drivers/watchdog/iTCO_vendor_support.c | 16 +++++----
 drivers/watchdog/iTCO_wdt.c            | 22 +++++++------
 4 files changed, 51 insertions(+), 34 deletions(-)

-- 
2.25.0
