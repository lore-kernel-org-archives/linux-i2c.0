From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH] i2c: i2c-stm32f7: fix 10-bits check in slave free id search
 loop
Date: Tue, 12 Nov 2019 09:19:44 +0100
Message-ID: <1573546784-28182-1-git-send-email-alain.volmat@st.com>
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
To: wsa@the-dreams.de, pierre-yves.mordret@st.com
Cc: alexandre.torgue@st.com, linux-kernel@vger.kernel.org, alain.volmat@st.com, linux-i2c@vger.kernel.org, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Fix a typo in the free slave id search loop. Instead of I2C_CLIENT_PEC,
it should have been I2C_CLIENT_TEN. The slave id 1 can only handle 7-bit
addresses and thus is not eligible in case of 10-bit addresses.
As a matter of fact none of the slave id support I2C_CLIENT_PEC, overall
check is performed at the beginning of the stm32f7_i2c_reg_slave function.

Fixes: 60d609f30de2 ("i2c: i2c-stm32f7: Add slave support")

Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index b9a082f64d58..b2634afe066d 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1268,7 +1268,7 @@ static int stm32f7_i2c_get_free_slave_id(struct stm32f7_i2c_dev *i2c_dev,
 	 * slave[1] supports 7-bit slave address only
 	 */
 	for (i = STM32F7_I2C_MAX_SLAVE - 1; i >= 0; i--) {
-		if (i == 1 && (slave->flags & I2C_CLIENT_PEC))
+		if (i == 1 && (slave->flags & I2C_CLIENT_TEN))
 			continue;
 		if (!i2c_dev->slave[i]) {
 			*id = i;
-- 
2.7.4
