From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH] i2c: use parent adapter quirks in mux
Date: Fri, 12 Jun 2015 14:41:16 +0200
Message-ID: <557AD36C.6080805@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Lawnick, Michael (Nokia - DE/Ulm)" <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?xYF1a2FzeiBHZW1ib3Jvd3NraQ==?= <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Inherit parent adapter quirks in MUX in case the devices on the multipl=
exed
buses are interested in the adapter limitations.

Signed-off-by: =C5=81ukasz Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-mux.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 4bcefdb..6997493 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -141,6 +141,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_=
adapter *parent,
 	priv->adap.dev.parent =3D &parent->dev;
 	priv->adap.retries =3D parent->retries;
 	priv->adap.timeout =3D parent->timeout;
+	priv->adap.quirks =3D parent->quirks;

 	/* Sanity check on class */
 	if (i2c_mux_parent_classes(parent) & class)
