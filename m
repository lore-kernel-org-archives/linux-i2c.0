From: Patryk Kocielnik <pkocieln@mion.elka.pw.edu.pl>
Subject: [PATCH] i2c: busses: i2c-sirf: Fix spelling: "formular" -> "formula".
Date: Fri, 26 Jan 2018 21:19:26 +0100
Message-ID: <20180126201926.18804-1-patryk@kocielnik.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de
Cc: baohua@kernel.org, Patryk Kocielnik <patryk@kocielnik.pl>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Patryk Kocielnik <patryk.kocielnik@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Fix spelling.

Signed-off-by: Patryk Kocielnik <patryk.kocielnik@gmail.com>
---
 drivers/i2c/busses/i2c-sirf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 2fd8b6d00..605c8217f 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -369,7 +369,7 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 	 * but they start to affect the speed when clock is set to faster
 	 * frequencies.
 	 * Through the actual tests, use the different user_div value(which
-	 * in the divider formular 'Fio / (Fi2c * user_div)') to adapt
+	 * in the divider formula 'Fio / (Fi2c * user_div)') to adapt
 	 * the different ranges of i2c bus clock frequency, to make the SCL
 	 * more accurate.
 	 */
-- 
2.14.3
