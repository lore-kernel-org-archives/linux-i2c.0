From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/5] i2c-bfin-twi: remove redundant
	retry
Date: Mon, 22 Mar 2010 03:23:19 -0400
Message-ID: <1269242600-30147-5-git-send-email-vapier@gentoo.org>
References: <1269242600-30147-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1269242600-30147-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   20 ++------------------
 1 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 3495019..d157105 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -357,15 +357,7 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
 static int bfin_twi_master_xfer(struct i2c_adapter *adap,
 				struct i2c_msg *msgs, int num)
 {
-	int i, ret = 0;
-
-	for (i = 0; i < adap->retries; i++) {
-		ret = bfin_twi_do_master_xfer(adap, msgs, num);
-		if (ret > 0)
-			break;
-	}
-
-	return ret;
+	return bfin_twi_do_master_xfer(adap, msgs, num);
 }
 
 /*
@@ -573,16 +565,8 @@ int bfin_twi_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 			unsigned short flags, char read_write,
 			u8 command, int size, union i2c_smbus_data *data)
 {
-	int i, ret = 0;
-
-	for (i = 0; i < adap->retries; i++) {
-		ret = bfin_twi_do_smbus_xfer(adap, addr, flags,
+	return bfin_twi_do_smbus_xfer(adap, addr, flags,
 			read_write, command, size, data);
-		if (ret == 0)
-			break;
-	}
-
-	return ret;
 }
 
 /*
-- 
1.7.0.2
