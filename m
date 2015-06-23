From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/2] I2C/SMBus: add support for Host Notify in i2c_i801
Date: Tue, 23 Jun 2015 14:58:17 -0400
Message-ID: <1435085899-11017-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

I am currently working on the Synaptics touchpads that can be found on many
Lenovo laptops. These touchpads are capable of talking over the PS/2 bus but
also over SMBus. The PS/2 bus is somewhat limited in what it allows to do
and using the SMBus protocol would allow us to be close to what the Windows
driver implements (and thus benefit from the firmware QA that is made for this
system).

The current WIP is posted here:
https://github.com/bentiss/linux branch synaptics-rmi4-smbus-v4.1-15-06-23

We are still missing a few bits here and there to actually switch the default
to this driver (PS/2 pass-through for example), so I am splitting the series
in the hope of receiving feedbacks earlier.

The Synaptics touchpads are using the SMBus Host Notification feature which an
implementation is proposed in this series.
I am not sure if the Host Notification feature can be emulated by all
controllers so I based my work on what is available on the i801 PCH: an hardware
feature introduced in ICH 3.

Any comments welcome!

Cheers,
Benjamin

Benjamin Tissoires (2):
  i2c: add SMBus Host Notify support
  i2c: i801: add support of Host Notify

 Documentation/i2c/smbus-protocol |   4 +
 drivers/i2c/busses/i2c-i801.c    | 223 +++++++++++++++++++++++++++++++--------
 drivers/i2c/i2c-core.c           |  60 +++++++++++
 drivers/i2c/i2c-smbus.c          |  17 +--
 include/linux/i2c.h              |  11 ++
 include/uapi/linux/i2c.h         |   1 +
 6 files changed, 256 insertions(+), 60 deletions(-)

-- 
2.4.3
