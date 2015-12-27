From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 04/10] i2c: st: use to_platform_device()
Date: Sun, 27 Dec 2015 21:15:42 +0800
Message-ID: <18b3804a2b8d7c682f3f25951309e1503d8ab6d0.1451221174.git.geliangtang@163.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
In-Reply-To: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Geliang Tang <geliangtang@163.com>, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/i2c/busses/i2c-st.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 25020ec..6ee7715 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -708,8 +708,7 @@ static int st_i2c_xfer(struct i2c_adapter *i2c_adap,
 #ifdef CONFIG_PM_SLEEP
 static int st_i2c_suspend(struct device *dev)
 {
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct st_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
 
 	if (i2c_dev->busy)
-- 
2.5.0
