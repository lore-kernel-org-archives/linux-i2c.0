Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257414;
	b=Tp3fpPu55ASg/aXQ2Y/8ZIwb1Zd5Ix2QP1/g1++vrGtEj1YQOYkZLsTK2D/bZ5C0Ojrj
	 7DfbqfFJz41KMkVcBIpMfbVEZ0ouvgRcuIqfOx/QPCkQOnDSlVNI0/AwGMkCwuSBYWE49
	 nHTLZ0FLQosAaybpFtR2LVK1zrGawngTS3Gm4QJnmH+kUBOj9XVSJw4wIt6tZPfX/HYd/
	 HFnNX9QVZTaFnTp889UNvXAOko7XzO3ed/7knmz0MTZzOO5AwSD6T5HaDzJcISlieIMC7
	 K6d3UnO7ysVdXjqV+enr7MEis3qkQosO7/l29wzedcYvC+q8gHT3glY5q26sDugFNAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257414;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pHsOXVxVLlEXOeOwaoQ2j0GNHVZFECcyDzkftLsDHek=;
	b=3f5F7PcQbf25fn+ITWxMuQjoOzttF+mcUgW31l5pvTMqCN6N6FUw1vvaye+D4stZepU7
	 5Beb3lHVePRDdr9JdwCExul/CWne1YA4j3W5f7MTgyxawoa+RY/QrdhD0Y/oQ50FlNIJy
	 fARm4GEqdAyeF7UEDrcPW/ioZfMgpO7+hMnxA/xr/FARE+Iv/sacApdsUrKjSFXohsEst
	 qaxGqZLfF+MJKkySUy7gmuiGxCVWPKugdBhD7F20OQ0vpW9XjnP9lZLR03t+3Z7L98+vV
	 T3t/L46JLsr2ir2zUbvU1ZpbMmxUq5kiENceYcpZ2vbrJt9fMz8iwDwwOkSDOLRHIrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZz1gcvI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377EB606A337;
	Mon,  9 Nov 2026 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZz1gcvI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96331F008A1;
	Mon,  9 Nov 2026 20:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794257413;
	bh=pHsOXVxVLlEXOeOwaoQ2j0GNHVZFECcyDzkftLsDHek=;
	h=From:Subject:Date:To:Cc;
	b=UZz1gcvIrhMnr0bsvjrO5zQ98G288ZwWf4r8HJjmrRmkfFPjCRBhNFyWckYASZQK/
	 5mVXkG/tIv4qzoIJRjQlgQXX8hUfTP3gjrelEG9cpoDPXWz6k6Kn7Vh61hA3WDGXvU
	 U6HL2q0tUgDo2F2eER126laCBTcc/F1NX4SURHjlq9EbpA0QIT3rPY7+KfmRG1VSUg
	 ye7B5MqntDQJpRyOl1wGBkjZLonDRyL3L0KuI1AhtlAKUxn4AMdq3n6DEZFPb8PhTy
	 nL+9yXl4cIhQZWISwknT185gywW2glZibagxB24Dd3nqRXXECeCxdtI2YLz1OgXlkI
	 VWtc7dlR1MjGA==
From: Joshua Crofts <crofts@kernel.org>
Subject: [PATCH 0/6] i2c: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Date: Mon, 09 Nov 2026 21:50:01 +0100
Message-Id: <20261109-i2c-remove-dont-use-autosuspend-v1-0-49a08b8daf36@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQqDMBBG4avIrDuQpGixVyldSOa3nUUTyRgRx
 Ls3uPw27x1kKAqjZ3dQwaamOTX4W0fxO6UPWKWZgguD925kDZELfnkDS04rVwNPdc1WbUESvsc
 HxuBmkX6gVlkKZt2vw+t9nn8X66SScQAAAA==
X-Change-ID: 20261109-i2c-remove-dont-use-autosuspend-3c7e920fdd56
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chris Brandt <chris.brandt@renesas.com>, 
 Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794257409; l=1523;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=wAdUJkUDAkxbjk/LjE0YRGa5u0mixzgcRiCVg2IqxwI=;
 b=65Fv3jq7TmhA+zdfDNZ86aIiq59u0GI3Dk3o5bNnJK/yQBn3U/2105tLuIp7/Pl+9BHgT+NSG
 ebdp4dR8JceDtO7rPFoav4i4U7TCCv4X1IOwo5s18NKckgMdtXoxxrI
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

NOTE: Some drivers in drivers/i2c/ still keep their calls because they either
rely on pm_runtime_dont_use_autosuspend() before pm_runtime_disable() to flush
pending autosuspend delays and trigger synchronous runtime suspension,
or operate on a parent device rather than the platform device itself.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
Joshua Crofts (6):
      i2c: cadence: remove redundant pm_runtime_dont_use_autosuspend() call
      i2c: img-scb: remove redundant pm_runtime_dont_use_autosuspend() call
      i2c: imx: remove redundant pm_runtime_dont_use_autosuspend() calls
      i2c: riic: remove redundant pm_runtime_dont_use_autosuspend() calls
      i2c: stm32f7: remove redundant pm_runtime_dont_use_autosuspend() calls
      i2c: xiic: remove redundant pm_runtime_dont_use_autosuspend() calls

 drivers/i2c/busses/i2c-cadence.c | 1 -
 drivers/i2c/busses/i2c-img-scb.c | 1 -
 drivers/i2c/busses/i2c-imx.c     | 2 --
 drivers/i2c/busses/i2c-riic.c    | 2 --
 drivers/i2c/busses/i2c-stm32f7.c | 2 --
 drivers/i2c/busses/i2c-xiic.c    | 2 --
 6 files changed, 10 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261109-i2c-remove-dont-use-autosuspend-3c7e920fdd56

Best regards,
-- 
Joshua Crofts

