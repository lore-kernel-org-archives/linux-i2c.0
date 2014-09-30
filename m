From: Rajat Jain <rajatxjain@gmail.com>
Subject: [PATCH 3/4] MAINTAINERS: Add new device driver entry for PEX pex8xxx
Date: Mon, 29 Sep 2014 21:47:34 -0700
Message-ID: <542A35E6.8020100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Jiri Kosina <jkosina@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc: rajatjain@juniper.net, groeck@juniper.net
List-Id: linux-i2c@vger.kernel.org


Signed-off-by: Rajat Jain <rajatxjain@gmail.com>
Signed-off-by: Rajat Jain <rajatjain@juniper.net>
Signed-off-by: Guenter Roeck <groeck@juniper.net>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3705430..0ef7a92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7003,6 +7003,13 @@ S:	Maintained
 F:	include/linux/personality.h
 F:	include/uapi/linux/personality.h
 
+PEX8XXX I2C DRIVER
+M:	Rajat Jain <rajatjain@juniper.net>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	drivers/pci/pex8xxx_i2c.c
+F:	include/linux/i2c/pex8xxx_i2c.h
+
 PHONET PROTOCOL
 M:	Remi Denis-Courmont <courmisch@gmail.com>
 S:	Supported
-- 
1.7.9.5

