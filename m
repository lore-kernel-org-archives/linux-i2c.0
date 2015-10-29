From: Nicola Corna <nicola@corna.info>
Subject: [PATCH 4/5] i2c: add i2c_check_quirks helper function
Date: Thu, 29 Oct 2015 12:34:26 +0100
Message-ID: <1446118467-26453-4-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446118467-26453-1-git-send-email-nicola@corna.info>
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

This patch adds a i2c_check_quirks helper function to check the quirk flags
of an i2c adapter, in a similar way to i2c_check_functionality.

Signed-off-by: Nicola Corna <nicola@corna.info>
---
 include/linux/i2c.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 9697002..51028f3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -617,6 +617,20 @@ static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
 	return (func & i2c_get_functionality(adap)) == func;
 }
 
+/**
+ * i2c_check_quirks() - Function for checking the quirk flags in an i2c adapter
+ * @adap: i2c adapter
+ * @quirks: quirk flags
+ *
+ * Return: true if the adapter has all the specified quirk flags, false if not
+ */
+static inline bool i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
+{
+	if (!adap->quirks)
+		return false;
+	return (adap->quirks->flags & quirks) == quirks;
+}
+
 /* Return the adapter number for a specific adapter */
 static inline int i2c_adapter_id(struct i2c_adapter *adap)
 {
-- 
2.6.1
