From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] MAINTAINERS: add i2c tree for embedded platforms
Date: Mon,  1 Mar 2010 12:12:16 +0100
Message-ID: <1267441936-4432-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100301113840.4d6b4e7d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100301113840.4d6b4e7d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f520dd0..a01745b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2658,6 +2658,7 @@ M:	"Ben Dooks (embedded platforms)" <ben-linux@fl=
uff.org>
 L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 W:	http://i2c.wiki.kernel.org/
 T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvar=
e-i2c/
+T:	git git://git.fluff.org/bjdooks/linux.git next-i2c
 S:	Maintained
 F:	Documentation/i2c/
 F:	drivers/i2c/
--=20
1.7.0
