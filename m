From: <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/8] i2c: i2c-bfin-twi: Tighten
	condition when failing I2C transfer if MEN bit is reset
	unexpectedly.
Date: Wed, 16 May 2012 15:20:22 +0800
Message-ID: <1337152826-9850-4-git-send-email-sonic.zhang@analog.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1337152826-9850-1-git-send-email-sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Correct I2C transfer may fail because interrupt status bits XMTSERV and
RCVSERV are not checked when MCOMP interrupt is handled.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 4abaf59..63fb84f 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -201,7 +201,8 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 		return;
 	}
 	if (twi_int_status & MCOMP) {
-		if ((read_MASTER_CTL(iface) & MEN) == 0 &&
+		if (twi_int_status & (XMTSERV|RCVSERV) &&
+			(read_MASTER_CTL(iface) & MEN) == 0 &&
 			(iface->cur_mode == TWI_I2C_MODE_REPEAT ||
 			iface->cur_mode == TWI_I2C_MODE_COMBINED)) {
 			iface->result = -1;
-- 
1.7.0.4
