From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] MAINTAINERS: add myself as i2c mux maintainer
Date: Mon, 14 Mar 2016 23:52:43 +0100
Message-ID: <1457995963-10048-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:60258 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbcCNWw4 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Mar 2016 18:52:56 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>

From: Peter Rosin <peda@axentia.se>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5e6a535bc34..929e91b011cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5202,6 +5202,16 @@ F:	include/linux/hyperv.h
 F:	tools/hv/
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 
+I2C MUXES
+M:	Peter Rosin <peda@axentia.se>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/i2c/muxes/
+F:	Documentation/devicetree/bindings/i2c/i2c-mux*
+F:	drivers/i2c/i2c-mux.c
+F:	drivers/i2c/muxes/
+F:	include/linux/i2c-mux.h
+
 I2C OVER PARALLEL PORT
 M:	Jean Delvare <jdelvare@suse.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.1.4
