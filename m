From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] i2c: mux: pca954x: Add missing pca9546 definition to chip_desc
Date: Thu, 23 Mar 2017 10:00:36 +0100
Message-ID: <1490259636-16859-1-git-send-email-mike.looijmans@topic.nl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:47282 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753654AbdCWJHb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 23 Mar 2017 05:07:31 -0400
Received: from atl4mhob18.registeredsite.com (atl4mhob18.myregisteredsite.com [209.17.115.111])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id v2N91ZVL031401
        for <linux-i2c@vger.kernel.org>; Thu, 23 Mar 2017 05:01:35 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.210])
        by atl4mhob18.registeredsite.com (8.14.4/8.14.4) with ESMTP id v2N91R0W017960
        for <linux-i2c@vger.kernel.org>; Thu, 23 Mar 2017 05:01:27 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, peda@axentia.se, wsa@the-dreams.de, Mike Looijmans <mike.looijmans@topic.nl>

The spec for the pca9546 was missing. This chip is the same as the pca9545
except that it lacks interrupt lines. While the i2c_device_id table mapped
the pca9546 to the pca9545 definition the compatible table did not.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index dfc1c0e..69c2f5a 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -117,6 +117,10 @@ struct pca954x {
 		.has_irq = 1,
 		.muxtype = pca954x_isswi,
 	},
+	[pca_9546] = {
+		.nchans = 4,
+		.muxtype = pca954x_isswi,
+	},
 	[pca_9547] = {
 		.nchans = 8,
 		.enable = 0x8,
@@ -134,7 +138,7 @@ struct pca954x {
 	{ "pca9543", pca_9543 },
 	{ "pca9544", pca_9544 },
 	{ "pca9545", pca_9545 },
-	{ "pca9546", pca_9545 },
+	{ "pca9546", pca_9546 },
 	{ "pca9547", pca_9547 },
 	{ "pca9548", pca_9548 },
 	{ }
-- 
1.9.1
