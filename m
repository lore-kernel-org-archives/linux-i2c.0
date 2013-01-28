From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 2/6] Bugfix: clear sticky bits
Date: Mon, 28 Jan 2013 22:21:06 +0100
Message-ID: <1359408070-31832-3-git-send-email-amaury.decreme@gmail.com>
References: <20130124083043.57f91a3d@endymion.delvare>
 <1359408070-31832-1-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359408070-31832-1-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
 drivers/i2c/busses/i2c-sis630.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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
1.7.12.4
