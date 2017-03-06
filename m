From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] Documentation: devicetree: move trivial-devices out of I2C realm
Date: Mon,  6 Mar 2017 15:38:59 +0100
Message-ID: <20170306143859.11881-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:39157 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932387AbdCFOsr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 6 Mar 2017 09:48:47 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Rob Herring <robh@kernel.org>, Wolfram Sang <wsa@the-dreams.de>

The I2C directory is for I2C master controllers, not for clients. So,
move the file describing trivial devices one layer upwards where it
fits its generic nature way better.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/devicetree/bindings/{i2c => }/trivial-devices.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{i2c => }/trivial-devices.txt (100%)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
similarity index 100%
rename from Documentation/devicetree/bindings/i2c/trivial-devices.txt
rename to Documentation/devicetree/bindings/trivial-devices.txt
-- 
2.11.0
