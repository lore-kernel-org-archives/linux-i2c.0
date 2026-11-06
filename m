Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997248;
	b=sOX/fJfu9KFUrDLaTJJ1+9zwPJDwfdZJvtal4PGDmKJIU7bqfK7WZ6/cYciPlILAXScJ
	 PJQyspnkyJxhGzqHuqmy2n9GgJHlLaWY6utTriCWZhSHHsPpP0ILrI7LIcT49jgkFXRAB
	 gc2Rcd8JacFFc0SJul9m3PyXdy32It9PW6N2P5N3aF2/FjiQsnEnGinFGFB1CY1ptSMMZ
	 /FKDyK7zkHzyLiIm3bzX5X4zk5IKmd/e02/lHJkmrT1MNMyqmkPi+gkbYTWNT9kpMUpS+
	 /+08YNcdBoSq0G255ZFp9nAfwzufrcNvt97K1SAIFkcfRY6ej3YgSZJaiQt9BakpLpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=/IOF/V19N16EABaxgIxcvAymR+qq0u6lovDrZuNPdHM=;
	b=SGxAwuOMvgHfXG5dpHBvPfkxzwvNc/z+AAgsWTgF0A6Fof1P1SXj4zBrTrDXUAlYkeAV
	 +tLWzrgslpz8yzu1siwIoBk0Q8cV2JCGOjGa3ld6l1F6VH5ZucDEiBnavZtMM6/WinWzV
	 mptZsvXJe+zc9ohc3IH2IJv6kEf4QeFOnaOnVgXj6zgizussGmlZh5/N38H2wCyUIhve4
	 z51+xmH3coO+dYS+9vMdOkvn5CqhOjV+NCCLkSkMY0P9G57muuveF/vhOz1o5kYmTsVnY
	 wrdihDyadDkndjkIlBYDwkTf00eFrwMQvYwqgL8hXI5zm/smq66E4qjkTWcp6fVC+nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=4NVL4f8e;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914AE606A330;
	Fri,  6 Nov 2026 20:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 914AE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=4NVL4f8e
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jLrVx2W93zlfvpH;
	Fri,  6 Nov 2026 20:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793997237; x=1796589238; bh=/IOF/
	V19N16EABaxgIxcvAymR+qq0u6lovDrZuNPdHM=; b=4NVL4f8epBSCNOEmI96ae
	vxmkAZ3priSafN1s+7KDjjdiN5a1Nn5vmtJDxzmQ7y1EZR7GUXsGRotPcJkho8nv
	oGyCbOed2qiIM9nXmxWLecgrjU8yKmtLEkrezwgqf2odSgndA7gkNuRP1KU5RDR/
	P/W2GgIRbaDztGeyRRKIYCuoKZJXTuCltK8kk8EF+0KCeKSGl4IrtxBMfHvWKZ0Y
	Vr4RGiPswS7LSxqfe60QLtJJohUzL8CSOERI8y7EIA0F4kOGChu0A7WiG1VUOC/n
	X8wx4i+O+MNDSQB1/m6geeMhEOsHUpmNDG+pCz0CASXMq7LG0BDRskhEFZXExwzB
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jVFJtYYeCyR0; Fri,  6 Nov 2026 20:33:57 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jLrVs2mJYzlfvpM;
	Fri,  6 Nov 2026 20:33:57 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/3] i2c: mux: pca954x: Track unknown channel state
Date: Fri,  6 Nov 2026 12:33:20 -0800
Message-ID: <ae175c48a03114c23a59a20b6fbe086a9cf1ea16.1793997098.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
In-Reply-To: <cover.1793997098.git.bvanassche@acm.org>
References: <cover.1793997098.git.bvanassche@acm.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

pca954x sets last_chan to 0 (disconnected) if initializing, selecting
or disconnecting the mux fails. A failed write may have reached the
mux, e.g. if only the ACK was lost, so the mux state is unknown after
such a failure. Since idle_state_store() skips the disconnect write if
last_chan is 0 and the new idle state is MUX_IDLE_DISCONNECT, a channel
may remain connected after the idle state has been set to disconnect.

Set last_chan to -1 (unknown) after any failed control register write
so that idle_state_store() no longer mistakes an unknown mux state for
disconnected. Make the last_chan test in idle_state_store() explicit
since last_chan is no longer a plain register value. Make
pca954x_init() use a local variable for the register value so that
last_chan is only updated once the outcome of the register write is
known.

Fixes: f1fb64b04bf4 ("i2c: mux: pca954x: allow management of device idle =
state via sysfs")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-=
mux-pca954x.c
index 8fca709ed279..e34b4668a1fa 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -107,7 +107,7 @@ struct chip_desc {
 struct pca954x {
 	const struct chip_desc *chip;
=20
-	u8 last_chan;		/* last register value */
+	s16 last_chan;		/* last register value, or -1 if unknown */
 	/* MUX_IDLE_AS_IS, MUX_IDLE_DISCONNECT or >=3D 0 for channel */
 	s32 idle_state;
=20
@@ -327,7 +327,7 @@ static int pca954x_select_chan(struct i2c_mux_core *m=
uxc, u32 chan)
 	/* Only select the channel if its different from the last channel */
 	if (data->last_chan !=3D regval) {
 		ret =3D pca954x_reg_write(muxc->parent, client, regval);
-		data->last_chan =3D ret < 0 ? 0 : regval;
+		data->last_chan =3D ret < 0 ? -1 : regval;
 	}
=20
 	return ret;
@@ -338,6 +338,7 @@ static int pca954x_deselect_mux(struct i2c_mux_core *=
muxc, u32 chan)
 	struct pca954x *data =3D i2c_mux_priv(muxc);
 	struct i2c_client *client =3D data->client;
 	s32 idle_state;
+	int ret;
=20
 	idle_state =3D READ_ONCE(data->idle_state);
 	if (idle_state >=3D 0)
@@ -346,9 +347,9 @@ static int pca954x_deselect_mux(struct i2c_mux_core *=
muxc, u32 chan)
=20
 	if (idle_state =3D=3D MUX_IDLE_DISCONNECT) {
 		/* Deselect active channel */
-		data->last_chan =3D 0;
-		return pca954x_reg_write(muxc->parent, client,
-					 data->last_chan);
+		ret =3D pca954x_reg_write(muxc->parent, client, 0);
+		data->last_chan =3D ret < 0 ? -1 : 0;
+		return ret;
 	}
=20
 	/* otherwise leave as-is */
@@ -392,7 +393,7 @@ static ssize_t idle_state_store(struct device *dev,
 	 * Set the mux into a state consistent with the new
 	 * idle_state.
 	 */
-	if (data->last_chan || val !=3D MUX_IDLE_DISCONNECT)
+	if (data->last_chan !=3D 0 || val !=3D MUX_IDLE_DISCONNECT)
 		ret =3D pca954x_deselect_mux(muxc, 0);
=20
 	i2c_unlock_bus(muxc->parent, I2C_LOCK_SEGMENT);
@@ -480,12 +481,13 @@ static void pca954x_cleanup(struct i2c_mux_core *mu=
xc)
=20
 static int pca954x_init(struct i2c_client *client, struct pca954x *data)
 {
+	u8 regval;
 	int ret;
=20
 	if (data->idle_state >=3D 0)
-		data->last_chan =3D pca954x_regval(data, data->idle_state);
+		regval =3D pca954x_regval(data, data->idle_state);
 	else
-		data->last_chan =3D 0; /* Disconnect multiplexer */
+		regval =3D 0; /* Disconnect multiplexer */
=20
 	if (device_is_compatible(&client->dev, "maxim,max7357")) {
 		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WRITE_BYTE=
_DATA)) {
@@ -505,18 +507,17 @@ static int pca954x_init(struct i2c_client *client, =
struct pca954x *data)
 						      "maxim,preconnection-wiggle-test-enable"))
 				conf |=3D MAX7357_CONF_PRECONNECT_TEST;
=20
-			ret =3D i2c_smbus_write_byte_data(client, data->last_chan, conf);
+			ret =3D i2c_smbus_write_byte_data(client, regval, conf);
 		} else {
 			dev_warn(&client->dev, "Write byte data not supported."
 				 "Cannot enable enhanced mode features\n");
-			ret =3D i2c_smbus_write_byte(client, data->last_chan);
+			ret =3D i2c_smbus_write_byte(client, regval);
 		}
 	} else {
-		ret =3D i2c_smbus_write_byte(client, data->last_chan);
+		ret =3D i2c_smbus_write_byte(client, regval);
 	}
=20
-	if (ret < 0)
-		data->last_chan =3D 0;
+	data->last_chan =3D ret < 0 ? -1 : regval;
=20
 	return ret;
 }
