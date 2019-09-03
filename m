From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 153/167] i2c: at91: fix clk_offset for sama5d2
Date: Tue,  3 Sep 2019 12:25:05 -0400
Message-ID: <20190903162519.7136-153-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Ludovic Desroches <ludovic.desroches@microchip.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

[ Upstream commit b1ac6704493fa14b5dc19eb6b69a73932361a131 ]

In SAMA5D2 datasheet, TWIHS_CWGR register rescription mentions clock
offset of 3 cycles (compared to 4 in eg. SAMA5D3).

Cc: stable@vger.kernel.org # 5.2.x
[needs applying to i2c-at91.c instead for earlier kernels]
Fixes: 0ef6f3213dac ("i2c: at91: add support for new alternative command mode")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 0998a388d2ed5..d51bf536bdf75 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -914,7 +914,7 @@ static struct at91_twi_pdata sama5d4_config = {
 
 static struct at91_twi_pdata sama5d2_config = {
 	.clk_max_div = 7,
-	.clk_offset = 4,
+	.clk_offset = 3,
 	.has_unre_flag = true,
 	.has_alt_cmd = true,
 	.has_hold_field = true,
-- 
2.20.1
