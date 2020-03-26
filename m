From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/1] ALSA: ppc: convert to use new I2C API
Date: Thu, 26 Mar 2020 22:10:11 +0100
Message-ID: <20200326211013.13531-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54548 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbgCZVKO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Mar 2020 17:10:14 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR. Only build tested.


Wolfram Sang (1):
  ALSA: ppc: keywest: convert to use i2c_new_client_device()

 sound/ppc/keywest.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.20.1
