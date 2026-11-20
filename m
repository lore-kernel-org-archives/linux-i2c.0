Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201193;
	b=d8KwIPhQWCc19Z07qi4TTEMg02WFXiuaS0PNhgzGOplpbqpmPT6eFWZLP5dKWEGyERNQ
	 1AJjJRDCeELXfEEsoYPYu57aKt3xvhUxGMJIAeZTZBs1IB6XnQ/+DyK2TsCS3Q8ahRB5V
	 6FfmUFgLlfVYTWVVoptABNeKq0Yh/P0ZQHyxE51Al1s1+yg8snhM0Ihe2wgNj7Cl8YAWo
	 byfK/iNqcEQYOBOyoy4XY2WzwmnAS3dCWLK40arThuKryfGxd8bNf8+vXstV+xxbSkv98
	 jMTNUGIJmNziGNol5qkMAG3r1378KLGk18w9BcwauMhAMmuH63cKiHgmeU4meZQ+UTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
	b=gvXCgPV3Eg0XGyY148OlIo7w5sdy0Rd3W33QMa594snIv5Z+t0rz/pVVTBRtKJbTBBfA
	 2psIs+XLl9immfR6pb8LDEsk2lUjPkBLQPW6coq5jiL8usZTw+yOAVnzOJ31PXTcuDpak
	 chno+ZjjblwiI482dHXTdOZNnkSWPNRvBg2EibapNO5PJRzuMO+n990u3QvX5t9GYh/qJ
	 wddJWrkGT7nsMhrZLrkZGbqV8iLdush+KVxnc23vM7V3LF0HWIbvtIq7pFFNyvpVsX3Lj
	 35xlvujjgQEs9Wm9fwP4hObv1uOUcYcOVX+KSJIVnHNybxifXxgkNP8iZit5FrQdIOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IzVVT4y/";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4160A263C
	for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 18:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCE4160A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IzVVT4y/
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d21051042so234449566b.0
        for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 10:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201189; x=1795805989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=IzVVT4y/3rbXHh6TAeSjFM3cC/AXHTbk+EhYy6zelufBVD4aPc/hWkjoxi1Rmb0jVk
         s8JQtdeHZNZNToyzuRKfrDqtxBtvkSgIcKgvDajPuk9h3TBzAJFbNAbDi2xvVdbfPNjt
         vlhP387H/b2+Jl7MMMbGvXvpSU6EK1dgwwo6qLb32LTYeFMGZkmpvM/PneQqIL8ZLlOu
         w38ix/s2fEZxKMfzh11UOfkdk2e63A3zZV5mnnWLwOmMLdh1YoetQvFl9H8lPkUpKtlq
         ZQUFx3enbC0FIlisEq+y4S8VXTVhJvqt1f86dPpdDm+/xHoNrFTkiN9cJgXlbapmrHdz
         xY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201189; x=1795805989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=s17y1Xb7U0y701o3gTkujj0gSJmCkWwdg4LComcGPyFFRTvMaKZ98cUiYFuszoQ8kf
         ZwrqxJ5OmLNGMfXBZiLQvH5umZ+ceckNzUUs/ZOGJDE1jtJnJ8gWgMtmXHAkVR86iqXI
         8N/Vt8pyd1quX8q/r+w+Qgxt4T6SWiFh9mCec7yq2atGWCOMujvhjC/PTEwh4RtZPeDq
         Dr2ecxMxmCoGlLnlEiANpeoVOR+DfBJGYHFTaODpjIOMcs6Twug5FGpzzJMJXIGSrVv0
         QhuKMQRAfteukSzgkDadhizJ9Wg3/nGng92wpfFqFToczu0HhncEdsMEg+SWPmd8ss11
         kkaA==
X-Forwarded-Encrypted: i=1; AL+hErHUGLic9eqv+5lrAsTwF0tI3Ok1iN08r6R9axHeFaAJIYOzSbzlUbRnDCePXDDwRoy3AdOT1y0gq8Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SRGT7TCP30HN5a7TKo5w/HHx8utYsNq0SrvMnjxg/eGJwe+dp
	AqFz8lk0uqFHECw8ZAaVf1k0b82vVWJTgem4cXcwkct9DoqciI3kjQ51
X-Gm-Gg: AZFdTZdQahsJNK30XXIqYmPlqhMVNqyZ2n+0MY4o2/83WCXqjzGSfD3VFDnA4a3E5Bm
	PeVn4641kaYHdBoMCArahn+aRdEKL3Q4Urer9wjB+IPDjEEh0AkIGgWcxFguEzey58PTtWEKNRZ
	B6u0kq8BzgJVbKE49UQm/sbIuGORlx8OfHCLFMbuP+4dQiJI/chU1uVXNp0JiBk0M24Sw9SCO18
	oH8jx6P7/LboAXdyvUTODXErk3k4QSqf/fXZq+85QUxjCEzyl/fyd6Hns4ThEUWdxowSShN812r
	+Is2+HL7d/GH5klWZK/l3YOy//yYyc/H1Wh3VRwDb2fyK6OjkCg/NeSKak01saSppZ0p3JbNhld
	rNGAo920I3qBfkw3AFu/Fr0E3vnMzVMuZXHgMUMG9GLeOctO19RMYv7bSsiqivIUHuRZgvWIM8P
	Ps7ft6GHddqb+HHlCqg+W1e3Cs9tFiPSeFw5INS1N2dYeUb8PMYhRZZuN1M4l4qSLsk3CPpTZE2
	kWIHJTgO8+7sbf4VQ5WZw4NxS2cFhR+EXNKAYU1oGNXJn08JrbuMcyo9DNEBcmbpq8oOReu5vub
	sDu+dYHKekcS0owWZK/NyaNU1OQpPOIW/jEcm4qtxiHeszMZdjoXviUjfXawIC13oWfVTZ2ifrM
	PVAfYA/o=
X-Received: by 2002:a17:906:f583:b0:c51:3c8f:55e8 with SMTP id a640c23a62f3a-c513c8f658dmr365847966b.46.1795201189284;
        Fri, 20 Nov 2026 10:59:49 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b02de1dsm125205266b.85.2026.11.20.10.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:59:48 -0800 (PST)
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
Subject: [PATCH v3 2/3] ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
Date: Fri, 20 Nov 2026 19:59:12 +0100
Message-ID: <20261120185915.150228-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120185915.150228-1-apokusinski01@gmail.com>
References: <20261120185915.150228-1-apokusinski01@gmail.com>
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

The i2c0 and i2c1 controllers on AM33xx support TX and RX DMA
requests. Add the EDMA request mappings and DMA names for
both controllers.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
index 57a45609f9f5..89fb1d1eb049 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
@@ -239,6 +239,8 @@ i2c0: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <70>;
 				status = "disabled";
+				dmas = <&edma 58 0>, <&edma 59 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
@@ -1189,6 +1191,8 @@ i2c1: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <71>;
 				status = "disabled";
+				dmas = <&edma 60 0>, <&edma 61 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
-- 
2.56.1

