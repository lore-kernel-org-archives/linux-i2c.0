From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 0/3] i2c: mux: move include files out of include/linux/i2c
Date: Mon, 14 Aug 2017 10:23:23 +0200
Message-ID: <20170814082326.9835-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48665 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751542AbdHNIXh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 04:23:37 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>

include/linux/i2c is to be deprecated, so move these header files only
including platform_data to the better suited platform_data directory.

v3 makes sure includes keep sorted correctly. For PCA9541, a patch which does
the initial sorting has been added.

Thanks,

   Wolfram


Wolfram Sang (3):
  i2c: mux: pca9541: sort include files
  i2c: mux: pca954x: move header file out of I2C realm
  i2c: mux: mlxcpld: move header file out of I2C realm

 drivers/i2c/muxes/i2c-mux-mlxcpld.c                | 2 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                | 9 ++++-----
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 2 +-
 include/linux/{i2c => platform_data}/pca954x.h     | 0
 include/linux/{i2c => platform_data/x86}/mlxcpld.h | 0
 5 files changed, 6 insertions(+), 7 deletions(-)
 rename include/linux/{i2c => platform_data}/pca954x.h (100%)
 rename include/linux/{i2c => platform_data/x86}/mlxcpld.h (100%)

-- 
2.11.0
