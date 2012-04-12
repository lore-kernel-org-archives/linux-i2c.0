From: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/2] i2c/of: Populate multiplexed i2c busses from the device tree.
Date: Thu, 12 Apr 2012 14:14:21 -0700
Message-ID: <1334265263-13549-1-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "Jean Delvare (PC drivers core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

v3: Integrate changes from Lars-Peter Clausen to make better use of
    the of_*() infrastructure.  Get rid of ugly #ifdefs.

v2: Update bindings to use "reg" insutead of "cell-index"

v1: Unchanged from the original RFC where I said:

  We need to populate our I2C devices from the device tree, but some
  of our systems have multiplexers which currently break this process.

  The basic idea is to have the generic i2c-mux framework propagate
  the device_node for the child bus into the corresponding
  i2c_adapter, and then call of_i2c_register_devices().  This means
  that the device tree bindings for *all* i2c muxes must have some
  common properties.  I try to document these in mux.txt.

This is now tested against 3.4-rc2 and is still working well.

David Daney (2):
  i2c: Add a struct device * parameter to i2c_add_mux_adapter()
  i2c/of: Automatically populate i2c mux busses from device tree data.

 Documentation/devicetree/bindings/i2c/mux.txt |   60 +++++++++++++++++++++++++
 drivers/i2c/i2c-mux.c                         |   43 ++++++++++++++----
 drivers/i2c/muxes/gpio-i2cmux.c               |    3 +-
 drivers/i2c/muxes/pca9541.c                   |    3 +-
 drivers/i2c/muxes/pca954x.c                   |    2 +-
 include/linux/i2c-mux.h                       |    3 +-
 6 files changed, 101 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/mux.txt

Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
-- 
1.7.2.3
