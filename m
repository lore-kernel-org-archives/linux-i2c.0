Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632502;
	b=F1WzP4XJEPnUq6Cdwxn9byTF/pnYAzSQvaHCm1wEwz7IF4gGIWFIf8m1UypdITbQDtqD
	 zzCXBz01iKJXBcmHrQtlrGoHbbRsSIZPK/ZnkAKa1qZJKuaPW9tyRfIkPbCjhmc1a/KEd
	 OJJ+pWupu5dzSvUvERrStAt1LoGD2woeKnwKShRF1bDbYm138UXr1tbK6vwW7bU4h4qt3
	 Nxaue2msoUVWhDHx7ic/CPgX12nSAP53IMlrzRknv2ZZu9U25WJ/15G8LUoKEFc7u7kAQ
	 Gcb17kEnbPadOt49YddcIVKx9ZdjD62PXfFRrHvBZclkKIhr1aUpwA+RlE03zwctjMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
	b=nxeuekv+9ah//5zJD1oRP5uDAZi8duwntr1yc0jP/X92em5g5FekEeYFLYKuohDeZgvA
	 +HtwPWUrjKte4yF8pXkHpuiaIb9FnHgnRS5r/bV01YWwCkkUqYEeaTGGgzu4yHxd5BjbX
	 ArIYF4SALsWm/JmEVKmcOSGtLZRzo6EqjSxNHu67xongi3bzRjDj51QMXrVSzrcPWMPty
	 R0kf6M7q9ePxvP61cDSZDW/2ao+hODCVdn8RynYuhXg27H2e/lpEUSBCHsI5kvYBgccdp
	 Tg5mp4RoNlM+XMbwR64JWKC2ILNmf+sp/ETkLTMJF8qfAJgiFBbuGRiHzsgfHaqe6OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jxwh8KOh;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75382606A69B
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 18:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75382606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jxwh8KOh
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c40e30c26a4so1339949466b.0
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795632500; x=1796237300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=Jxwh8KOhQ3Dae/jpvU9vqBu1U4h7oCjt+9cRvOeg/9BA1/3ExI9swTZ/M0sYHqBBDj
         c2i4gWGAZ5RkbYoOU06qw3aQ7kan1huizoyKOfyhlPhyRswyCamHMI0WY7oTqtsoRsKe
         whb1zatqu7xCt7ksj4q4PPV5rutttpu5mlCJp2yyfSug3Ow5NWLyvQsshoMYAUqQK6ck
         OCby9sx0XRkeMEaZnUmqFeXuUl8e8QJ+tTASqBkSwbS4mCsoVUSJRDNEaMbh7STS2xwB
         Kebhf+L3FNSfhw4nebvnDhJmkqBLv+brIqP09suqGkbqM3oTjFyEpDzocjE13qUa1mKQ
         hJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632500; x=1796237300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=yFqaHbSXu+0ZAUljgqYZzfb+kt6rI0BsrneO1J0b3E32k4YBH5RC9y/XWq3nrNp4QY
         uUYNLu6qyeQgmMnU3xieL/EO4FC4byD5oBBoPz0fonY2LX9wV9qF7auKC+JJQMCseZ3D
         dTW/6TuX4ySWoXuyEMUlfJbS5QvSGuulSBiw4PTOm9Nw/LchU5av/qm70Sw8CTFiD+qW
         VWzgSsDd6dynzE89q+XJP/5rE0s8tT8SP1ZvgERjGeHurpTVj1Jx5JXYzJccToNlKbnL
         dTU67J8riE7p7Dd9fu2hkCVKCuy1J/mrbB7R6kx5dLXCB9dDMQFkVVN4KO2eWrokj1in
         LmPA==
X-Forwarded-Encrypted: i=1; AL+hErF36bVQ5xMxGZacH5OIU+pR7qb+C3x5Q96nAB113Ho2F24CuPm4MRC5Pc9yZfhgn7T7WMtrmBsP9Wk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vzV2eK0JOPTnkaUqD1250Lh5a+KX6J5AJOAOHKopgoVsWOe3K
	OHOlpQjdK7Nlz+F+8mpeA1WfIh7iWJK6MkJ1IUnKe7AloCIHt3coTQjU
X-Gm-Gg: AZFdTZdqBQZ6T40/GWvZS7OhFnBCrsRHKE2MwCDTgBAjtxHt6kR+usxQcY388GuVNB5
	yZPJxMZZ5mHVkOy/bTq1RlfahS7PgqFtSDkfrVjxsPEStQRPyMoU9bo9wvI4INp5sPesGwsiuDl
	cBcN/rOWp4uFNsveSkOniNN3dFIj2pq7+nfk6NHNNkIJMLPdqtzdowvk4EnNgJbmOIsO9j0qdrF
	FG57XWTSKbwE7/bjDzpE7KJ3+WqXr35c9NYvpaSkF/bb+9QESfTb5u93HUIdYZnWRCd0UhpfKhv
	DmE6Qu/KYL6L0tCevmEtPJe3VNT1xF8SUwpuj7dHuc8mqmh8GuQEMsspOKzvuVxQY3iDnGcLPxD
	hFoJTN9+p/JbTQHxWo+aIRs1QFpVIU9v1wF3EqArOL/q6OLL1PvyBbeIO1O56YQuc/XgaDIPsy0
	WqCIX31M4Y/70omEzEXLiwAycmRe4YGheMNF+VBrhcuspx9Q7Y2PCp4qa1W7KHpOedQPvpBAW7+
	bcLUtaL+YWXoEhut6dF5RhcdPtbrLei/9Q+gDQQLrcst3e1rFsw7DUVgpJNbaqpVNtWX8LBpPA1
	L97UI+swvs4EW6iKiI4KF6f+9sWS6IG7J0e48+lxkNBEm1RvwjB/NnsqIGc=
X-Received: by 2002:a17:907:6d0b:b0:c41:1781:a2af with SMTP id a640c23a62f3a-c51317e3353mr1702989166b.9.1795632499856;
        Wed, 25 Nov 2026 10:48:19 -0800 (PST)
Received: from antoniarch (84-40-239-22.cgnat.inetia.pl. [84.40.239.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc73d3sm677226666b.64.2026.11.25.10.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:48:19 -0800 (PST)
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
Subject: [PATCH v4 2/3] ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
Date: Wed, 25 Nov 2026 19:47:47 +0100
Message-ID: <20261125184750.57866-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125184750.57866-1-apokusinski01@gmail.com>
References: <20261125184750.57866-1-apokusinski01@gmail.com>
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

