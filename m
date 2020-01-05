From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 20/26] docs: i2c: instantiating-devices: fix internal hyperlink
Date: Sun,  5 Jan 2020 23:50:06 +0100
Message-ID: <20200105225012.11701-20-luca@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200105225012.11701-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use ReST syntax so that a proper hyperlink is generated.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/i2c/instantiating-devices.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/instantiating-devices.rst b/Documentation/i2c/instantiating-devices.rst
index cf5d9828e823..5debaafef64d 100644
--- a/Documentation/i2c/instantiating-devices.rst
+++ b/Documentation/i2c/instantiating-devices.rst
@@ -86,7 +86,7 @@ Method 1c: Declare the I2C devices via ACPI
 -------------------------------------------
 
 ACPI can also describe I2C devices. There is special documentation for this
-which is currently located at Documentation/firmware-guide/acpi/enumeration.rst.
+which is currently located at :doc:`../firmware-guide/acpi/enumeration` .
 
 
 Method 2: Instantiate the devices explicitly
-- 
2.24.1
