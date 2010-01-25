From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] MAINTAINERS: add i2c tree for embedded platforms
Date: Mon, 25 Jan 2010 10:20:34 +0100
Message-ID: <1264411234-5400-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
Hello,

I wonder if it makes sence to split the "I2C SUBSYSTEM" entry into
something like:

	I2C SUBSYSTEM (PC drivers, core)
	M:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
	L:	...
	W:	...
	T:	quilt ...
	S:	...
	F:	Documentation/i2c/
	F:	drivers/i2c/
	F:	include/linux/i2c.h
	F:	include/linux/i2c-*.h

	I2C SUBSYSTEM (embedded platforms)
	M:	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
	L:	...
	W:	...
	T:	git ...
	S:	...
	F:	drivers/i2c/
	F:	include/linux/i2c-*.h

(I'm not entirely sure about the file patterns for the 2nd entry.)

Best regards
Uwe

 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1858646..a1813fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2629,6 +2629,7 @@ M:	"Ben Dooks (embedded platforms)" <ben-linux@fl=
uff.org>
 L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 W:	http://i2c.wiki.kernel.org/
 T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvar=
e-i2c/
+T:	git git://git.fluff.org/bjdooks/linux.git
 S:	Maintained
 F:	Documentation/i2c/
 F:	drivers/i2c/
--=20
1.6.6
