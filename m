From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v12 8/8] MAINTAINERS: Add Eddie as the maintainer for the FSI-attached I2C driver
Date: Tue, 17 Jul 2018 10:31:06 -0500
Message-ID: <1531841466-9833-9-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se, "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>
List-Id: linux-i2c@vger.kernel.org

From: "eajames@linux.vnet.ibm.com" <eajames@linux.vnet.ibm.com>

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcefb7a..613fd52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5917,6 +5917,14 @@ F:	fs/crypto/
 F:	include/linux/fscrypt*.h
 F:	Documentation/filesystems/fscrypt.rst
 
+FSI-ATTACHED I2C DRIVER
+M:	Eddie James <eajames@linux.vnet.ibm.com>
+L:	linux-i2c@vger.kernel.org
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/i2c/busses/i2c-fsi.c
+F:	Documentation/devicetree/bindings/i2c/i2c-fsi.txt
+
 FSNOTIFY: FILESYSTEM NOTIFICATION INFRASTRUCTURE
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
1.8.3.1
