Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997248;
	b=EmosoQusSBEJf25eV+ojgqfoIrW0HNoGertS/0+pynlZq2AbWgn7Z/M7w0ZmP61S1ROO
	 iUxXkyDqUHjy9rvfRNwMucpJb3TFBHnjFLRd9KHeLTSxcHToASz/fndEV3bMB+7PyPca5
	 +VOK5jJYQFlCXZ9cY/rf4vsTQrRR/ne73aBFW0dHOA1itIxoG0tL2z0KAPOchHSNJzjei
	 NEiZIgM7LZCuzXH+tPvHYuhWQr/+cN7dIFWOkLahuvNq49BkWwI2vObdMjZ3D5H9hJ1yi
	 qCkzED1EUBup5IbzqvPLDFYdqoJawrS1f7gWrY709hC+F6K9HzzaN9za4TaM5RKhedA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=gVcjezgEWclJLs7JPvEv0jrebO6ljcLz8LLHtlrToWU=;
	b=uD+fk99LUla4ycQDK8Ws7rietHa9Zd+9HuxQFxpMTxjuiI+8ssMUZpUMjGrRsaR/1rYz
	 zvaDEAKiCTAiXZTvGeL9ytxShZije9Q3N/IMTSjqjE1cPI/p6ue1zHrs8Y1QOI20nfksA
	 beKJL84YlAw7B6fEhurCeWQOWU39Mw2pt/AJQjcxB4/Kjy6da/V/rqKy7ysC+YGbJJBjc
	 JhffoWXucEHUDqZbMG0Rg4nAX5nCniDdflCbQ2kosnZGbp5Ozg9qoJe4ZyEWGZvgZjToB
	 HpzQW6lRIp1/z6WIMavhsCwrhueXhRu5TK5nHTqdW55g+9TlKHM1vSoQeJngheZ2K2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mMHVOhnR;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91554606A331;
	Fri,  6 Nov 2026 20:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91554606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mMHVOhnR
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jLrVy1Sx8zlfvpn;
	Fri,  6 Nov 2026 20:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793997239; x=1796589240; bh=gVcje
	zgEWclJLs7JPvEv0jrebO6ljcLz8LLHtlrToWU=; b=mMHVOhnRKwxpuzb9ryaBr
	vp/gDcK1MqFjDBxY6oLcx4cZDboSGgkp5xLAEIILF3D95O/IAvwr2yIW/UgcJPxt
	w115g5tN4fcre0VR+NJPBhq6uyU/cLCQEWl1QxzxmuZxyWpm3FkwlMm+7KcUq9Hw
	Xcy4Uy3Z61YI36kbqUA9Cm/TmGMTvCYTAo4u1xXyoEeyTi1bLIiV0bwvbwTYa3Fv
	o7G4qXX8pX+YiLSV62haHGZEkoH+FL8C85RnEmtvcN21hZKXYFm48VFI6orZbkDh
	aTtN7vPgvzAswSzASMy6D60VFwxXf0JkeLdpG17LrKvwjdGZAZRYzPHDzRGFHWP4
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id w12NYT_q96ej; Fri,  6 Nov 2026 20:33:59 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jLrVs5xsyzlfvpN;
	Fri,  6 Nov 2026 20:33:57 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/3] i2c: mux: pca954x: Introduce pca954x_set_idle_state()
Date: Fri,  6 Nov 2026 12:33:21 -0800
Message-ID: <561e1795c458534235b070e8895669673bf3897c.1793997098.git.bvanassche@acm.org>
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

idle_state_store() calls pca954x_deselect_mux() with a dummy channel
number of 0 since it only needs to program the mux into the state that
corresponds to idle_state. Move the body of pca954x_deselect_mux() into
a new function pca954x_set_idle_state() that does not have a channel
argument, and call that function from idle_state_store(). This prepares
for making pca954x_deselect_mux() report failures that include the
channel number. Also convert the if-statement for MUX_IDLE_DISCONNECT
into an early return.

No functional change intended.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-=
mux-pca954x.c
index e34b4668a1fa..91df2d2fa2b7 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -333,7 +333,8 @@ static int pca954x_select_chan(struct i2c_mux_core *m=
uxc, u32 chan)
 	return ret;
 }
=20
-static int pca954x_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
+/* Program the mux into the state that corresponds to idle_state. */
+static int pca954x_set_idle_state(struct i2c_mux_core *muxc)
 {
 	struct pca954x *data =3D i2c_mux_priv(muxc);
 	struct i2c_client *client =3D data->client;
@@ -345,16 +346,20 @@ static int pca954x_deselect_mux(struct i2c_mux_core=
 *muxc, u32 chan)
 		/* Set the mux back to a predetermined channel */
 		return pca954x_select_chan(muxc, idle_state);
=20
-	if (idle_state =3D=3D MUX_IDLE_DISCONNECT) {
-		/* Deselect active channel */
-		ret =3D pca954x_reg_write(muxc->parent, client, 0);
-		data->last_chan =3D ret < 0 ? -1 : 0;
-		return ret;
-	}
+	/* Leave the mux as-is unless idle_state is MUX_IDLE_DISCONNECT */
+	if (idle_state !=3D MUX_IDLE_DISCONNECT)
+		return 0;
=20
-	/* otherwise leave as-is */
+	/* Deselect active channel */
+	ret =3D pca954x_reg_write(muxc->parent, client, 0);
+	data->last_chan =3D ret < 0 ? -1 : 0;
=20
-	return 0;
+	return ret;
+}
+
+static int pca954x_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
+{
+	return pca954x_set_idle_state(muxc);
 }
=20
 static ssize_t idle_state_show(struct device *dev,
@@ -394,7 +399,7 @@ static ssize_t idle_state_store(struct device *dev,
 	 * idle_state.
 	 */
 	if (data->last_chan !=3D 0 || val !=3D MUX_IDLE_DISCONNECT)
-		ret =3D pca954x_deselect_mux(muxc, 0);
+		ret =3D pca954x_set_idle_state(muxc);
=20
 	i2c_unlock_bus(muxc->parent, I2C_LOCK_SEGMENT);
=20
