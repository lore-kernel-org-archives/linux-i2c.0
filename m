From: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/3] i2c: Add helper to ease DMA handling
Date: Sat, 7 Jul 2018 17:29:54 +0800
Message-ID: <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1530955795-17714-1-git-send-email-jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

This function is needed by i2c_get_dma_safe_msg_buf() potentially.
It is used to free DMA safe buffer when DMA operation fails.

Signed-off-by: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/i2c/i2c-core-base.c | 14 ++++++++++++++
 include/linux/i2c.h         |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 31d16ad..2b518ea 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2288,6 +2288,20 @@ void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf)
 }
 EXPORT_SYMBOL_GPL(i2c_release_dma_safe_msg_buf);
 
+/**
+ * i2c_free_dma_safe_msg_buf - free DMA safe buffer
+ * @msg: the message related to DMA safe buffer
+ * @buf: the buffer obtained from i2c_get_dma_safe_msg_buf(). May be NULL.
+ */
+void i2c_free_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf)
+{
+	if (!buf || buf == msg->buf)
+		return;
+
+	kfree(buf);
+}
+EXPORT_SYMBOL_GPL(i2c_free_dma_safe_msg_buf);
+
 MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 254cd34..6d62f93 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -860,6 +860,7 @@ static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
 
 u8 *i2c_get_dma_safe_msg_buf(struct i2c_msg *msg, unsigned int threshold);
 void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf);
+void i2c_free_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf);
 
 int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
 /**
-- 
1.8.1.1
