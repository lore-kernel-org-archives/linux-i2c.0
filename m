From: Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 2/2] i2c-nomadik: fix operator precedence warning
Date: Tue, 27 Apr 2010 10:31:08 +0530
Message-ID: <1272344468-9411-2-git-send-email-rabin.vincent@stericsson.com>
References: <1272344468-9411-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272344468-9411-1-git-send-email-rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fix this warning:
i2c-nomadik.c:707: warning: suggest parentheses around operand of '!' or change '&' to '&&' or '!' to '~'

Acked-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 170dbd7..73de8ad 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -704,7 +704,8 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 	case I2C_IT_MTD:
 	case I2C_IT_MTDWS:
 		if (dev->cli.operation == I2C_READ) {
-			while (!readl(dev->virtbase + I2C_RISR) & I2C_IT_RXFE) {
+			while (!(readl(dev->virtbase + I2C_RISR)
+				 & I2C_IT_RXFE)) {
 				if (dev->cli.count == 0)
 					break;
 				*dev->cli.buffer =
-- 
1.7.0
