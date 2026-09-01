Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EBE471274
	for <linux-i2c@vger.kernel.org>; Tue,  1 Sep 2026 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249018; cv=none; b=pQm66bjO2xcdgl7poWNJICydw9IhOdZQo6t+JT+GjXSCn8YUYT+DTz2e9GLga3rQHxsGScTUMo3cEOozjHrImXPfwdDQNwx4iLlWud8eZunqogF3CtD91Z0kZY8fw9A5+4fwgKV/RjfJJnxXCLad0sgvNFYiLhQCdXdpmFo8/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249018; c=relaxed/simple;
	bh=389GhFdcHXE9CQfcu38KBKyKduXJD5XyKzkLeecuPRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzdGiKCT2gRYfXlN6Ms0qOqPwgMEPGIn7SfLHWx04xymnJ5p+8UWptE7Uk/GuSrAZD0ou+hE5I62Jw3MlbZU/nQ8exkYIxWcZ+M/RoJipiEon+1w2/Sb2HDV830OQK8PKPFraV9wxN2WdnBpvIVTSjSai7fCTQ6gef2XEZVTASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eb45KZiC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eb45KZiC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d01663d816so4350025ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 01 Sep 2026 00:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788249017; x=1788853817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2khEECovfca18HsEnd2rATuHpO1VYqgGWGgT+k6yyKQ=;
        b=eb45KZiCKTD+9RGYKgjYq1mwU4GKaWsxlxcQYsA0OvN0LApbY9pj9tCUGcKSPCHV4R
         +auvNxX5MR+5zz+wJqvIRnw4H8iew0FnhwnTfeGzpTSIykn3UB5eHffmAahmRUkwbbwK
         Rfb+VAaXBTaPHdvGaXrFDyGRsSldwULDH3VpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249017; x=1788853817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2khEECovfca18HsEnd2rATuHpO1VYqgGWGgT+k6yyKQ=;
        b=JNV3chXJgwxCJTkgRgbGbYxQJKBbYVFnA1M8+1afMwdYI++OzQKfIp/PLYtC90tCfx
         VgOSEa9kxwcExxXKMNQqE8+1FRmV+SdphnBRYycN9ALomWkneB/7tLrWXoln3hZdKXr8
         gbPaPGXkjbe3SWqLEREtHT4Ti/OFpm7QghDUTIv9nOkiQ3yowZD8cgXNdy6GWYU5xC8F
         1Gmd/jAy1PfMndgQDkNTvUyB27Y2Zi1UI+8LFhSJycxDRZzjmMxJBUrnGlxDNhfIL+2X
         9wFLZDlWwKc+0uFc4i62rvjQHQkuC8f8sEdwBg9n77MTNwIlvINWfV0A7aMkJSiT80ka
         +TVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWKl8Vu+/1D23hIJPQD41w6D9OtWF24XlNsXw6dQ/31ABlP2FDH7VgmXDw0whtxZw4ZGZVA+QMp3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nt+pViqXjGUAFXvp3AryE6vcg3fYnSY3HRy2eGEDhggRpnRS6Y
	pMRIgzDoFXWKlFnXW2dwW8cPzNlSuNl22dQNu0/BJRLEnf9fHCLXYxo355x3dqIbUw==
X-Gm-Gg: AYBFou13xqI/ItEDU+F140Lhc7hAJdx9ZOwCAcM4+HnunhCbHxkfZAEwlyGRixDZweH
	AjYiUikrUZSactz/Sm3BhilFrz67EN7rFMuc+oDmEO/5G+XG1SXebE6m+DNuPj7GXfACryD85TR
	LnSxvrU2KJ3fQGcOS1ZrhPmTcexfFplrO9MC2FaxjHkLKbzhrmiDyrK9zijEhlquTkebg8zCNf0
	0VBM03VPlpliJtAdabXfE/tl+rk4Zx0ZQhrb7Ag1BSZczaT2tN5Iv17302Ez2ez2wJeFm13NwH6
	LyoRCI79tuDPXY4ySoPSgBLuYJ2F7BiQFIiHeJiFb0aJX2952W6YXYzs5ZEpcaANEiFEQZf2zmR
	gpCeu6YoLl26GI3ZGrQcpMlVk2XYPbTUyJmBJ+kkBGg6gD5fC7U1PtwGk0IJeoY1AlwAhHEVgx0
	LodQrdFL9Nu6XJeGRz4OVorHOMDLYXe76koeCjxFZk0q57byb4byF5OWtoW/sEHypjR1YoaX8kj
	a98RKcmOBcmiwyp4jAb16a6Zn/A7jE8TVqb1l2XNzD6AA==
X-Received: by 2002:a17:903:324c:b0:2c2:62ee:5a0d with SMTP id d9443c01a7336-2d74df1c634mr532551805ad.14.1788249015708;
        Tue, 01 Sep 2026 00:50:15 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:8cf:6df0:9c4e:f5e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b699sm48142515ad.59.2026.09.01.00.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:50:15 -0700 (PDT)
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
Subject: [PATCH v6 7/8] arm64: dts: mediatek: mt8173-elm-hana: Unmark trackpad supply as always-on
Date: Tue,  1 Sep 2026 15:49:25 +0800
Message-ID: <20260901074930.764550-8-wenst@chromium.org>
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

Up until now, the MT8173 elm/hana device tree has set the dedicated
regulator supplying the trackpad as always-on, simply because the Elan
driver was missing proper delays. As a result the delay for the
Synaptics trackpad was also omitted, as it was not strictly required
under such a model and delayed the availability of the trackpad to the
user.

The Elan driver recently gained proper delays after power up, with
opportunistic skipping of the delay when the regulator was originally
on. The I2C HID driver gained similar opportunistic delay skipping.
So has the I2C OF component prober library.

Now fix the device tree to have the regulator not be always on, and
let the I2C HID device have the correct post-power-on delay time.

Cc: <stable+noautosel@kernel.org> # needs matching driver changes
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v5:
- Added noautosel tag
---
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi | 8 +-------
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi      | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
index 1004eb8ea52c..b9e311fcd9a0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
@@ -62,13 +62,7 @@ trackpad2: trackpad@2c {
 		pinctrl-0 = <&trackpad_irq>;
 		reg = <0x2c>;
 		hid-descr-addr = <0x0020>;
-		/*
-		 * The trackpad needs a post-power-on delay of 100ms,
-		 * but at time of writing, the power supply for it on
-		 * this board is always on. The delay is therefore not
-		 * added to avoid impacting the readiness of the
-		 * trackpad.
-		 */
+		post-power-on-delay-ms = <100>;
 		vdd-supply = <&mt6397_vgp6_reg>;
 		wakeup-source;
 		status = "fail-needs-probe";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index a0573bc359fb..6b9f47f515c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -1093,7 +1093,6 @@ mt6397_vgp6_reg: ldo_vgp6 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-enable-ramp-delay = <218>;
-				regulator-always-on;
 			};
 
 			mt6397_vibr_reg: ldo_vibr {
-- 
2.55.0.897.gb25b4bd76c-goog

