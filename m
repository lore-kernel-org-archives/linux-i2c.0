From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] i2c: mux: Use __i2c_transfer() instead of calling parent's
 master_xfer()
Date: Fri, 12 Jun 2015 14:40:37 +0200
Message-ID: <557AD345.7090806@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?B?xYF1a2FzeiBHZW1ib3Jvd3NraQ==?= <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Lawnick, Michael (Nokia - DE/Ulm)" <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Newly introduced quirks infrastructure doesn't work for the devices beh=
ind
MUXes because MUX's master_xfer() calls parent's master_xfer() directly
without checking the quirks. Instead of duplicating check code in MUX j=
ust
call __i2c_transfer() instead. This has a side effect on tracing (messa=
ges
will appear on both MUX bus and parent bus), but maybe that's not bad a=
t
the end.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Tested-by: =C5=81ukasz Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-mux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 06cc1ff..98dd5d4 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -51,7 +51,7 @@ static int i2c_mux_master_xfer(struct i2c_adapter *ad=
ap,

 	ret =3D priv->select(parent, priv->mux_priv, priv->chan_id);
 	if (ret >=3D 0)
-		ret =3D parent->algo->master_xfer(parent, msgs, num);
+		ret =3D __i2c_transfer(parent, msgs, num);
 	if (priv->deselect)
 		priv->deselect(parent, priv->mux_priv, priv->chan_id);
