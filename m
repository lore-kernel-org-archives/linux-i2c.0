From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/6] Bugfix: clear sticky bits
Date: Fri,  4 Jan 2013 14:13:31 +0100
Message-ID: <1357305215-17643-3-git-send-email-amaury.decreme@gmail.com>
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

The sticky bits must be cleared at the end of the transaction by writin=
g
a 1 to all fields.

Datasheet:
	SMBus Status (SMB_STS)
	The following registers are all sticky bits and only can be
	cleared by writing a one to their corresponding fields.

Signed-off-by: Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-sis630.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-s=
is630.c
index df8e20a..3124d80 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -213,10 +213,8 @@ static int sis630_transaction_wait(struct i2c_adap=
ter *adap, int size)
=20
 static void sis630_transaction_end(struct i2c_adapter *adap, u8 oldclo=
ck)
 {
-	int temp =3D 0;
-
 	/* clear all status "sticky" bits */
-	sis630_write(SMB_STS, temp);
+	sis630_write(SMB_STS, 0xFF);
=20
 	dev_dbg(&adap->dev, "SMB_CNT before clock restore 0x%02x\n", sis630_r=
ead(SMB_CNT));
=20
--=20
1.7.8.6
