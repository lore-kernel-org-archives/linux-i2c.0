Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680700;
	b=wjqFFefDmaVNqfwqiMK8QkVIcv47Ev8LVoaRk0oVK/RU36pynMAGI5WC71GrfR4I9i3G
	 I9rleLklJvqiRmptsJPC2spK1K3gURxikiOQ/Dk37J4P1+J6ar59qSWGueAdlfwgilv19
	 RbypFWMoBA+MEq2EQEh1bacYzoRZQacStwlHcSFOsBRaz2q0y0yOdaGETegoUbrfpKEXw
	 imGEvelEqIarqpIMjzfCZKwNyAoUpxhmtalUidZ2JsS2tKbu8yyX7jS2KzZmuixS4z5aY
	 okDyBjo+VyGSnUk01z4sXnmAAj1ylAZLWDysOHBip+1Lmc87CV88qIF+XSpmEkRNjcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wOgLDWMrbGue3Y3ijnkKX9LYoTRtoFaZwaUPNmihNOI=;
	b=pZL+hguoz7voS+nduiGXchZrTNr3eYK9M+1fIJGTeFrTP7wZlQ8zEG12sV9nVWIQks27
	 0kISKn0InT0EoDqpP/x4SH6/HERBx9Gad+FVObIU+MucEKe4gERolUmPEWd1Fu3v1rDnR
	 50WfxYl5PE3c3XRnyc2KzMMxn+kVsKhmcggTgGIS9M4ohnZ6hJjCE3a80amoFlBgU0CGg
	 zTwFEgMYbRQ5B4xztKhPGwr3LMZ4lsB3Aqk8h04VzL2wq8EoA7aYlQ2W0CrQLR6OQZ9+T
	 IKFbKPvyl3A7gwdja8VhYqYmAXI5ayFX6ALayoLiGRLIJJMfhqs6AZz75752+Gl9MoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XElVPPXI;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210C606A330
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 04:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E210C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XElVPPXI
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so168805a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 20:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680699; x=1794285499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOgLDWMrbGue3Y3ijnkKX9LYoTRtoFaZwaUPNmihNOI=;
        b=XElVPPXIpP6fosW6+7K3jVrmtXYfBRPTpzAlgEI6/7G5HJ+9KEJPQ3UoWAaex8SJ47
         n5pY1ZRXvWc8XMYoR0maYVkdsXoSj0uwAHnNUnJyH3KKaMRiAFJdNbx6yD/d+aqssFad
         NSUa4WrlOGyXMenr619P4qq1AQplaGBT6NfEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680699; x=1794285499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wOgLDWMrbGue3Y3ijnkKX9LYoTRtoFaZwaUPNmihNOI=;
        b=dUFriwDiJVrXneGcmqz3sPmQ7PpYoYuowO4CHpBoEyMr2ekvUTLHFQvvp1Ct3LkuIU
         bOLY1b4+VymGwHwTxRLP7sevrqQY1OEMGqPUr0ZCkeplTvm1GLtlEfk4+n/8SY6LwC+M
         t7M3jEzHt9Pe8Xy1J9LiEMNvGUYXlByt1B3ylY3dfaYWFfXIoVnT2G1sDdjN/BJp70f4
         8haFYqpCDRR21B7F0nY3heoi8BxkbiunmbTRmL8hRY/SuwKm9nekFOMxjmEwyPYzFRKs
         UMIyCWQ3HoQ4Q39fA9OB7OosOkKMrNCBpHogAEtmn2E0ZHDMvwL4RlMzr4WpN84V+qJg
         jbiw==
X-Forwarded-Encrypted: i=1; AKwUvBz5gnoAgmKoZHjv36MNaZ+uDaVSj1oGXLgKSiGB25bXzGj0j4DNeNi7IQXSJrA3B/eT19DKRNJ0pzU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ox7EQPlUTIZ1MgNlmlJzGwuAiyC9XtJo4g61wUFxo0+7NClT4
	oEY1XqHRvw6A9haNdRADHnsz92S4RLZ2hS4v16XkQrxBLDXcFao5pmheRqjYLHnLYg==
X-Gm-Gg: AYBFou2qDoLHkOxghF0QG8bYT1zd/hExSNlTDE8hG02fTL7M9FOjKl12oX/rntv+SqK
	CZUh1DkBfpOT6yN1wggVh/1K96T5Vp7jIEJD9OG1xsBhl6KmGvKc146sDw40bxxz896NDlm7YaZ
	+vtXxl+i0zhSMC2u7SU60IvqEeEN+n1Y5OxKAhDr3wy3mymoW9U3f2OUc2Hk58xF1WAR5qYHbj4
	33QMWw2dq++NTABWQllp+kF6MazrCc+Fr/AQJwyimk73SpHrQg+U8j9klo8LNnfYPOu66Vjywsw
	ogu3wGNeBc3rne+CIRgb/1A4aeABDfe+11Iu5KetR+F5uvVXh7+THlWsxKEalKxvZiN5CQcKF+W
	zmhA6pdJRtRysC5MuTaS7A9FWXwjbBTgGC+n6NAq3urzjeXm1iw5Y46+QIgKREvSbqEg84E03In
	KFdTmnhTM3XRmVjL8aeEDsqm1tFOiRKFNfSKn8qdmq7A9g7RAp8YbdqpjHRtziDlQHIFQQ2yLuV
	Bnw0O4porLTtx25Ph2tPGrlIGWkLiUUlWJ3jz3+kNSFC2LbdirjQXujtLVOUI5BllUjQ5YJSOZl
	rTSwSt+ZjRJabxUynN6CqgtUVg5f+b6GGa/9QNdmc1Uj0MX/pMNZ9nLnx6MPNKuZTJlmtwxx2Q9
	0t8SbJjWJ9m5YVt/wDUDIMNHHSdrHPSxUmA==
X-Received: by 2002:a17:90b:280c:b0:3a7:a3c8:8f4a with SMTP id 98e67ed59e1d1-3ae8972a6d2mr6631601a91.18.1793680698982;
        Mon, 02 Nov 2026 20:38:18 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:38:18 -0800 (PST)
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
Subject: [PATCH v7 8/8] arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics trackpad's supply
Date: Tue,  3 Nov 2026 12:37:32 +0800
Message-ID: <20261103043734.2179858-9-wenst@chromium.org>
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
2.56.0.385.gac671c819a-goog

