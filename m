From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] ak8974 / ami305 magnetometer driver
Date: Fri, 27 Aug 2010 14:54:40 +0300
Message-ID: <1282910083-8629-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Patch set provides driver for ak8974 and ami305 3 axis magnetometer driver.
Data is provided via misc character device as a structure of data.
Driver supports regulator framework and has PM support.

Short documentation is also provided. Data format and sysfs interface
is shortly described in the documentation.

Provided data is raw magnetic field density for 3 axis. For compass
purposes data requires further processing.


Samu Onkalo (3):
  drivers: misc: ak8974 / ami305 magnetometer driver
  drivers: misc: ak8974 support to Kconfig and Makefile
  Documentation: Documentation for ak8974 magnetometer chip driver

 Documentation/misc-devices/ak8974 |   66 ++++
 drivers/misc/Kconfig              |   11 +
 drivers/misc/Makefile             |    1 +
 drivers/misc/ak8974.c             |  703 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c/ak8974.h        |   50 +++
 5 files changed, 831 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/misc-devices/ak8974
 create mode 100644 drivers/misc/ak8974.c
 create mode 100644 include/linux/i2c/ak8974.h
