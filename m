From: Kieran Bingham <kieranbingham@gmail.com>
Subject: [PATCH] i2c: return probe deferred status on dev_pm_domain_attach
Date: Sun, 11 Oct 2015 12:39:31 +0100
Message-ID: <1444563571-12247-1-git-send-email-kieranbingham@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35265 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbbJKLjk (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 11 Oct 2015 07:39:40 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kieran Bingham <kieranbingham@gmail.com>

A change of return status was introduced in commit 3fffd1283927
("i2c: allow specifying separate wakeup interrupt in device tree")

The commit prevents the defer status being passed up the call stack
appropriately when dev_pm_domain_attach returns -EPROBE_DEFER.

To fix we change this back to the original return status;

Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>
---

 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 5f89f1e..df83015 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -701,7 +701,7 @@ static int i2c_device_probe(struct device *dev)
 			goto err_detach_pm_domain;
 	}
 
-	return 0;
+	return status;
 
 err_detach_pm_domain:
 	dev_pm_domain_detach(&client->dev, true);
-- 
2.1.4
