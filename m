Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680695;
	b=vyIYyJwMhEvMtxonzTTzLxws59G/QuK/tZa8R1iSnDFM77IbFjNukuPBWzjZN8friqem
	 5XjPblJ+KtasN6pcsAZ+HU+QPD7yXOEzb2vlEtcQKuZjsDz14Vu9ooyUgV5HTZ0fc5Zco
	 1p8TCQ5veUO+4wuU1G7TeYUQSxJ0XiyIEDxW4c3jWJVvkJdGuqzc9CaCt/I0/TbEDJve0
	 uGwV7Z0ASMMiUS1ms8N6BhJ1XWk8Mr86SNjwcxuazPhIoHEx+8CznTbJnRuHowtku6kS0
	 UcWU2z8PyVHOSKawLoRHjALfq/gIXK8f8Yg//6ZdFUTDfmSxvWBc0V+eTJVUO8yP96A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zgiOgJde8AO2Ant4XAq57iC2YxxS16EtAa2Unl+I3/g=;
	b=AtHU6pSGDoeqtmanvSN4h/fr8oldLXBDCD5neF9zAXetHNReuEarQj33e1ayboYQGMfH
	 iuflrA6US0TpZeahedizCosIze92FXn6HWGqaoI7lekoHZW/qSNdjHa9QqEBnpZ0Gjhbb
	 QX450S4Glf3uE7fqIw7vZo+2KCOURvEeF+NtNVi2rgFWpt01EzroQgDT3o+nv+oRmjlCb
	 948H+jvq+3bl0Ru2YQrny/EjgW7peLGgHI5OCHWqdvRWbzV6HGjE+dnYwfVrT/fthhfGr
	 Pel/rWzEHSqx7R6bcvx6tmnBuacmB6jgY/li6iY6gJvXqYcxmdl9xkJv3K94+ylwTRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RoNQqV9j;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69C606A32D
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 04:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B69C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RoNQqV9j
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab41538192so3014233a91.0
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 20:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680694; x=1794285494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zgiOgJde8AO2Ant4XAq57iC2YxxS16EtAa2Unl+I3/g=;
        b=RoNQqV9jBrmKq8aPFdUcTGbhVq76VWe87Mk0rL8irAkCHESNHOA4Uxwferz7yyQfJh
         SJWMN3tlTNiv8tPOeYP9r1CMapa9/kJJVIQpyaVj8d/rM5Joxn/TAlRqQpNSj5fXICvl
         EDvslT7pOQqwACyXNaamHO6m6jd1OzMy6DMpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680694; x=1794285494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zgiOgJde8AO2Ant4XAq57iC2YxxS16EtAa2Unl+I3/g=;
        b=MItex9q73o/D3mqnXWS57UujovWmVVLrD5Z7a8bPobOw3LbsccsJMA2X+EVZqPg85Z
         1GggChaYJsGpzafwfi51WXl1DCoQL02JlyCqqwoU2aTjBu97XrJKV01kC/SeEnfDIAzY
         g26PnWn0xfjeprATQgPj1ZeeHjukCzfRNnUpRe59Uo9xSCTwIctETYMRbHlLiX7MVrUx
         nXkPTSdkQBwTIHLBMaYRniVlPCObkDnAILAFQ6ob7tcs1b9AEfy1PB1awfMyKWbNLd00
         InVb2owG4/DMeR3TNZLEkpeAFlgNfaEO9wTlOTq5opeDofViFkOXP2jDeJVNXBAbYtq8
         DpSQ==
X-Forwarded-Encrypted: i=1; AKwUvBydFFbpMuZSVm1M5G0UvRdXHTsApEDUre9Mcmt6eh7Sa9dxnZ85ap//LcPLCcmKf/VHjda9nVnHaq0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nF2Rz7a7FwUaz60OBjCNOqsO3N+fUiq83Ab4qZRe6nODNZ60Z
	1ZK5pzmBsmrFFUgckyfUx/A7Lftepvq8jSK4032+2IYJ7qZafvvTFkmTcE4zekBrEQ==
X-Gm-Gg: AYBFou0btdCNG/dwppkuVXHghD8NxNW86Dv9Q6JPm++6FOTDzsJNNFNwx4tIMu7axGL
	p6ndZMQ0mPJK27tscbRCoFqg3IdkEGKdFjJkCUDGo/E64kW+BJCeSiSbbw0mzbnWyMSu/PTuIu2
	AHmKYKE205/7UA5WJC6MnjY0e7aDPgMOKuWrl4iYDjOmpyX/dLmFp+2yHDeDIot47Iy32w+FhnS
	HCWaydZfqX0l1zjTJ6/xajkBPFkRJQp0fgQCtY39QSOmdn8yDIkhrnnizcDHIEV6D1IKgpjdqUF
	Ugfa5LhordkFN9BxZj990GpPwwDw168uvz75WKiN0rXJTgGbszd+H0aMWqN6Yy7rkyMTXD9zOBm
	BQykNsIMVya+U6Xn2fHFWp3cRi+Nk2P4CL+KO9+2pwTIT0CN2Zv5xLxXRCRk3G8WTW9M3KsdlcR
	Csq/Xg+k7X5PPnqMONzWxBg++n5Yu3NlVaSqxu5+F7zVNuh6Fv80NxnNs4ZW/FGbqUtkhuCr2/o
	5PXp6CV1CaPUMT/Yqam2ml7G+18i6HdVU/pZMyeGRZ94Urh6BX0pfBVGOwALXp25XEV+amLS/HE
	YP/xTMCymcmgw4Pjb0qNx6eEAcIaa/4KJFEYx5JvlPd+zypmhyB2Mw0O7n9efxe3GI4+yv2uUSu
	uMuZa6s68CvjI
X-Received: by 2002:a17:90b:4b10:b0:3a8:185:cf40 with SMTP id 98e67ed59e1d1-3ae89724b06mr9920661a91.10.1793680694591;
        Mon, 02 Nov 2026 20:38:14 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:38:14 -0800 (PST)
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
Subject: [PATCH v7 7/8] arm64: dts: mediatek: mt8173-elm-hana: Unmark trackpad supply as always-on
Date: Tue,  3 Nov 2026 12:37:31 +0800
Message-ID: <20261103043734.2179858-8-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103043734.2179858-1-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
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
index 777da2129e77..2c6ec714e117 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -1098,7 +1098,6 @@ mt6397_vgp6_reg: ldo_vgp6 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-enable-ramp-delay = <218>;
-				regulator-always-on;
 			};
 
 			mt6397_vibr_reg: ldo_vibr {
-- 
2.56.0.385.gac671c819a-goog

