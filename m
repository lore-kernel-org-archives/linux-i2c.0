From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 0/2] i2c: mux: move include files out of include/linux/i2c
Date: Sun, 13 Aug 2017 15:58:54 +0200
Message-ID: <20170813135856.3454-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46420 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750816AbdHMN7W (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 13 Aug 2017 09:59:22 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>

include/linux/i2c is to be deprecated, so move these header files only
including platform_data to the better suited platform_data directory.

Peter, I know I said I'll include these two patches in my for-current branch.
But other of these cleanup patches missed this merge window as well. Since I
need to wait for the next merge window anyhow (until all patches are applied),
I'd think these patches can also go the proper way via your tree, too.

These patches are rebased to v4.13-rc4 (let me know if you prefer a
different base). The PCA patch has an empty line removed now.

Thanks,

   Wolfram


Wolfram Sang (2):
  i2c: mux: pca954x: move header file out of I2C realm
  i2c: mux: mlxcpld: move header file out of I2C realm

 drivers/i2c/muxes/i2c-mux-mlxcpld.c                | 2 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                | 3 +--
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 2 +-
 include/linux/{i2c => platform_data}/pca954x.h     | 0
 include/linux/{i2c => platform_data/x86}/mlxcpld.h | 0
 5 files changed, 3 insertions(+), 4 deletions(-)
 rename include/linux/{i2c => platform_data}/pca954x.h (100%)
 rename include/linux/{i2c => platform_data/x86}/mlxcpld.h (100%)

-- 
2.11.0
