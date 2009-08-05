From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/4] Convert i2c adapters from class devices to bus devices
Date: Wed, 5 Aug 2009 11:05:37 +0200
Message-ID: <20090805110537.73735169@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As Kay Sievers explained that i2c adapters should be bus devices rather
than class devices, convert them.

[PATCH 1/4] Add support for compatibility classes
[PATCH 2/4] i2c: Convert i2c clients to a device type
[PATCH 3/4] i2c: Convert i2c adapters to bus devices
[PATCH 4/4] i2c: Provide compatibility links for i2c adapters

 drivers/base/class.c   |   87 +++++++++++++++++++++++++
 drivers/i2c/Kconfig    |    8 ++
 drivers/i2c/i2c-core.c |  165 +++++++++++++++++++++++++++++++++----------------
 include/linux/device.h |    8 ++
 4 files changed, 217 insertions(+), 51 deletions(-)

Care has been taken to not break user-space compatibility. I have also
updated libsensors and sensors-detect already to look for i2c adapters
in /sys/bus/i2c/devices rather than /sys/class/i2c-adapter. I am not
aware of other user-space applications or libraries using
/sys/class/i2c-adapter, but if you do please tell me.

Improvements are possible on the power management side, but I did not
have the time to deal with this now, so this is left for later.

-- 
Jean Delvare
