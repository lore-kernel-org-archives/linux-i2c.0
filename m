From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] misc/eeprom/at24: init dynamic bin_attribute structures
Date: Thu, 11 Mar 2010 01:55:32 +0100
Message-ID: <1268268932-23447-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Albrecht=20Dre=C3=9F?= <albrecht.dress-KvP5wT2u2U0@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Commit 6992f5334995af474c2b58d010d08bc597f0f2fe introduced this require=
ment.

Reported-by: Albrecht Dre=C3=9F <albrecht.dress-KvP5wT2u2U0@public.gmane.org>
Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Eric W. Biederman <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/misc/eeprom/at24.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

Depends on:

http://thread.gmane.org/gmane.linux.drivers.i2c/5496

([PATCH V2] at24: Fall back to byte or word reads if needed)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 88c20da..d2deea4 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -541,6 +541,7 @@ static int at24_probe(struct i2c_client *client, co=
nst struct i2c_device_id *id)
 	at24->bin.attr.mode =3D chip.flags & AT24_FLAG_IRUGO ? S_IRUGO : S_IR=
USR;
 	at24->bin.read =3D at24_bin_read;
 	at24->bin.size =3D chip.byte_len;
+	sysfs_bin_attr_init(&at24->bin);
=20
 	at24->macc.read =3D at24_macc_read;
=20
--=20
1.7.0
