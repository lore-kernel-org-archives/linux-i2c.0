From: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Subject: [PATCHv2 1/3] MAINTAINERS: Add Altera I2C Controller Driver
Date: Mon, 17 Apr 2017 16:49:01 -0500
Message-ID: <1492465743-8679-2-git-send-email-thor.thayer@linux.intel.com>
References: <1492465743-8679-1-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1492465743-8679-1-git-send-email-thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Add maintainer for the Altera I2C Controller Driver.

Signed-off-by: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
v2  No change
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bfaea4..e654d34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -636,6 +636,11 @@ ALPS PS/2 TOUCHPAD DRIVER
 R:	Pali Rohár <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 F:	drivers/input/mouse/alps.*
 
+ALTERA I2C CONTROLLER DRIVER
+M:	Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
+S:	Maintained
+F:	drivers/i2c/busses/i2c-altera.c
+
 ALTERA MAILBOX DRIVER
 M:	Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
 L:	nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org (moderated for non-subscribers)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
