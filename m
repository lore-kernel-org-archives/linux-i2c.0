From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Mon,  1 Jul 2013 18:14:21 -0300
Message-ID: <1372713261-20551-1-git-send-email-festevam@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: marex@denx.de, shawn.guo@linaro.org, kernel@pengutronix.de, linux-i2c@vger.kernel.org, alexandre.belloni@free-electrons.com, to-fleischer@t-online.de, Fabio Estevam <fabio.estevam@freescale.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Recently we have been seing some reports about PIO mode not working properly.

- http://www.spinics.net/lists/linux-i2c/msg11985.html
- http://marc.info/?l=linux-i2c&m=137235593101385&w=2
- https://lkml.org/lkml/2013/6/24/430

Let's use DMA mode even for small transfers.

Without this patch, i2c reads the incorrect sgtl5000 version on a mx28evk when
touchscreen is enabled:
                                           
[    5.856270] sgtl5000 0-000a: Device with ID register 0 is not a sgtl5000     
[    9.877307] sgtl5000 0-000a: ASoC: failed to probe CODEC -19                 
[    9.883528] mxs-sgtl5000 sound.12: ASoC: failed to instantiate card -19      
[    9.892955] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-19)  

Cc: <stable@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Applies against 3.10

Changes since v1:
- Keep the PIO code

 drivers/i2c/busses/i2c-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 2039f23..6d8094d 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -494,7 +494,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	 * based on this empirical measurement and a lot of previous frobbing.
 	 */
 	i2c->cmd_err = 0;
-	if (msg->len < 8) {
+	if (0) {	/* disable PIO mode until a proper fix is made */
 		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
 		if (ret)
 			mxs_i2c_reset(i2c);
-- 
1.8.1.2
