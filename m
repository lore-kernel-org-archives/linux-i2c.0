From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] video: move include files out of include/linux/i2c
Date: Mon, 22 May 2017 00:09:51 +0200
Message-ID: <20170521220953.2602-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55522 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752186AbdEUWJ5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 21 May 2017 18:09:57 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, adi-buildroot-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

It doesn't make sense to use include/linux/i2c for client drivers which may in
fact rather be hwmon or input or whatever devices. As a result, I want to
deprecate include/linux/i2c for good. This series moves the include files to a
better location, largely include/linux/platform_data because that is what most
of the moved include files contain. Note that some files don't seem to have
upstream users in board code, so they maybe could even be removed? I didn't
check for that now, but I did it for one i2c master driver recently. So, it may
be possible.

I prefer the series to go upstream via the subsystem tree; if you prefer that I
take it via I2C, just let me know.

No runtime testing because of no HW, but buildbot is happy with this series at
least. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_data

Thanks and kind regards,

   Wolfram


Wolfram Sang (2):
  video: adp8860: move header file out of I2C realm
  video: adp8870: move header file out of I2C realm

 arch/blackfin/mach-bf537/boards/stamp.c        | 4 ++--
 drivers/video/backlight/adp8860_bl.c           | 2 +-
 drivers/video/backlight/adp8870_bl.c           | 2 +-
 include/linux/{i2c => platform_data}/adp8860.h | 0
 include/linux/{i2c => platform_data}/adp8870.h | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename include/linux/{i2c => platform_data}/adp8860.h (100%)
 rename include/linux/{i2c => platform_data}/adp8870.h (100%)

-- 
2.11.0
