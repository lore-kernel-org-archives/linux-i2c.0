From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V3 Resend 03/12] i2c/i2c-pxa: Remove conditional compilation
 of clk code
Date: Tue, 8 May 2012 09:22:30 +0530
Message-ID: <28655b8c590cefc2d6481dafd7bec6ec010b66d3.1336448639.git.viresh.kumar@st.com>
References: <cover.1336448639.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1336448639.git.viresh.kumar@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: akpm@linux-foundation.org
Cc: andrew@lunn.ch, mturquette@linaro.org, sshtylyov@mvista.com, spear-devel@list.st.com, linux-kernel@vger.kernel.org, w.sang@pengutronix.de, viresh.linux@gmail.com, linux-i2c@vger.kernel.org, linux@arm.linux.org.uk, jgarzik@redhat.com, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de
List-Id: linux-i2c@vger.kernel.org

From: Viresh Kumar <viresh.linux@gmail.com>

With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
macros.

pxa i2c also has these dummy macros defined locally. Remove them as they aren't
required anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-i2c@vger.kernel.org
---
 drivers/i2c/busses/i2c-pxa.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index a997c7d..1034d93 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -41,13 +41,6 @@
 
 #include <asm/irq.h>
 
-#ifndef CONFIG_HAVE_CLK
-#define clk_get(dev, id)	NULL
-#define clk_put(clk)		do { } while (0)
-#define clk_disable(clk)	do { } while (0)
-#define clk_enable(clk)		do { } while (0)
-#endif
-
 struct pxa_reg_layout {
 	u32 ibmr;
 	u32 idbr;
-- 
1.7.9
