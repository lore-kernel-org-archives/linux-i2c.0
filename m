Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CF3E1D02;
	Mon, 10 Aug 2026 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364168; cv=none; b=Fbq6AxofnnTMoviubK892qdGbDJDWW97O4DrMuFPBgA7IfxrYKiUE4CzPRSwY/MeOu52lXQ5OwTbMmUH5TM+yB9tQgMLS+Pux0XEHyqVdXYTxJT2//PvseqmMGVOg6m4vafsiVV4nYgtsaTzZoB3INaR8cF0AIfiCqLiKIOrPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364168; c=relaxed/simple;
	bh=6LzwL3IWqV4HqkMFFNnP2FrxGIQZwrFxRU2U+HKlC+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eA1aT3DLt9BV8WgX2gunR/Oy8BjiSYFbGaGEWqCgqNDRfXOXpjJhCmrIM3l+x5MbIb8NmVZZlKNbtvjVTMB5fJgH0hLiB+5zvQC1Y/NA/SE3gVJpcEnP3ve//u5iQNHqFCY5aBU9a+GhVqHY3JebixFR1Z5xP3xkEuHsrcyeneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=Kod5Do55; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="Kod5Do55"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3AE4C0518;
	Mon, 10 Aug 2026 15:16:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1786364164; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GvvdDodrLnIavxk43AjnGgAOmbOYW9Z/Zj0W0n2gWow=;
	b=Kod5Do550IVo7LWhEaB8L2sfV2wNaEScyjaGkk0HvDWI+D2Nwn9PG2gA+CsjT6oacLEh/d
	wf40NxixC9QkyWCb7h09712kDvNPdbL3HEcUMjoDCzpC2JZ/1TV0hq3R2kuA5ZsePXarYF
	SLvui/daxQaezMenAriTQI+WhhrUabxiPmvY41/MrSyiiRQunVBcnT1PJ8ZvrxznY2+Rvn
	vGMDUaCUY+BKXmJK2PDu6sF3bw/gRN0oaRvBcFKoXQ3sSnC0W11E5GK9ZKNT5gubmRHe2q
	trhbT0mH5yJ+d9kIceiVnyAk54bW59dHYJ2CHrbjHrX0Ad1mYuvG2zk7sPEIvQ==
From: Vladislav Leonov <vlad@zlab.su>
To: linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Leonov <vlad@zlab.su>,
	Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-i2c@vger.kernel.org
Subject: [PATCH 11/25] dt-bindings: i2c: rk3x: Add RV1106 compatible
Date: Mon, 10 Aug 2026 15:11:02 +0300
Message-ID: <20260810121121.210040-12-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260810121121.210040-1-vlad@zlab.su>
References: <20260810121121.210040-1-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The RV1106 I2C controller is compatible with the one found on RK3399,
so add the "rockchip,rv1106-i2c" compatible to the list of variants
that fall back to "rockchip,rk3399-i2c".

Signed-off-by: Vladislav Leonov <vlad@zlab.su>
---

 Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
index 91805fe8f393..725a58a35df7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
@@ -43,6 +43,7 @@ properties:
               - rockchip,rk3568-i2c
               - rockchip,rk3576-i2c
               - rockchip,rk3588-i2c
+              - rockchip,rv1106-i2c
               - rockchip,rv1126-i2c
           - const: rockchip,rk3399-i2c
 
-- 
2.47.3

