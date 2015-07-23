From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 0/3] I2C/SMBus: add support for Host Notify (in i2c_i801)
Date: Thu, 23 Jul 2015 14:55:15 -0400
Message-ID: <1437677718-7894-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

this is the v4 of this patch series which fixes the race we discovered this
week when accessing the registers in i2c_i801.

Compared to v3, i2c_handle_smbus_host_notify can now be called in a non sleeping
thread because a worker will be spawn later on.
That also means that we need to allocate the worker and some other structures,
so I introduced i2c_setup_smbus_host_notify().

Cheers,
Benjamin


Benjamin Tissoires (3):
  i2c: add a protocol parameter to the alert callback
  i2c-smbus: add SMBus Host Notify support
  i2c: i801: add support of Host Notify

 Documentation/i2c/smbus-protocol |   3 +
 drivers/char/ipmi/ipmi_ssif.c    |   6 +-
 drivers/hwmon/lm90.c             |   3 +-
 drivers/i2c/busses/i2c-i801.c    | 164 +++++++++++++++++++++++++++++----------
 drivers/i2c/i2c-smbus.c          | 113 +++++++++++++++++++++++++--
 include/linux/i2c-smbus.h        |  43 ++++++++++
 include/linux/i2c.h              |  10 ++-
 include/uapi/linux/i2c.h         |   1 +
 8 files changed, 292 insertions(+), 51 deletions(-)

-- 
2.4.3
