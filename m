Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997247;
	b=QArEkbJv3a3//JOt0wXIJVo427/Aovo8Ht0t2pDA7tOuY2AeLkVd2jZtllW6FaZ/jUc6
	 l3h2sIEg7DD5iIfr4FwXFeJM45ayaoB1mOn9ywVczRP9+EIwmSHGNaXCw/uAwGPTByadb
	 R/m9vJKa9uEujTlc4dUU+d15FNZo1Yd7VRLiGANq8vATuAuqEa5JRvpaYSys2J99G/hep
	 rPQ7pI5XLeNTzHpr6eoTdq/LHBF8Rt4/dEpgVqsHM1pPSf7bXZPW0+b7jpi83AOFTKHCS
	 MRUx/zoDhkP+PMzKa5B0DLAE90BsUhoa+SzZ6TdMo17RJWV17Yg4pgOnxPV+J+z0ewg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=+si3buJcAEUh80xnVYivIHuubUqUeVetRkfB6pI4oHI=;
	b=Y94ZCntQBFL4bAcW7F00DwmGug4NWIAORyW8wxqfLIu4L9lPuz/5+Q5FSh/0k/vLPRyT
	 cuPxm1MhaZULmBjxpZHZwTlxNn540vICINBei1Xz1QBaVAGJbOxO3CCUq4GQ/HFVmFqwG
	 3ODdSBnXgUkPlV4o3O8qWlSvyYep8kntaa2YaZ/+g7Fgfd3OrrS+9MCAmc8eW8tk/BA89
	 eaeDKLYHCtpwJ6el/ObpSBuf+VjkSvcozRUBz3Yp/NJxK49lPjn2kyDkdJViKR5ZeZYAH
	 G+XnpYd7yHoEOmGkCWwy024/2aUWi3D+1Ni51GUdy/2Z10AJKzxFhm86/wlh1qn4GPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="gZp2/4d5";
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8CF606A32D;
	Fri,  6 Nov 2026 20:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF8CF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=gZp2/4d5
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jLrVx3WgBzlfvpM;
	Fri,  6 Nov 2026 20:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793997239; x=1796589240; bh=+si3b
	uJcAEUh80xnVYivIHuubUqUeVetRkfB6pI4oHI=; b=gZp2/4d5cg1OqS2nunXYP
	XEmFTWuonvtOoBX6jQ8oLX9dTMr/vw3XmgXgFn2m+aBFHZ+eFo5FwRROsUpYQvX5
	3tJeW21c0O3/lelgzQnTJh8fkp1C4DkrcXNUUF6Qj2EjLM1zFu8OVRbZjBU0XJMr
	icCu27SlJb14CTosJTBoU4WPDyZt9pH+DexwT0hI+v0y40K+FEzLilC+SuIawp32
	f10MuPvDAQyi7nZg3+31Ni0Ff1N3b86DePCllvfhQUMagO3eYT92ptGDsi5lZWGx
	x/5UsWIc701yryh7hgIhVaCeNhsAPB3I+RdZKk+Zoppeq1YGy+LWOrqXApFqzh8Y
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MCYmKRgbvVMG; Fri,  6 Nov 2026 20:33:59 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jLrVt21Zlzlfvpn;
	Fri,  6 Nov 2026 20:33:58 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 3/3] i2c: mux: pca954x: Report deselect failures
Date: Fri,  6 Nov 2026 12:33:22 -0800
Message-ID: <b7b0ecf4d922595ac1b4b2672405f28189afc889.1793997098.git.bvanassche@acm.org>
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

The i2c-mux core ignores the return value of the deselect callback.
Hence, if programming the mux into its idle state fails, the failure
goes unnoticed and a channel may remain connected until the next
transfer reprograms the mux. Log a rate-limited warning if
pca954x_deselect_mux() fails.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-=
mux-pca954x.c
index 91df2d2fa2b7..45a7d841e7cf 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -359,7 +359,21 @@ static int pca954x_set_idle_state(struct i2c_mux_cor=
e *muxc)
=20
 static int pca954x_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
 {
-	return pca954x_set_idle_state(muxc);
+	struct pca954x *data =3D i2c_mux_priv(muxc);
+	int ret;
+
+	ret =3D pca954x_set_idle_state(muxc);
+	/*
+	 * The i2c-mux core ignores the deselect return value. Report failures
+	 * since these may leave a channel connected until the next transfer
+	 * reprograms the mux.
+	 */
+	if (ret < 0)
+		dev_warn_ratelimited(&data->client->dev,
+				     "failed to deselect channel %u: %d\n",
+				     chan, ret);
+
+	return ret;
 }
=20
 static ssize_t idle_state_show(struct device *dev,
