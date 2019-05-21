From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/8] MAINTAINERS: add I2C DT bindings to DaVinci platform
Date: Tue, 21 May 2019 10:21:31 +0200
Message-ID: <20190521082137.2889-3-wsa@the-dreams.de>
References: <20190521082137.2889-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190521082137.2889-1-wsa@the-dreams.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cb019f8e597..90abfe11b05c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15684,6 +15684,7 @@ R:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git
 S:	Supported
+F:	Documentation/devicetree/bindings/i2c/i2c-davinci.txt
 F:	arch/arm/mach-davinci/
 F:	drivers/i2c/busses/i2c-davinci.c
 F:	arch/arm/boot/dts/da850*
-- 
2.19.1
