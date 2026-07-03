Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779F3CEB9A
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jul 2026 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079794; cv=none; b=jjvSGXW4EuRK3oPVi6KhmM5OpCFZgFRt6wZAW/SVVvkELScDj5jzP4QK+ghtVhpPHyTN3qPHG+2vgdu3aVv/tzWGKDTpPP4mLYL1B+4XGN76hA+Lb4zA3NkT2jFI5rrXHGQjBa+PA6jtymzjV/ItA+SS0JoVg3YjKuxKermFjfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079794; c=relaxed/simple;
	bh=Srk1RIAGXch5zh+F4rdikiS478Esg/UB/P4R5OTlkyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF4prMfb0XHCSK3ql+frctYRViM14Hn+iRxytXZRkDKA6CvGYG3xXnrhGJJ/59T05d6V0fc//AvPINClnlr+EQoT+MGea0+H/VlCrsZtRInzgwVbYjvIHjpmWc/ZpaIxDoGidwPzAxYNTZULrnj6Wwndk3M6RQcs33AWaybuWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RhaUknNh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RhaUknNh"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37e0fb87b75so588016a91.3
        for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783079792; x=1783684592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIWHnFcEQq2TBgkIFQBCpLfgyHT2aySOS2MIMPq9LZ0=;
        b=RhaUknNhY/y9nl8qyLVZdJAnaTYjPzHvtbrcsoDj5yviQkCIVXLdj3hzH6E4Swe3C+
         nVrx2rOK+2pO7s7z/IUJv2h+xW9e6nJhl3eet5f9injTbrki42e0WFHujQ40pRaC109k
         1/cRrl3NVJX4BBAwe6/Pm+XNDMiXPr4lygSgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079792; x=1783684592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIWHnFcEQq2TBgkIFQBCpLfgyHT2aySOS2MIMPq9LZ0=;
        b=gUX58axd5zgrDqiAVGfh6DGXcZ4txwq0Jvz+nNU1rT06K413AvHew02jyxvev8SLgC
         gHG3Nob1juLjOGlPJDLh9S7EBTatMGVCuct9f82SkRhL5dp8HHh6Bmj/kivB6vkDuZ3K
         om6aypaEabQkvWne8kuS26/d3ya/uAtdGcifZvL92R0lvc/W+mO4svIvMcqhkvqwKawm
         4ESMnuwAfBwYQS/HMVWP3UmcJgNd9x7+auRvS7A40pyWo6QHMgjNYoscXixRyw+9rQiY
         Qd2x6HnwKyjdNehQPcHwIgMW2DMZ+Omflk1ZMO8Jlj0OmjRNqOfKQTE7UA950wYEWbNJ
         lTgg==
X-Forwarded-Encrypted: i=1; AFNElJ8SmLVWrV8d8P8ej9KriYIIut9YGzYNL8913t0cQbfBKTFt2DdelV2SPkqCqMRhdI5frrJvL9z26rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHEn3bzQvitWrAKoplRXKBTlNgji3PfJfZxHrfa6CHvCTNaUws
	9BhEUgSs41h9+9XCqXLtRfp1BNZVOWWq06w+hi7f3H9vYpEundHMys1AFyhSYdQ1+g==
X-Gm-Gg: AfdE7ckd3hNVeyemSNjGA2G5QGvX/y5UXzbhgNnDV2Q3QA+RRhbsuL8/0+XV5KbqWqg
	4lZTHIu+JmSF2eKAlvlo1Nq2vhtBGrfhPW1AC0Hzc0Of+T8t5liLeQiVLP4/jmeQWnwJBP707Ss
	895o1Smw/aN155GkAgfY2u6F6Q9OYZmk1eu97elZ/J3QFV1Kzg729p9Fw26IQqUej6TgLr3LGqp
	cAvZ2dzDRmPUk2bkWMYYOZQAxubj892kVcX+wC//O0MSFuvXiI3yQYqci7IYl4PCsVKzBaXbAQn
	USI4gxXjR21iJ6dhvl71dBuxfLY1duPGfprPDSclzwjI7x1czp+7XQKQ+h745bW8N2FF2QJRpMR
	LIAcVVnA8zDG9tTDqN2Unerqpv5j34unhAi+kewRSavh5YorBhaznbToPyA2Q9Uz27VskcVZfMO
	VjuD/b8d/k9nhMRQF+YhV4J9s4u1y4hUTABkePqosvmW/jaW7lCh5+v6CLVdRoI1JiyjBT5w==
X-Received: by 2002:a05:6a20:2d14:b0:3a0:b781:4c78 with SMTP id adf61e73a8af0-3bfed1bf5c0mr13230564637.15.1783079791119;
        Fri, 03 Jul 2026 04:56:31 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8bd30ca5sm2569540a12.0.2026.07.03.04.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:56:30 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] arm64: dts: mediatek: mt8173-elm-hana: Unmark trackpad supply as always-on
Date: Fri,  3 Jul 2026 19:55:59 +0800
Message-ID: <20260703115601.1323491-7-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703115601.1323491-1-wenst@chromium.org>
References: <20260703115601.1323491-1-wenst@chromium.org>
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

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
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
2.55.0.rc0.799.gd6f94ed593-goog

