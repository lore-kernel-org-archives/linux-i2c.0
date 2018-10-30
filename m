From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: [PATCH 2/2] MAINTAINERS: add maintainer for IMX LPI2C driver
Date: Tue, 30 Oct 2018 15:28:14 +0000
Message-ID: <1540913007-28343-2-git-send-email-aisheng.dong@nxp.com>
References: <1540913007-28343-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1540913007-28343-1-git-send-email-aisheng.dong@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "dongas86@gmail.com" <dongas86@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

The LPI2C is used in IMX7ULP/MX8 SoCs.

Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37f912b..e60eaa0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5845,6 +5845,14 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-cpm.c
 
+FREESCALE IMX LPI2C DRIVER
+M:	Dong Aisheng <aisheng.dong@nxp.com>
+L:	linux-i2c@vger.kernel.org
+L:	linux-imx@nxp.com
+S:	Maintained
+F:	drivers/i2c/busses/i2c-imx-lpi2c.c
+F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
+
 FREESCALE IMX / MXC FEC DRIVER
 M:	Fugang Duan <fugang.duan@nxp.com>
 L:	netdev@vger.kernel.org
-- 
2.7.4
