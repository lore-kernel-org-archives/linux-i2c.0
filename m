From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/03] i2c: i2c-sh_mobile kconfig update for SH-Mobile ARM
Date: Thu, 11 Mar 2010 19:06:15 +0900
Message-ID: <20100311100615.15227.16635.sendpatchset@t400s>
References: <20100311100526.15227.50813.sendpatchset@t400s>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100311100526.15227.50813.sendpatchset@t400s>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nishimoto.hiroki-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Update the Kconfig entry for the i2c-sh_mobile driver to
enable build on SH-Mobile ARM platforms

Signed-off-by: Kuninori Morimoto <morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 drivers/i2c/busses/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/i2c/busses/Kconfig
+++ work/drivers/i2c/busses/Kconfig	2010-03-11 18:41:50.000000000 +0900
@@ -520,7 +520,7 @@ config I2C_SH7760
 
 config I2C_SH_MOBILE
 	tristate "SuperH Mobile I2C Controller"
-	depends on SUPERH
+	depends on SUPERH || ARCH_SHMOBILE
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Renesas SH-Mobile processor.
