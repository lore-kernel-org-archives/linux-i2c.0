From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] convert parport to device-model
Date: Wed, 15 Apr 2015 13:18:40 +0530
Message-ID: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Willy Tarreau <willy-859RlTSWH48dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As suggested by Greg, new functions were introduced in the parport
subsystem which will use the device-model and we convert the drivers
one by one. So accordingly we now have parport_register_drv(), 
parport_register_dev() and attach_ret() which are using the device-model.
And we have a flag to indicate if the driver has registered using this
new api, and based on that flag other functions are behaving.

The registration of ports is using the device-model and we now will have
/sys/bus/parport and as and when new ports are discovered they will be
added to the tree.

The drivers after converting to the device-model will register their
device as an subdevice under the relevant port it is using and when they
claim the port the actual binding between the device and the driver will
take place.

Greg also suggested to use a probe function in the drivers which will
return 0 for automatic binding, but since we do not have specific
deviceid for many parallel port devices so I was not sure what the
logic will be in the probe to identify and match the device. So instead
I thought of using device_attach() for the actual binding.

As of now only two drivers have been converted, i2c-parport which
Jean says he can test, and staging/panel which i can test as I have
the hardware for LCD part.

The zip-driver is stil not converted, but still cc-ing
gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org if he can please check the zip drive to know
if the changes are not breaking the drivers which have not yet been
converted.

I am also in the process of procuring a parallel port printer so that
the code can properly be maintained and can be marked as Maintained.

Sudip Mukherjee (4):
  parport: modify parport subsystem to use devicemodel
  parport: update TODO and documentation
  i2c-parport: use device-model parport
  staging: panel: use parport in device-model

 Documentation/parport-lowlevel.txt |  49 ++++++++
 drivers/i2c/busses/i2c-parport.c   |  19 +--
 drivers/parport/TODO-parport       |   4 +
 drivers/parport/procfs.c           |  15 ++-
 drivers/parport/share.c            | 236 +++++++++++++++++++++++++++++++++++--
 drivers/staging/panel/panel.c      |  20 ++--
 include/linux/parport.h            |  29 ++++-
 7 files changed, 343 insertions(+), 29 deletions(-)

-- 
1.8.1.2
