From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH v3 20/28] docs: i2c: instantiating-devices: fix internal hyperlink
Date: Wed, 29 Jan 2020 16:19:45 +0100
Message-ID: <20200129151953.31582-21-luca@lucaceresoli.net>
References: <20200129151953.31582-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:57565 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgA2QWx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Jan 2020 11:22:53 -0500
In-Reply-To: <20200129151953.31582-1-luca@lucaceresoli.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org


Use ReST syntax so that a proper hyperlink is generated.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>

---

Changes in v2:
 - remove space before dot (Jean Delvare)
---
 Documentation/i2c/instantiating-devices.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/instantiating-devices.rst b/Documentation/i2c/instantiating-devices.rst
index 53244e2f0378..e823c4ad4e7f 100644
--- a/Documentation/i2c/instantiating-devices.rst
+++ b/Documentation/i2c/instantiating-devices.rst
@@ -86,7 +86,7 @@ Method 1c: Declare the I2C devices via ACPI
 -------------------------------------------
 
 ACPI can also describe I2C devices. There is special documentation for this
-which is currently located at Documentation/firmware-guide/acpi/enumeration.rst.
+which is currently located at :doc:`../firmware-guide/acpi/enumeration`.
 
 
 Method 2: Instantiate the devices explicitly
-- 
2.25.0
