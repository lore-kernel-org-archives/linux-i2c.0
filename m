From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] i2c: Documentation: i2c-topology: mention recent driver additions
Date: Wed,  2 Aug 2017 11:50:58 +0200
Message-ID: <20170802095058.32029-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0129.outbound.protection.outlook.com ([104.47.2.129]:3232
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751174AbdHBJvN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 2 Aug 2017 05:51:13 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Specifically mention what drivers are mux-locked and parent-locked.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/i2c/i2c-topology | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/i2c/i2c-topology b/Documentation/i2c/i2c-topology
index 1a014fede0b7..f74d78b53d4d 100644
--- a/Documentation/i2c/i2c-topology
+++ b/Documentation/i2c/i2c-topology
@@ -42,6 +42,10 @@ i2c-arb-gpio-challenge    Parent-locked
 i2c-mux-gpio              Normally parent-locked, mux-locked iff
                           all involved gpio pins are controlled by the
                           same i2c root adapter that they mux.
+i2c-mux-gpmux             Normally parent-locked, mux-locked iff
+                          specified in device-tree.
+i2c-mux-ltc4306           Mux-locked
+i2c-mux-mlxcpld           Parent-locked
 i2c-mux-pca9541           Parent-locked
 i2c-mux-pca954x           Parent-locked
 i2c-mux-pinctrl           Normally parent-locked, mux-locked iff
@@ -50,9 +54,11 @@ i2c-mux-pinctrl           Normally parent-locked, mux-locked iff
 i2c-mux-reg               Parent-locked
 
 In drivers/iio/
+gyro/mpu3050              Mux-locked
 imu/inv_mpu6050/          Mux-locked
 
 In drivers/media/
+dvb-frontends/lgdt3306a   Mux-locked
 dvb-frontends/m88ds3103   Parent-locked
 dvb-frontends/rtl2830     Parent-locked
 dvb-frontends/rtl2832     Mux-locked
-- 
2.11.0
