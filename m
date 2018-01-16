From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 3/3] i2c: mv64xxx: Add myslef as maintainer for this driver
Date: Tue, 16 Jan 2018 17:35:40 +0100
Message-ID: <20180116163540.1092-4-gregory.clement@free-electrons.com>
References: <20180116163540.1092-1-gregory.clement@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57622 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeAPQfz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Jan 2018 11:35:55 -0500
In-Reply-To: <20180116163540.1092-1-gregory.clement@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>

As requested by Wolfram Sang add myslef as maintainer of this driver.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d176abafcc4..108fb5cae988 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6649,6 +6649,12 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/i2c-stub.c
 
+I2C MV64XXX MARVELL AND ALLWINNER DRIVER
+M:	Gregory CLEMENT <gregory.clement@free-electrons.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	drivers/i2c/busses/i2c-mv64xxx.c
+
 i386 BOOT CODE
 M:	"H. Peter Anvin" <hpa@zytor.com>
 S:	Maintained
-- 
2.15.1
