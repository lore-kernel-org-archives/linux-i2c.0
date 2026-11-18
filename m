Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035191;
	b=bl7sgG0fbqBp+D9+Mp96eddz5FZ+iyNQod7cgCB1N1MZ/tUR5GQE5pvYsX5TqeGbnntt
	 WPNH3l+YBbot92rsvfTIsVM+hvjUVZ+9iY5EZp88ifiO3RrjlD6KG3tkhPAv3Jlgo7uH8
	 rIQUab9TiZ51eauCe5SaQW6hlykQxwIDKFY10AlHmBtXQHhTfdR+JXkydqak0yA3BH/YS
	 4WHPdAu/DeDnfbi75AvtgVmzmwvaSRHGtJ6edwoH3stp7NffT64HgVUqrhLhRnfUtdWUr
	 fgrlY8kx8/XIFaFzHQmbXyFVxW9YwnUp+pvIj73O0BrbkOHcKjsz7fAmwoDc8HW59Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yM3BPJ8QKqRePbbotO/o8nLTIwSIfzAlG3YqharGRPA=;
	b=VCTB63Nu9oJTsf2261hFzqxINMqMvqFXBg+uqLiV35nS+ySgFoh5gUzWIH0+VzsiH2Mu
	 w7OQx1xqrsrna+W4jl7pu/s183fyIQ3gbh3aDH3/+CSG4IttxZYjaDSHFQy9cURIdz0MZ
	 WLhOoaUAfgIuRf7mSj+0xrUCL/nYXefpyPWpIO3BZuM769CTLzUSPcimSbpr/fvou0Z5l
	 X498rB0Dteb23+GSKcY1tRwDA309h93scZC/7oH4Qc5Wd5Zlna1/+ZCiQT982l22ZNTCJ
	 Fk/8px2cGszPQyxtvCilonMxUyinGzQ3hGwwN2q79XFRAahaJwMeAgy2bjovVHJFneQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0YGOL0/h";
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AE60A2604
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 20:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 288AE60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0YGOL0/h
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c40f29667e6so235859566b.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035189; x=1795639989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yM3BPJ8QKqRePbbotO/o8nLTIwSIfzAlG3YqharGRPA=;
        b=0YGOL0/hyy6+47TsMZ+kpoOWJcdMNz0GQ5f6BO1ey+aUmPaC7C71wt2b8RcN4Npjpt
         ZZBnKB0GopgEbcVVyhxPsQdkIoxmT1KFZJ4Phbk9TfkdktIBirbceKHg97mcgujRhAB5
         9XTBHooBlgxF5Wew11cVQUHE8Hla1aNPc4Peiq6BKv3nUwdbxqjnV11oq0FG9syzUWzh
         +7JfH+eFSVVOemmQNNHUb/ulaN8WoGpGuhrjrpY+R0w4aElmtEQqoXcX2SKDk4L/eGOS
         1xR2eW/G8uFy7TstA8Fqx2tZvmS/ayRWdPAHIj2etOseL8xKMjKXkO9WQ+ii653YBZ1s
         xXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035189; x=1795639989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yM3BPJ8QKqRePbbotO/o8nLTIwSIfzAlG3YqharGRPA=;
        b=YN8CwyE7OO3L0o7VohcWCVRyl9UBFZun7zrybw57ymi3gVtOMZPBcuQta50owy5R7c
         zyeeZVdGTPAy6GjUr91M3pL+FJef9Uxk//SkA0nPSdCurWcjlfOTDjWakQ5Ve2nwrTr/
         WG6O6kIkqLoaibI4VcGC8kLnVTkpE8uhEkF0BWO1Nj0TPflQ22CN0XcNvYiMOdYrnHQz
         DD7NAygdJ/RtdEaulIa6psDrn4KdgdIfzLY/FkKfpEwJG2Bs3mX0YZI1615IKoEpv8Y3
         wPYUNJhnCepO3w9/y8NkQHacefLtvK2N4JZU25aTyVkfFVk4E2OlsHuR9wRAuSOF8kSm
         rQ9A==
X-Forwarded-Encrypted: i=1; AL+hErGCG93enNy+iQhcNZN6RWRHW68ACn7A2GDz+IMR66f55n3C1GeTAHzjrrGmSzmHCE2ZUmcLOIoE06k=@vger.kernel.org
X-Gm-Message-State: APuU4Z++SrZQtp0IE3s3OjmG1F6tuEBhnrZhbbnftYYqOJnAnSYdCtS1
	QS7XScTuW6goFUxZ0CwWrK4CvEa234s+WpUca3jGo7JXA6dmFZartNb8
X-Gm-Gg: AYBFou3/2MS0gHcU4hbMhQKvnNNgLeKPVH15IsOIZccNuARumr5xpZWdyuxcJ7nk8y6
	UGao+oJ1pdCYVUE+Bk4n0xOG+84v0n59Ucnnu6s/Il90vNVbKqnbGgsIZ/4E8tXqRaXsPBj0PX7
	oqpe0L4FwZ9UsRHnYIovkI6spaZ6ncPPosWxwAOYiK0CP1x+ADA6gJ7YmaH3qkWb9gu8yrDENAY
	MQ7woJNh2lV+PxqBRh87W+tlGAJNzbGsGi81KoADft4enM/oSubprGTnn4Ao/u9wVQaTJvrL+WP
	tNX+fbd4hVH2k6F62X/EvUGBSGgCR3O3p5yWi1rxcddrW9bAsR9nVnxesNwz1m476Ct0ceJdaRv
	I1snTUnP6xI6nHQJn9t8PGpwfuOUkHynaxx25t3XoyZQXc0NoRIQcoIHcgBZB9gRg+QlcmCGozu
	TavUskzNO6dpC3d+fbmUhL86fuQroQ4Fw94TDmFHLiUP48wsG11GiCTMZmO/bQP4Eb3c+A5gTzf
	s8ujPbzCM/T2UNsSo0e0z1la52sFYYJ5QZAC/HanplILoSSrY8hKe8m8PSvCZOjSDTj+c4t+xRZ
	Nt227l3WjyYtS14jBrMraWzceXJMRXYG4naoZD5vPuNQxrLt8D8ozVgHqKvN8g==
X-Received: by 2002:a17:906:9f8a:b0:c41:61b9:6ef6 with SMTP id a640c23a62f3a-c510e376c7dmr374133066b.27.1795035189529;
        Wed, 18 Nov 2026 12:53:09 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:53:09 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	jmkrzyszt@gmail.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 3/4] i2c: omap: remove unused is_rdr and is_xdr function arguments
Date: Wed, 18 Nov 2026 21:52:06 +0100
Message-ID: <20261118205213.88778-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118205213.88778-1-apokusinski01@gmail.com>
References: <20261118205213.88778-1-apokusinski01@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both functions omap_i2c_{receive|transmit}_data() have unused arguments
is_{r|x}dr which can be deleted.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f02d294db42a..3f7060d57a86 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -996,8 +996,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *omap)
 	return 0;
 }
 
-static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_rdr)
+static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1017,8 +1016,7 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
 	}
 }
 
-static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_xdr)
+static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1122,7 +1120,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 					OMAP_I2C_BUFSTAT_REG) >> 8) & 0x3F;
 			}
 
-			omap_i2c_receive_data(omap, num_bytes, true);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RDR);
 			continue;
 		}
@@ -1133,7 +1131,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			omap_i2c_receive_data(omap, num_bytes, false);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RRDY);
 			continue;
 		}
@@ -1145,7 +1143,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->fifo_size)
 				num_bytes = omap->buf_len;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, true);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
@@ -1160,7 +1158,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, false);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
-- 
2.56.1

