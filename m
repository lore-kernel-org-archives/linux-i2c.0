From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] i2c: move include files out of include/linux/i2c
Date: Sun, 21 May 2017 22:37:41 +0200
Message-ID: <20170521203743.6514-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55098 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753915AbdEUUhr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 21 May 2017 16:37:47 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org

It doesn't make sense to use include/linux/i2c for client drivers which may in
fact rather be hwmon or input or whatever devices. As a result, I want to
deprecate include/linux/i2c for good. This series moves the include files to a
better location, largely include/platform_data because that is what most of the
moved include files contain. Note that some files don't seem to have upstream
users in board code, so they maybe could even be removed? I didn't check for
that now, but I did it for one i2c master driver recently. So, it may be
possible.

And while i2c muxes might be a corner case, I still want to deprecate
include/linux/i2c for good ;)

No runtime testing because of no HW, but buildbot is happy with this series at
least. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_data

Thanks and kind regards,

   Wolfram


Wolfram Sang (2):
  i2c: mux: pca954x: move header file out of I2C realm
  i2c: mux: mlxcpld: move header file out of I2C realm

 drivers/i2c/muxes/i2c-mux-mlxcpld.c                | 2 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                | 2 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 2 +-
 include/linux/{i2c => platform_data}/pca954x.h     | 0
 include/linux/{i2c => platform_data/x86}/mlxcpld.h | 0
 5 files changed, 3 insertions(+), 3 deletions(-)
 rename include/linux/{i2c => platform_data}/pca954x.h (100%)
 rename include/linux/{i2c => platform_data/x86}/mlxcpld.h (100%)

-- 
2.11.0
