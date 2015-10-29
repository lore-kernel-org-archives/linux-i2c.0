From: Nicola Corna <nicola@corna.info>
Subject: [PATCH v2 1/5] i2c: add i2c quirk flag for unsupported clock
 stretching
Date: Thu, 29 Oct 2015 12:34:23 +0100
Message-ID: <1446118467-26453-1-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445976718-7449-1-git-send-email-nicola@corna.info>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Jonathan Cameron <jic23@kernel.org>
Cc: Nicola Corna <nicola@corna.info>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Add I2C_AQ_NO_CLK_STRETCH quirk flag, to be used when clock stretching is
not supported.

Signed-off-by: Nicola Corna <nicola@corna.info>
---
 include/linux/i2c.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 768063b..9697002 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -493,6 +493,8 @@ struct i2c_adapter_quirks {
 /* convenience macro for typical write-then read case */
 #define I2C_AQ_COMB_WRITE_THEN_READ	(I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | \
 					 I2C_AQ_COMB_READ_SECOND | I2C_AQ_COMB_SAME_ADDR)
+/* clock stretching is not supported */
+#define I2C_AQ_NO_CLK_STRETCH		BIT(4)
 
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
-- 
2.6.1
