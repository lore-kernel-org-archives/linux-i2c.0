From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] char: ipmi: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:09:58 +0100
Message-ID: <20200326210958.13051-2-wsa+renesas@sang-engineering.com>
References: <20200326210958.13051-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54366 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgCZVJ7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Mar 2020 17:09:59 -0400
In-Reply-To: <20200326210958.13051-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org

Move away from the deprecated API.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 8ac390c2b514..2791b799e33d 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1945,8 +1945,8 @@ static int ssif_adapter_handler(struct device *adev, void *opaque)
 	if (adev->type != &i2c_adapter_type)
 		return 0;
 
-	addr_info->added_client = i2c_new_device(to_i2c_adapter(adev),
-						 &addr_info->binfo);
+	addr_info->added_client = i2c_new_client_device(to_i2c_adapter(adev),
+							&addr_info->binfo);
 
 	if (!addr_info->adapter_name)
 		return 1; /* Only try the first I2C adapter by default. */
-- 
2.20.1
