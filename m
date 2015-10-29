From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] MAINTAINERS: i2c: mark also subdirectories as maintained
Date: Thu, 29 Oct 2015 08:25:48 +0100
Message-ID: <1446103548-2217-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48479 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbbJ2H0D (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 29 Oct 2015 03:26:03 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>

Otherwise get_maintainer.pl will fall back to git history and CC
more people than needed.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f23aab10398bb..c3f01dc36b26b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5090,6 +5090,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/
 F:	Documentation/i2c/
 F:	drivers/i2c/
+F:	drivers/i2c/*/
 F:	include/linux/i2c.h
 F:	include/linux/i2c-*.h
 F:	include/uapi/linux/i2c.h
-- 
2.1.4
