Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565A3CF21A
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jul 2026 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079798; cv=none; b=Mk3KguGJmi6o3R/XSpFsjIbUq0bIPHSwREdTECfPAQFOqqzjrxnwIludO+5nG+PYIp3YZHhCKLetZVeVMwoiR2LoSQCG0N1COLdjgmORvP16WiJe9+m2/kbhZV0HxFvVBFZpzPct7VxFHXTkXz179x4T01bsZXyXkHn60y2bDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079798; c=relaxed/simple;
	bh=df+Oxwu59Tqkfv1QyLsVXk0WC83aGGx+cVeZR7rfgTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui+om6l1c1DCgqucCMr5R+WNOcSA9uUXBheU/DyOPMigUrpnzKI/uk5c5LClsOU5m+6lYa8XyW4KF28clM7CRpCJ9yYDQThLwwueLTwq7tcqqshGkph9JPjwhz3zeq9wJxDYFWsjbLyeU6RtU9UmsZwngUe1obIoJ6fhey7SRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cvjdqbMK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cvjdqbMK"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3810e733d85so388798a91.0
        for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783079796; x=1783684596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wQQi5qAJUnUkHX1saOq3zIx6e8dXlHzf8E6xF+VOzM=;
        b=cvjdqbMKx81gRQXJnVcSuvVfcJjglCzgnvtA8W/kTXYzZraJKM3EvtzK6IHAqz035x
         p6Q1M0zOE8wqFb44Ouv3Js+2FUY+/XnpbkSgJ0ORRt1pI5CqG4jpDeyJnhZzHYWRrPhk
         jcsdOXNzQXg/GwkKjMzjy9zGapKYBFzH/7c7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079796; x=1783684596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wQQi5qAJUnUkHX1saOq3zIx6e8dXlHzf8E6xF+VOzM=;
        b=pg+lepC1OVGdAj3JaSq+6gFuXZvmznUl2aSScq2abzzxUyZlSGjU8BYOwt4gJCjlVQ
         L/HUgq/fs4SJjXK1+YNEmHb+S6h1PmaSRe5LzG7Zq/MGLxQuBZlJNh/LFxXyEygl4OtI
         67HIXm6DSTfSNFr+wY5PG1oKtN2+uaBcYRaE1Gai/HHXokm0qJeoy0Y5sRc5XK042J1T
         hXb3Ocbe72pruNrvL6qVZgdLkYcgGRE0guMJSl9gTsKk4S2gnuFCJ1zFSrgVMm6MvuJE
         99GTLTTqWgVJrLlj9ED1aesDO6FrF088fJOPQY8GC9x5jtnYTLSf9khtp9zVUXMb4Knp
         mRwg==
X-Forwarded-Encrypted: i=1; AFNElJ+fNN3aMJVXB3iAA6CgwH+u6YWEOsHY/G6tuzpju155F3nozllR9lZ6CErZhMgQ5vGV3WVnfv6sccA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGmIptzyEj3QULi9pRDwstunHttUjhQgZRklwe0j/3EzqzUB9o
	w8C0iMHjo58lsg8F+IATueUweMii0z34L4iX9vHcBR8y+6IsYswV5d+Nh1Z2ckzVAg==
X-Gm-Gg: AfdE7clp/X4onzRevM5kQgPr8jo4crMal0z5ZVGy6RvrHfX/2JRtJsq7xQgCLwAIMUt
	uD0eF1/RxF9T5I/ulkSFMEXNdlkxrDI5mF/rhonlHEsxyRLLrhipF4Z/LlTGcUuulHruErQmZ4/
	9s90mChuzrP+z7I/ESH8DgeEmQx5yVJNtnBROWZOEqjBtMijuhOefHykHsmYSdyfG8nfEBXT+tD
	3+jZkUW3TWQSz7eVwKVZtt9yVnk5TSaZvL9nYoAd70HM0KEwYJUkGtPU1LCi907P8kD4viZkL8Z
	MwNzfjGwzY9nIKXXGGEhnBf4pP9TCvnOr2ohmi3Ki+ZrCTRixi8cDqwld5TyQPueRMLnS1fCJXN
	SsWyU9jT6tzBCOB7m02q+/e3FMe5iZzD6RpzUYv98Zw6ZRAwpb+5TZkDju+cZCQeUBtd1fpVklx
	I009forpzbow5UD7UmRA/1ny2As+o97Gc6y6DlX/xRSERAe0W1AfyaWreXa5SpsoOucsTVkH1aF
	j6c87//
X-Received: by 2002:a05:6a21:b88:b0:3bf:6222:2e7e with SMTP id adf61e73a8af0-3bfed0e254cmr11946730637.4.1783079795734;
        Fri, 03 Jul 2026 04:56:35 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8bd30ca5sm2569540a12.0.2026.07.03.04.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:56:35 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: [PATCH v2 7/7] arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics trackpad's supply
Date: Fri,  3 Jul 2026 19:56:00 +0800
Message-ID: <20260703115601.1323491-8-wenst@chromium.org>
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
index 163960f58db5..147a8e9a3a71 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -90,6 +90,8 @@ trackpad@2c {
 		hid-descr-addr = <0x20>;
 		interrupts-extended = <&pio 15 IRQ_TYPE_LEVEL_LOW>;
 		wakeup-source;
+		vdd-supply = <&pp3300_u>;
+		post-power-on-delay-ms = <100>;
 		status = "fail-needs-probe";
 	};
 };
-- 
2.55.0.rc0.799.gd6f94ed593-goog

