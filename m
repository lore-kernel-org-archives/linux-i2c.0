From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/3] I2C/SMBus: add support for Host Notify (in i2c_i801)
Date: Thu,  9 Jul 2015 13:30:49 -0400
Message-ID: <1436463052-6944-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

this is a v2 of this patch series. Things are starting to shape better I think,
but I am still not sure about one or two things:
- do we want to #ifdef i2c_propagate_smbus_host_notify() so that we do not add
  a dependency in the KConfig for i2c_i801, or do actually want the dependency?
- do we want to have i2c_propagate_smbus_host_notify() to actually be able to
  sleep or do we prefer calling it directly a worker?

Note that I only compile-tested the ipmi_ssif changes, but this seems
straightforward enough.

Thanks for your inputs.

Cheers,
Benjamin

Benjamin Tissoires (3):
  i2c: add a protocol parameter to the alert callback
  i2c-smbus: add SMBus Host Notify support
  i2c: i801: add support of Host Notify

 Documentation/i2c/smbus-protocol |   3 +
 drivers/char/ipmi/ipmi_ssif.c    |   6 +-
 drivers/i2c/busses/i2c-i801.c    | 172 +++++++++++++++++++++++++++++----------
 drivers/i2c/i2c-smbus.c          |  35 +++++++-
 include/linux/i2c-smbus.h        |   8 ++
 include/linux/i2c.h              |  10 ++-
 include/uapi/linux/i2c.h         |   1 +
 7 files changed, 186 insertions(+), 49 deletions(-)

-- 
2.4.3
