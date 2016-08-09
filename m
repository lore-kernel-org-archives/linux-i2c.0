From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: [PATCH 2/5] gpu: drm: mediatek: mtk_hdmi_ddc: don't print error when
 adding adapter fails
Date: Tue,  9 Aug 2016 13:30:28 +0200
Message-ID: <1470742232-12559-3-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742232-12559-1-git-send-email-wsa-dev@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470742232-12559-1-git-send-email-wsa-dev@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, Wolfram Sang <wsa-dev@sang-engineering.com>, dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

The core will do this for us now.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
index 33c9e1bdb114b8..ca4caf924deb81 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
@@ -310,10 +310,8 @@ static int mtk_hdmi_ddc_probe(struct platform_device *pdev)
 	ddc->adap.dev.parent = &pdev->dev;
 
 	ret = i2c_add_adapter(&ddc->adap);
-	if (ret < 0) {
-		dev_err(dev, "failed to add bus to i2c core\n");
+	if (ret < 0)
 		goto err_clk_disable;
-	}
 
 	platform_set_drvdata(pdev, ddc);
 
-- 
2.8.1
