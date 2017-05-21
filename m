From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/1] gpu: move include files out of include/linux/i2c
Date: Mon, 22 May 2017 00:11:13 +0200
Message-ID: <20170521221114.2685-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55540 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752665AbdEUWLR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 21 May 2017 18:11:17 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

It doesn't make sense to use include/linux/i2c for client drivers which may in
fact rather be hwmon or input or whatever devices. As a result, I want to
deprecate include/linux/i2c for good. This series moves the include files to a
better location, largely include/linux/platform_data because that is what most
of the moved include files contain. Please let me know if you think another
location is more suitable.

I prefer the series to go upstream via the subsystem tree; if you prefer that I
take it via I2C, just let me know.

No runtime testing because of no HW, but buildbot is happy with this series at
least. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_data

Thanks and kind regards,

   Wolfram


Wolfram Sang (1):
  gpu: drm: tc35876x: move header file out of I2C realm

 arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c | 2 +-
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c                  | 2 +-
 include/linux/{i2c => platform_data}/tc35876x.h             | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/{i2c => platform_data}/tc35876x.h (100%)

-- 
2.11.0
