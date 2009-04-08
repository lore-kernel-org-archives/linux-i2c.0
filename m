From: Ben Hutchings <bhutchings-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
Subject: [PATCH] Fix sparse warnings for I2C_BOARD_INFO()
Date: Wed, 08 Apr 2009 17:57:33 +0100
Message-ID: <1239209853.3202.15.camel@achroite>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

=EF=BB=BFSince the first argument to I2C_BOARD_INFO() must be a string =
constant,
there is no need to parenthesise it, and adding parentheses results in
an invalid initialiser for char[].  gcc obviously accepts this syntax a=
s
an extension, but sparse complains, e.g.:

drivers/net/sfc/boards.c:173:2: warning: array initialized from parenth=
esized string constant

Therefore, remove the parentheses.

Signed-off-by: Ben Hutchings <bhutchings-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
---
 i2c.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index c86c3b0..f352a0a 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -274,7 +274,7 @@ struct i2c_board_info {
  * are provided using conventional syntax.
  */
 #define I2C_BOARD_INFO(dev_type, dev_addr) \
-	.type =3D (dev_type), .addr =3D (dev_addr)
+	.type =3D dev_type, .addr =3D (dev_addr)
=20
=20
 /* Add-on boards should register/unregister their devices; e.g. a boar=
d

--=20
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
