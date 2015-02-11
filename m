From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv2 0/5] i2c: i801: Few cleanups
Date: Wed, 11 Feb 2015 14:32:03 +0200
Message-ID: <1423657928-25534-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean

Patches 2-3/5 are otherwise the same I sent last week but now on top
of 1/5.

Jarkko Nikula (5):
  i2c: i801: Don't break user-visible strings
  i2c: i801: Remove i801_driver forward declaration
  i2c: i801: Use managed devm_* memory and irq allocation
  i2c: i801: Remove pci_enable_device() call from i801_resume()
  i2c: i801: Use managed pcim_* PCI device initialization and
    reservation

 drivers/i2c/busses/i2c-i801.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

-- 
2.1.4
