From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/4] i2c: fix i2c adapter device driver user counter
Date: Mon, 27 Jul 2015 17:30:47 +0300
Message-ID: <1438007451-8553-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The series fixes i2c bus device refcounting for clients of i2c_get_adapter(),
of_find_i2c_adapter_by_node() and of_find_i2c_device_by_node() interfaces.

The v2 3/4 change adds and exports new of_get_i2c_adapter_by_node()
interface of i2c core, v2 4/4 is an unchanged version of v1 10/10, which
utilizes this new interface in order to fix the refcounting bug described
below in detail.

of_find_i2c_adapter_by_node() call requires quite often missing
put_device(), and i2c_put_adapter() releases a device locked by
i2c_get_adapter() only. In general module_put(adapter->owner) and
put_device(dev) are not interchangeable.

This is a common error reproduction scenario as a result of the
misusage described above (this is run on iMX6 platform with
HDMI and I2C bus drivers compiled as kernel modules for clearness):

    root@mx6q:~# lsmod | grep i2c
    i2c_imx                10213  0
    root@mx6q:~# lsmod | grep dw_hdmi_imx
    dw_hdmi_imx             3631  0
    dw_hdmi                11846  1 dw_hdmi_imx
    imxdrm                  8674  3 dw_hdmi_imx,imx_ipuv3_crtc,imx_ldb
    drm_kms_helper        113765  5 dw_hdmi,imxdrm,imx_ipuv3_crtc,imx_ldb
    root@mx6q:~# rmmod dw_hdmi_imx
    root@mx6q:~# lsmod | grep i2c
    i2c_imx                10213  -1

                                 ^^^^^

    root@mx6q:~# rmmod i2c_imx
    rmmod: ERROR: Module i2c_imx is in use

To fix existing users of these interfaces and to avoid any further
confusion and misusage in future, add one more interface
of_get_i2c_adapter_by_node(), it is similar to i2c_get_adapter() in
sense that an I2C bus device driver found and locked by user can be
correctly unlocked by i2c_put_adapter().

Mainly the change is addressed to multiple DRM users of I2C bus device
interfaces, but at the moment just one client inside drivers/i2c/* is fixed.

The change is based on Wolfram's i2c/for-next branch, 19e0ff42338

Changes from v1 to v2:
* added two more patches 1/4 and 2/4 fixing i2c bus device refcounting,
  thanks to Thierry for the idea of 2/4 change,
* rebased v1 1/10 on top of v2 1/4 and v2 2/4, removed put_device()
  from of_get_i2c_adapter_by_node() as suggested by Thierry,
* defer changes in 8 broken DRM and fbdev clients until i2c-core changes
  are added to linux-next (or preferably 4.2.0-rc Linus' branch, if possible)
  to improve signal/noise ratio on mailing lists.

v1 of the series with fixes on client side can be found at
  http://permalink.gmane.org/gmane.linux.drivers.i2c/23652

RFC of the v1 01/10 change is http://www.spinics.net/lists/linux-i2c/msg20257.html

Vladimir Zapolskiy (4):
  i2c: core: fix leaked device refcount on of_find_i2c_* error path
  i2c: core: manage i2c bus device refcount in i2c_[get|put]_adapter
  i2c: core: add and export of_get_i2c_adapter_by_node() interface
  i2c: arb-gpio-challenge: use of_get_i2c_adapter_by_node interface

 drivers/i2c/i2c-core.c                     | 53 +++++++++++++++++++++++++-----
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c |  3 +-
 include/linux/i2c.h                        |  7 ++++
 3 files changed, 53 insertions(+), 10 deletions(-)

-- 
2.1.4
