From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH 4/4] i2c: xlp9xx: Add MAINTAINERS entry
Date: Wed, 16 May 2018 00:00:19 -0700
Message-ID: <1526454019-32714-5-git-send-email-george.cherian@cavium.com>
References: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, jglauber@cavium.com, kamlakant.patel@cavium.com, mchehab+samsung@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, akpm@linux-foundation.org, linus.walleij@linaro.org, rdunlap@infradead.org, george.cherian@cavium.com
List-Id: linux-i2c@vger.kernel.org

The i2c XLP9xx driver is maintained by Cavium.
Add George Cherian and Jan Glauber as the Maintainers.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index df6e9bb..68da265 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15509,6 +15509,14 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	drivers/char/xillybus/
 
+XLP9XX I2C DRIVER
+M:	George Cherian <george.cherian@cavium.com>
+M:	Jan Glauber <jglauber@cavium.com>
+L:	linux-i2c@vger.kernel.org
+W:	http://www.cavium.com
+S:	Supported
+F:	drivers/i2c/busses/i2c-xlp9xx.c
+
 XRA1403 GPIO EXPANDER
 M:	Nandor Han <nandor.han@ge.com>
 M:	Semi Malinen <semi.malinen@ge.com>
-- 
1.8.3.1
