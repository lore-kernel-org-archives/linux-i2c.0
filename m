From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/2] i2c/of: Populate multiplexed i2c busses from the device tree.
Date: Wed, 31 Aug 2011 14:44:37 -0700
Message-ID: <1314827079-21245-1-git-send-email-david.daney@cavium.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Unchanged from the original RFC where I said:

  We need to populate our I2C devices from the device tree, but some
  of our systems have multiplexers which currently break this process.

  The basic idea is to have the generic i2c-mux framework propagate
  the device_node for the child bus into the corresponding
  i2c_adapter, and then call of_i2c_register_devices().  This means
  that the device tree bindings for *all* i2c muxes must have some
  common properties.  I try to document these in mux.txt.

This is now tested against 3.1.0-rc3 and seems to be working well.

David Daney (2):
  i2c: Add a struct device * parameter to i2c_add_mux_adapter()
  i2c/of: Automatically populate i2c mux busses from device tree data.

 Documentation/devicetree/bindings/i2c/mux.txt |   54 +++++++++++++++++++++++++
 drivers/i2c/i2c-mux.c                         |   44 ++++++++++++++++----
 drivers/i2c/muxes/gpio-i2cmux.c               |    3 +-
 drivers/i2c/muxes/pca9541.c                   |    3 +-
 drivers/i2c/muxes/pca954x.c                   |    2 +-
 include/linux/i2c-mux.h                       |    3 +-
 6 files changed, 96 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/mux.txt

-- 
1.7.2.3
