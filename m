From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCH] misc: at24: Fix typo in at24 header file
Date: Mon, 23 May 2016 11:44:39 -0700
Message-ID: <1464029079-29334-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33117 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbcEWSos (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 23 May 2016 14:44:48 -0400
Received: by mail-pf0-f169.google.com with SMTP id b124so10252757pfb.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 May 2016 11:44:48 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, moritz.fischer.private@gmail.com, Moritz Fischer <moritz.fischer@ettus.com>

This commit fixes a simple typo s/mvmem/nvmem in the
example.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 include/linux/platform_data/at24.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index dc9a13e..be830b1 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -26,7 +26,7 @@
  *
  * An example in pseudo code for a setup() callback:
  *
- * void get_mac_addr(struct mvmem_device *nvmem, void *context)
+ * void get_mac_addr(struct nvmem_device *nvmem, void *context)
  * {
  *	u8 *mac_addr = ethernet_pdata->mac_addr;
  *	off_t offset = context;
-- 
2.5.5
