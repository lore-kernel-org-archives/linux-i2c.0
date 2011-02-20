From: Stephen Hemminger <shemminger-ZtmgI6mnKB3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] i2c-eg20t: fix sparse warnings
Date: Sun, 20 Feb 2011 13:40:58 -0800
Message-ID: <20110220134058.396e7bc2@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


drivers/i2c/busses/i2c-eg20t.c:477:5: warning: symbol 'pch_i2c_readbytes' was not declared. Should it be static?
drivers/i2c/busses/i2c-eg20t.c:804:42: warning: Using plain integer as NULL pointer

Signed-off-by: Stephen Hemminger <shemminger-ZtmgI6mnKB3QT0dZR+AlfA@public.gmane.org>


--- a/drivers/i2c/busses/i2c-eg20t.c	2011-02-20 13:24:43.445948555 -0800
+++ b/drivers/i2c/busses/i2c-eg20t.c	2011-02-20 13:25:14.915448908 -0800
@@ -474,8 +474,8 @@ static void pch_i2c_sendnack(struct i2c_
  * @last:	specifies whether last message or not.
  * @first:	specifies whether first message or not.
  */
-s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
-		  u32 last, u32 first)
+static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
+			     u32 last, u32 first)
 {
 	struct i2c_algo_pch_data *adap = i2c_adap->algo_data;
 
@@ -801,7 +801,7 @@ static void __devexit pch_i2c_remove(str
 
 	if (adap_info->pch_data.pch_base_address) {
 		pci_iounmap(pdev, adap_info->pch_data.pch_base_address);
-		adap_info->pch_data.pch_base_address = 0;
+		adap_info->pch_data.pch_base_address = NULL;
 	}
 
 	pci_set_drvdata(pdev, NULL);
