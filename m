Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4447141A
	for <linux-i2c@vger.kernel.org>; Tue,  1 Sep 2026 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249021; cv=none; b=HDFVIF238wU6GviQ1QqwypX0R2FRG6pjHS6LkQ4/E2fEpi0YL1wZn7j37k0PkDdrEb7/R5KXB8hExlDOiBh2Y4DGcraM7arOP6rDZhsp/U7JY4sPjl6JTBUCshEm/Mz1+XmVQ5AdyfnnYrsjkVNqUxk3n1eguOCPXVxfA0FzODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249021; c=relaxed/simple;
	bh=/rbvHcyLFzkOkhdGFkadotpTkB6WTk/HoLFqLifD8i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4Mkz0ezK/zM33ne470BgnxvmVPuEGrRRnFJDEmgbQw5HTISOIid9p0hx9dIH5c4Ygrm9tw5D662l0YRkSycn7DcUGILPZwQ7ZRuPgNWVnYWK92KUpa7CZtSlFedXVH53rXtZbDOt11FkPcNdmedPxwcRUux5O84yn79KnIinu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WqypnplQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WqypnplQ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d71ae3455aso8934785ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 01 Sep 2026 00:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788249019; x=1788853819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ehsC4fkcGYgZxU5YfTTtJEKH9Dtw/4IjhfNmBesfrM=;
        b=WqypnplQyVWsYZqIG85/APXZrVaLZMa5u3WqpFXEkkKjbClBhfvPLbN1GRxNgMzLMO
         AZdP9/+Yto4wK5TR3mQmZ/qxx1OHofL+O6uy5a7Y4qsPVk2XIxg9E1snvDjtAHy9/BoB
         yiRZne9aNo9S0PiBiWJ4DxUk9yuw+sqaUbSXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249019; x=1788853819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ehsC4fkcGYgZxU5YfTTtJEKH9Dtw/4IjhfNmBesfrM=;
        b=B4Upx0BOmLIG6gqNgO+eOtJO1BC+UL5LNwWp/3d0WLgkRHWIs4bIqr79KO8eoHll6V
         86Cr4Af8KutjXRODYO1jv8mztOlQ9iIPXG+nh1r5zfczd5e/o6djRwB6HKO3zqzeY9/S
         ZF0rnZqWUmY8lS/K68XkoQizs9KNb7lW3eeN8RaETQFYT7NbD3OB8zpkLAseCq1b6M1B
         rBHeYl06kAd+B8nA/TR8181zucgFrSj/VF4Os4/WVN/+U02kEEFbivITl1rp36Ish3RR
         Zycm/7VuDni2nMbfi+rXG4msgL/lNlcEWKJCAxIZOa3EJwMP3PnERQj1erIEeOssHwYc
         s1+g==
X-Forwarded-Encrypted: i=1; AHgh+RoEQuA5oQml44Yb5QSb+cWtbbycKnkr/WCB1WM/arc+bDrrAa27h+qXe9HH8QI9e5mlGIhL7o5jY0M=@vger.kernel.org
X-Gm-Message-State: AFuF++mIB+dCaj8lG4DNBqrVyjB7WAxZJ7nN2HzOk26wPz/DxjJCHQQF
	RAF43GeZ+Ma1ayLR8gQ1GwCGIZE1k2ic8ZcFmQM1eTCzr7Vr4yh5EkWbgRgTrr5SQA==
X-Gm-Gg: AYBFou3HT+Wj+KZjyd/owx1R+63DTg4CF0urk/R+fOFFRFMwXFB02ZXa5L94+upfhRS
	SQEvicM0lVK1MUO1k8A+/jDDRXNkmN61PMaX7i4upYRBehT4dygPPr3oUF3xw+19k1NemsaFNvV
	+AXNrb8ukvAjAjnjf6WmGkHuc5EcL1cs58i8yq2lubeL9u4xbLqTgwvAoBgjEn5MzrX5PpFAk63
	nFChBinno4Ct0LJbGlimLyDFN6jQrd8I5Xn96RdLQVC/0KHNSFtphWAs2HIkC1fmeIFugUZ2IGX
	AgJdtX3kmosExzbLhuJePEVzN3ngGwYIfGJPvbtv9q9j/2Jitxd0d6Hx8zouWvK6byfVlpAMRw0
	6xx9lVJ5bbHYlNOYEA5B4h2czTeq6bv8woPj+WMiYwTBKUolmLKdQRHcltLvzGDWANN1tcjKnjM
	FXXRHaYYvnccMXrE1w9jZIAaIA9ZlbzFrercqaYy2R1VKnv3HZKjQTECCiQye3/JTlCHT45CAVp
	gl3Lc5miClXeK2Im69rSb6wnbwSLsNjIHtG3gk2fyhUTlw=
X-Received: by 2002:a17:902:f791:b0:2d9:1dee:43db with SMTP id d9443c01a7336-2d91dee456dmr196089085ad.15.1788249019467;
        Tue, 01 Sep 2026 00:50:19 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:8cf:6df0:9c4e:f5e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b699sm48142515ad.59.2026.09.01.00.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:50:19 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: [PATCH v6 8/8] arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics trackpad's supply
Date: Tue,  1 Sep 2026 15:49:26 +0800
Message-ID: <20260901074930.764550-9-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260901074930.764550-1-wenst@chromium.org>
References: <20260901074930.764550-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Synaptics trackpad, like the Elan trackpad option, is fed from the
system 3.3V power rail. Add it to the trackpad device node.

Also add the correct post-power-on delay, even though in practice it is
not required. The Synaptics trackpad requires 100ms after power-on (or
deasserting the reset, whichever comes later) to fully initialize. The
power is always on and the reset pin is not routed out, so the
implementation could try skipping the delay.

Cc: <stable+noautosel@kernel.org> # Without driver changes only lengthens probe time
Fixes: 925ebc0cd55c ("arm64: dts: mt8192-asurada-spherion: Add Synaptics trackpad support")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
I think this shouldn't be backported, as backporting it without the
driver enhancements just delays the trackpad probing with no real
gains.
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
index 68caf4c58cfe..8adbfc307fca 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -94,6 +94,8 @@ trackpad@2c {
 		hid-descr-addr = <0x20>;
 		interrupts-extended = <&pio 15 IRQ_TYPE_LEVEL_LOW>;
 		wakeup-source;
+		vdd-supply = <&pp3300_u>;
+		post-power-on-delay-ms = <100>;
 		status = "fail-needs-probe";
 	};
 };
-- 
2.55.0.897.gb25b4bd76c-goog

