From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v5 0/6] i2c: Host Notify / i801 fixes
Date: Thu, 13 Oct 2016 14:10:34 +0200
Message-ID: <1476360640-12901-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram and Dmitry,

5th revision of the series, hopefully this time it will be OK.

The changes were requested by Dmitry: now, SMBus Host Notify is transparent
for clients drivers. The IRQ is attributed if the adapter has the capability
and if nobody claimed an IRQ before. That means that adding an I2C device
through sysfs works, and we don't need to do anything in the client drivers
besides regular IRQ handling.

Cheers,
Benjamin

Benjamin Tissoires (6):
  i2c: i801: store and restore the SLVCMD register at load and unload
  i2c: i801: minor formatting issues
  i2c: i801: use BIT() macro for bits definition
  i2c: i801: use the BIT() macro for FEATURES_* also
  i2c: i801: remove SMBNTFDDAT reads as they always seem to return 0
  i2c: use an IRQ to report Host Notify events, not alert

 Documentation/i2c/smbus-protocol |  12 ++--
 drivers/i2c/Kconfig              |   1 +
 drivers/i2c/busses/i2c-i801.c    | 121 +++++++++++++++++++--------------------
 drivers/i2c/i2c-core.c           | 113 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-smbus.c          | 102 ---------------------------------
 include/linux/i2c-smbus.h        |  27 ---------
 include/linux/i2c.h              |   4 ++
 7 files changed, 185 insertions(+), 195 deletions(-)

-- 
2.7.4
