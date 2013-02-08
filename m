From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH] i2c-ismt: Add Seth and Myself as maintainers
Date: Fri,  8 Feb 2013 10:55:22 -0500
Message-ID: <1360338922-10812-1-git-send-email-nhorman@tuxdriver.com>
References: <20130208105756.35d00bae@endymion.delvare>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130208105756.35d00bae-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, "Heasley, Seth" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Brown, Bill E" <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Adding Seth Heasley and Myself as maintainers for the i2c-ismt drvier

Signed-off-by: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Signed-off-by: "Heasley, Seth" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
CC: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
CC: "Brown, Bill E" <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3105c48..cb3cb0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3750,6 +3750,12 @@ F:	drivers/i2c/busses/i2c-sis96x.c
 F:	drivers/i2c/busses/i2c-via.c
 F:	drivers/i2c/busses/i2c-viapro.c
 
+I2C/SMBUS ISMT Driver
+M:	Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+M:	Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+F:	drivers/i2c/busses/i2c-ismt.c
+
 I2C/SMBUS STUB DRIVER
 M:	"Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
 L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-- 
1.7.11.7
