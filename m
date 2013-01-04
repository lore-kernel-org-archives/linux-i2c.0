From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 3/6] Bugfix: behavior after collision
Date: Fri,  4 Jan 2013 14:13:32 +0100
Message-ID: <1357305215-17643-4-git-send-email-amaury.decreme@gmail.com>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
 <1357305215-17643-1-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357305215-17643-1-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Datasheet on collision:
	SMBus Collision (SMBCOL_STS)
	This bit is set when a SMBus Collision condition occurs and
	SMBus Host loses in the bus arbitration. The software should
	clear this bit and re-start SMBus operation.

As the status will be cleared in transaction_end, we can remove the
sis630_write and prepare to return -EAGAIN to retry.

Signed-off-by: Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-sis630.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-s=
is630.c
index 3124d80..e152d36 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -200,12 +200,7 @@ static int sis630_transaction_wait(struct i2c_adap=
ter *adap, int size)
=20
 	if (temp & 0x04) {
 		dev_err(&adap->dev, "Bus collision!\n");
-		result =3D -EIO;
-		/*
-		  TBD: Datasheet say:
-		  the software should clear this bit and restart SMBUS operation.
-		  Should we do it or user start request again?
-		*/
+		result =3D -EAGAIN;
 	}
=20
 	return result;
--=20
1.7.8.6
