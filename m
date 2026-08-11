Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF5442FB6
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450873; cv=none; b=lJA54TrEJhdWePNfoMTrYY9FmeDRGsNwpuuMmg8fVvulMDEMiYyIpfKCOnX9d0gwxPuB///cObFiJRuF9KE1jQyG9ONoW79wMAeEc30T7FuRT7QxdoEXRCNUIpeRuhLEQtT2THP1QmSIdrdFlqCzXb8C89Gv/HlJAzaKvReJDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450873; c=relaxed/simple;
	bh=AcYr1FXo/iH50loWw6bRNXzrMnv1gP4UhMWCRYTk09o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4F1wS+yBIy3GzYjOXdPODwDnWhZw8P4ymLDhAasJiVi5TXOJOaGKWTllhfmObSbaqezZmP2uYXMHMjb+FW3ackf1j66ZHHRksu2Ci5Z18LhFL7NCa4sy5cTr532zWZzrZBcUseWbezA3kdNnWqDTJjRGR03tEub35VfigyLNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ScxbrV9i; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ScxbrV9i"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so2404158b3a.3
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450871; x=1787055671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V0/BWpZ1mHkr6NJqOIKhKHqUTotk7EFya8FeeruKRfI=;
        b=ScxbrV9ily9IznGof5fmsJPoTzTNyC82zZbJQLMMM96uywAuNcIzv+MMSs5wIJs3QC
         q6KDt1hRVN59iihSuYJjkA64DoWY8qeyhUi116dSzhZConu1RKzkPr0lO8qEklzLWGNN
         GTp5S+pwRmB2gwBR1dbFwhqJrhmtTb0ayMCDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450871; x=1787055671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V0/BWpZ1mHkr6NJqOIKhKHqUTotk7EFya8FeeruKRfI=;
        b=iZ4Lu684nsws4/Kp0AAVSEHyDPNDePbiclC5bINrc1td5pQuPVASciJygiRQzJI2a0
         ijE8AveYWUkZgydCUr6c//dFE73Tby/EsWQt1CUokPn/DV/oTqMNokVO+tIwklXGhWDS
         XVayYhc3WUEAuFzAoqfOKuiZbZT6+4wENg9J0/YaIG9/rg87k6exDvEuYm11GG5f0GN0
         f7bD0cCHPbyC1s8uny8+K3XvMsaSYopvpF+zdak0aZgAyQolftefTVJoHRBnc1vkM+2M
         TmUv8yyZtEH0HzriHbt6c7fzH7lA08pu++dhqysGLV9VEzc3UAmTE8sTJgcVHM9GY+/v
         AY2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrfWbO1LiT/rUwEUhZ+oubO757T+HvzBMrntqyRhkO8mv3Ys4XBT95Pa1vb6Ifg0eR+NKsgC3sA830=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVfiXi5BPB4mCq+9Hnxp02pYqh1pH+C8bDb0JWaKObIDUAMY2
	2iWiM65v5Vg1pVbaFkSOgA9yl8V17D/ZqEh1WC2LhJVIMU0mIkNL0rza8GGZ0T4brA==
X-Gm-Gg: AR+sD10PHHiTi0ITr7pO6LHqFE70t04JkdDJCkEXLZd7z2psUk0bgve8NdRcmXjZgTp
	Uoo3wags8MOXmlL7TVKxEqLVkHEviEhhkRZ1FcslFwY/1WF6i1N1Yuo54uf8JMZlQ6czk8JmLQ5
	StRBxVJbUbQCUbMe4SAitTDEUOecUUybulxlH9r0Qz5fYaRNucxj66pdVihXm4n91cIhGBCHvFO
	voX06EDQFvlF/ZTsiD+rjdGd5F+UQE+sjqeyhhRYg6SjMvLh0lNwfmeSVruynqZhVe1UeIpqeyS
	BdlWFeC+F7W7+3bE6uhvRQoXcr7tneHPs/7FbP2BFbYYwkVLx3eLg9iJPssn1tfMBuZ1kBeLPVV
	K6R7uJE5MnuFTP9EO1jCz6gZtqKz766VvM3h27TxI06I3EnaAPKfi23Q5we3NGrM9Vxj9rv70Uz
	EF2t71wj5Pg0Ne9aeGbKrUPja8DBioa7q8Ogz/oNs2hEdYuz1NYCzrJ8BCKJwtU4KzK/J8I494F
	r4bC4Rxq39t0kvgpzUj/jbSlXEqnODeKdNWWz+EwmDsFw==
X-Received: by 2002:a05:6a00:17aa:b0:848:2c2e:c79e with SMTP id d2e1a72fcca58-84fa86e19e7mr2769479b3a.12.1786450871439;
        Tue, 11 Aug 2026 05:21:11 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:21:10 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
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
Subject: [PATCH v4 8/9] arm64: dts: mediatek: mt8173-elm-hana: Unmark trackpad supply as always-on
Date: Tue, 11 Aug 2026 20:20:08 +0800
Message-ID: <20260811122011.3539250-9-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260811122011.3539250-1-wenst@chromium.org>
References: <20260811122011.3539250-1-wenst@chromium.org>
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
2.55.0.679.g6767b8d81c-goog

