Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2D41E6C0;
	Mon, 12 Oct 2026 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805970; cv=none; b=Zh2Xkbs9X6FuaxSgtKLZPoSvAByIiNFFGlYE4X1CsTvAcw3WTITfXvPydlB502EuIkbe/hsHyArRsIl4Wag/oXblTG4I9HjDB6vw1Vd8g0ak/rip3xa1H1BPWW99fbifewvVL+txNRZLlRRS0XyOvYc/BKg2MTkJTh4V39MDNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805970; c=relaxed/simple;
	bh=KHIxhXzSkAuW+qP0EW3Rz3g2m0B72N+eURwljqbpp4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/YiqOBq+zdb611rSCyKJKiXli3KbJVV9wTYniI+w9Ud0Vd2wDfOSx7K3b1NnQYPzjKfKMF9V1+Zly58Bth4WgwOWro6Zp8iToWy+Bufs+DxW0K/8sviYZorhe45Ysva1d0yjCoT1Us8GNTxpJQa0H+w/4iqtJe0gdGfhwK/Ctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=RbG02Kk8; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="RbG02Kk8"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791805962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9o+Wh8H2pwweiTuS3F6yQGK56k7KHqCuFGUKo3GwUZM=;
	b=RbG02Kk868NtQmGAqNp8de6Qn5apIp6ZamXscVJCD9VqlhXDeE3K5juTqvoMNiTXIhhcpF
	TmhcNgHCOk5iuOavxmxbduHhUGCaw5ndvNKSsNo4r3YZYM/yf1Z0Jk3nSB86zooG6qvNre
	lPZ1dIDfH5Yc//sIvcNaNFsSwuceHMg=
Date: Mon, 12 Oct 2026 13:52:34 +0200
Subject: [PATCH 3/5] dt-bindings: i2c: apple,i2c: Add t8140-i2c compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-3-6c757966a99e@cyberchaos.dev>
References: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
In-Reply-To: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

The i2c block on the Apple Silicon T8140 (A18 Pro) SoC is compatible
with t8103. Add "apple,t8140-i2c" as SoC specific compatible under
"apple,t8103-i2c".

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
index 641f24b0ef4b..ea4ddc838d86 100644
--- a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
@@ -28,6 +28,7 @@ properties:
               - apple,t6031-i2c
               - apple,t8122-i2c
               - apple,t8132-i2c
+              - apple,t8140-i2c
           - const: apple,t8103-i2c
       - items:
           - enum:

-- 
2.55.0

