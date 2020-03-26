From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/1] ASoC: convert to use new I2C API
Date: Thu, 26 Mar 2020 22:10:09 +0100
Message-ID: <20200326211010.13471-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54372 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgCZVKL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Mar 2020 17:10:11 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR. Only build tested.


Wolfram Sang (1):
  ASoC: pxa: magician: convert to use i2c_new_client_device()

 sound/soc/pxa/magician.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.20.1
