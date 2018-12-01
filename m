From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] i2c: mux: demux-pinctrl: handle failure case of devm_kstrdup()
Date: Sat,  1 Dec 2018 11:01:10 +0100
Message-ID: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-i2c@vger.kernel.org

devm_kstrdup() may return NULL if internal allocation failed.
Thus using  name, value  is unsafe without being checked. As
i2c_demux_pinctrl_probe() can return -ENOMEM in other cases
a dev_err() message is included to make the failure location
clear.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: e35478eac030 ("i2c: mux: demux-pinctrl: run properly with multiple instances")
---

Problem located with experimental coccinelle script

Q: The use of devm_kstrdup() seems a bit odd while technically not wrong,
   personally I think devm_kasprintf() would be more suitable here.

Patch was compile tested with: multi_v7_defconfig 
(implies I2C_DEMUX_PINCTRL=y)

Patch is against 4.20-rc4 (localversion-next is next-20181130)

 drivers/i2c/muxes/i2c-demux-pinctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 035032e..c466999 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -244,6 +244,12 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
 		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
+		if (!props[i].name || !props[i].value) {
+			dev_err(&pdev->dev,
+				"chan %d name, value allocation failed\n", i);
+			err = -ENOMEM;
+			goto err_rollback;
+		}
 		props[i].length = 3;
 
 		of_changeset_init(&priv->chan[i].chgset);
-- 
2.1.4
