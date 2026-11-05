Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909235;
	b=gljJlDbIBkEesAJJ72/sLoD8D5DKBcCySujVChw7EO402fzz4k5Qz8VHQUrJIXvkDkVf
	 Pr2KhwEfQ5R8LdPpAqEIK6K1BDpdrPGrSarbxblJfmijQvmbCIT5evi1VFOkK+xBtfpda
	 fv9zAtoH1aEdtzmgxaPs+51iL6jfJXVyWgup578GLjDiyqEIqkcurPcEJF2UFhbZA6agp
	 aEXP7lVmBDcZeldeLG6vr+TFtDhxyBmyGaO+Qh3k9E/86DsfXbM/uJoeqNJMGRbmWwp4W
	 lMfGQ5pmVHu/xypNxI5QWN3uxOxcUYjTg0Y2xplrqXO/TvVi7HQuPPmeSy7AEB4nz4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dCmDJGQnLkybuK/FNJb9oTUo/DUbc0oZdDzO8vpbYhI=;
	b=O/vZh3/s4JEqKnw+zHaIJERZjw8YM43aV9wzw/EI6t/aSIkXOes7Cwh9ez02aEsDjL10
	 eq0Q2V+LewvOaveQLgh7ZWwNC5oBQjHXnL3zzMr31vhzJtf8bQPHXZIPYMAQcIpBfzhul
	 B/4wfDGiYuhpq6HmcjBIRDsfx1lspTWtz51mSGdXPB6dtuem3NJ0n5GzmYWg9GWQtO547
	 17vYn28Wo7ux5iCvLiq9UjVun4CH1PNSylRsmcrffYCP4Nrw/u45K8ICkwn43yPXq3KCz
	 E4AJ1oTP2I3VfmHCJhCQZ6qtCl/sugC84EcYNDFjLGGSwc89vBcWnT4LgXX0hD84P5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NdL4j/Sf";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D669606A336
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 20:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D669606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NdL4j/Sf
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so14373765e9.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 12:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909233; x=1794514033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCmDJGQnLkybuK/FNJb9oTUo/DUbc0oZdDzO8vpbYhI=;
        b=NdL4j/Sf2euHzhcOElIVGfgvu2LhDvenH5bjqq2qaHGaLaIrdyqsOm9TpNX6ft8WhM
         8NKw4opLm/USQ/0OAmiYO/NLb42AVD0JtX68uwzpOHYajR8dsA3ekVp/nvz2T+mFA+Q+
         EoQzAuYrldZcrCCfET5NNuGy3OQ2/6TjKivZN5TAdW7jsmy1T1OQnWV1y7wTr59/qosA
         I8syR2ByaOSihh+UAI31e5TJPH58LGuTTt+qckBr1oAntXuGGIGWmYSPzdkGui4QHCFf
         a1G4ifcX9f0eILhcRlA/hA5aE9cn18E/zl3GBXib0bSdw0fw2XZQVPSa3AYLsKr1xHsK
         Yknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909233; x=1794514033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCmDJGQnLkybuK/FNJb9oTUo/DUbc0oZdDzO8vpbYhI=;
        b=VN7DRzoommJPjBDc/vAaHmaw2e3Wp0wq7Hz8zEEb8gKimMjU8phTvEvwwVRJsbeRoq
         2MT4E9Gdl5Fuzrpu7in+WzoDs8s70jZ7vne8Xx5YzJJNj+GvkIbL3Qsl313AU+pZ+tWN
         MyFwjcqN8b3NdsNoXpYP1BgFLl1WIUxLDBypGb9ICqXhVrKHIrQ3TOy2vOGyavSv2Z+v
         BqEFqVbNb50D1ElWG+RdqX07J//xbmDUI3s6IazwzKzvvxHxTcB8Af8205oYZgItn9Og
         HgicUaXjrqWi75jMd2xib+UaQG+RnQ8lbz/ewGD+p0rwGYBvkCuqNmqboB8pfpMCEKsR
         bCFw==
X-Forwarded-Encrypted: i=1; AKwUvBzpTdtFcrwHT9dV0Xij5/R6a4ppFk0k1uVutthNg1nJQHI770B0vImINbMkvGPmv9pmecDGYMxq8KM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jLvWF84dyYfGPp6LpMprUAAiecaY5Ltx8xzbk6U+ojDm7vyiC
	xbuHBJQEZ2tPpAywdya7snZJjnd3+vCmnjITTuoWPe3EIhap/wV7pVRe
X-Gm-Gg: AYBFou3rCMwrm11OM6KrIvZyJtMoPaRm2rRogt1qBoouIipH+i8ll4cgTTjUvyTvtCv
	OPziUr3KdcLyDz3jMm2bFGFG2yMpnz7DBj9nqrpZ5o5SZgeYPxEWG7KUfgrNRtN6O+yp3wS3Ak9
	oL/Sob/sTM3oaLji0ZGLy/Xr7w+9oeYJG0JggVOW2i7nHli431dBWd+JARuyvREKj6Llf6JtS+V
	NKoO1ymzzaNxmM1722/FVuKHxDkY8JYf+d1dskZgyS3NGBPeNRhdymJsG1L3YccAKqTaoO/kM80
	JqqI0wO5TaDr4Qk9YWOp2Mt9QGsI+dgitw1xrM/da2KXIUTZA7jzsiRuEEafQkBP/dNvWF+W5So
	QN1KaS8YKlDCXJHQJOPX8zpIZbIt94tKSw4hnzp3usE6ufWJJ99dt9dOX4E1REvUtpXrugJnO1O
	aiRSS8B8IvQxsU58WIz331oGk+v3tFnrZVpeebKq9qpfEjbDeYj3yM7WTmTBQhcB2AiIIKpVtm5
	rid+odfMnNg8h1pGIDeLKpJ2BTB3/wPNHEL8PL6euxMbxLJUx0jPSprgJnuOhHRJFpwCcybE240
	WrJaUZMBN1yiksaPuSG0hUc86sQXHgMvwKQAL7RLmwnTPQ6+MCFA48T5p2A=
X-Received: by 2002:a05:600c:1d26:b0:49f:fd40:80fa with SMTP id 5b1f17b1804b1-4b6dff86444mr3062505e9.34.1793909232668;
        Thu, 05 Nov 2026 12:07:12 -0800 (PST)
Received: from antoniarch (78-212-29-45.subs.proxad.net. [78.212.29.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b433ebd278sm131671835e9.3.2026.11.05.12.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:07:12 -0800 (PST)
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
Subject: [PATCH 0/3] i2c: omap: add support for DMA
Date: Thu,  5 Nov 2026 21:05:51 +0100
Message-ID: <20261105200556.34240-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Hello,
This patchset introduces support for the TX & RX DMA transfers in the
am335x/omap I2C controller. I tested this implementation on AM335x 
(Beaglebone Black) and things seem to work fine.

Kind regards,
Antoni Pokusinski

Antoni Pokusinski (3):
  dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
  ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
  i2c: omap: add DMA support

 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml |  12 +
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |   4 +
 drivers/i2c/busses/i2c-omap.c                 | 291 +++++++++++++++++-
 3 files changed, 303 insertions(+), 4 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

