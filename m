From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] net: convert to use new I2C API
Date: Thu, 26 Mar 2020 22:09:58 +0100
Message-ID: <20200326211001.13171-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54366 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgCZVKC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Mar 2020 17:10:02 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR. Only build tested.


Wolfram Sang (2):
  igb: convert to use i2c_new_client_device()
  sfc: falcon: convert to use i2c_new_client_device()

 drivers/net/ethernet/intel/igb/igb_hwmon.c      | 6 +++---
 drivers/net/ethernet/sfc/falcon/falcon_boards.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.20.1
