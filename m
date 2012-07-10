From: "Jayachandran C" <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 3/4] V4L/DVB: mfd: use reg_shift instead of regstep
Date: Tue, 10 Jul 2012 11:40:57 +0530
Message-ID: <1341900658-7698-4-git-send-email-jayachandranc@netlogicmicro.com>
References: <1341900658-7698-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341900658-7698-1-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org
Cc: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Update for change in i2c-ocores.h which uses reg_shift to
specify the register offset shifts instead of regstep.

Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
---
 drivers/mfd/timberdale.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index 0ba26fb..a447f4e 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -83,7 +83,7 @@ timberdale_xiic_platform_data = {
 
 static __devinitdata struct ocores_i2c_platform_data
 timberdale_ocores_platform_data = {
-	.regstep = 4,
+	.reg_shift = 2,
 	.clock_khz = 62500,
 	.devices = timberdale_i2c_board_info,
 	.num_devices = ARRAY_SIZE(timberdale_i2c_board_info)
-- 
1.7.9.5
