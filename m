Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743295;
	b=T0i9yLAc6DVJViurxBBO5yvVh5wTIUOvOD9PMythjJglChw6P7xTMsKJpom+tFCvWrrh
	 e6u8AXH5LnQHuI26uHYDXWVONp6QUlYsE/V3f/W2RAFom1T0l4GrIbqRjnJ8gyoyt2hs7
	 c6pVeK2YjbWGnvgzLKcctO669UgUBkQDccjCW74RGiv0KMDyO4lf0Op1Exv6BjCsctG2M
	 nfQvRXflB3X/PJPP2ImftYS9FZM/eZFyujoE2XDJ+3kKWgZRRZnfeRhfWmrz9Ygf3YmZb
	 bJtlftet+TiffiWdz+nnbfMCWKV/qVSg9graUIwrovdAq2Ox0YbaqNVl3MDAV6JzsLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UGEEbQODlbgW0yPm65/XdY1OQhVeHk40cgCxWPCDAvQ=;
	b=Z0ts6kUIJ+mg7pK1FDo22QHLwvwgc89HThCxjiAS7RYnuF1tVKhmm9/zWn0FbeSqA4mi
	 z/+qonh6lsy+1tbiDnSfxBArMYrf7K6GVCTuG3L3VDfKckcYkX+kSivAhakqSxf5kWlCU
	 WtqG3yRicg3M2khzvCkOqI/6S6sZ2l4Mdis7roui675+u51DGQSqTxwnGLgRPq6C4sCvG
	 u/WYmfWBofu7MuBoS83swQk5l601MmyiPdqgENMV1uWR7JGkJ7IaFyMCZGl/s1OqgKC3K
	 59wkufKIU1Wm349I4IPKzlwmfPwS1Sg2ZdZV9vBXHTQar5p2AtfhOpJP6lnMWauLqeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RwWSAlOZ;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71786606A323
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 08:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71786606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RwWSAlOZ
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so4473715e9.1
        for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792743294; x=1793348094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UGEEbQODlbgW0yPm65/XdY1OQhVeHk40cgCxWPCDAvQ=;
        b=RwWSAlOZ0lTu+017KZB6a1UjhzgaO7n9HVMaX17iFwvj2CJyXZDUspatdQnBdBQe5k
         7OEqo9jjaTVb+z+ZZocORSeA7Ugb/UKlcGyrXJ1o+IeferTmxiNUqMCb5/yLtGasl8Qw
         rb8/0tD7iGGDO/IlC5HjMzKuc/777xosMT9jzMKaD7YSf6llXEjq9U0Q7KW2jup2HbrP
         DizD/FKCvUn5vwuHuixUeWObzTOGBo8IFvYCApRPL0vSPnzkuRixXUtkNtRiHo6R7PeH
         OThHsOypvriFvPvdzKp1lG57r27Ex4R2niXj5UWWGx5NL1/HDd++Nx1t+pAKXCbaQCUD
         IWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743294; x=1793348094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UGEEbQODlbgW0yPm65/XdY1OQhVeHk40cgCxWPCDAvQ=;
        b=PSLKlml3+bRoqvmoBre+JwYh6bGOLnXtEsMujroPRZgOznjW+ZmEU/SQbm9H00smzu
         Fb9ohF9rfrTuOPrRW+WDFrm2WN+cv46etvZJ2EsEZ/27atVPCmHrDSynoM1IYH4Rud26
         ZZaIxtbAbiAJlWC9VUBAzru4pt0+Yf4hePTSt1LgPSam1tKjl7ZlYA3KlavccMIF5xh2
         uu/pvt3NfAE5bWArsDFJf3jjrfifdUiT365CzUIi7gkBu+cQMjqHQ71D7A8g+aov+piJ
         PlKPFMS1AG4lYqsE4q9hWcQYpNPHa3Nl4+qPmSB0yo+SzMgbNDAGDPxYCk+4NgX/Q4kr
         nn/g==
X-Forwarded-Encrypted: i=1; AKwUvBwELIcX/lqTQV+M+CZ+xDnNa+mAEiz+ayPQripqfGA+ZVyQdg7Mcrv8SVLZkzhGa6+7dTtllMorzws=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDSoxXMARKfNJkf/0AVdnGDHIywgZUW1S1VX0rtMKerfNG6CI/
	baMsWT0QFnpuWAekxZJhRtJcVKPchZTnxvHjzFgBRbY3mjIJe+FxgjdEsIukn3UP6Vg=
X-Gm-Gg: AYBFou1V4KV+H7NeFNJepZcLH+n4CfPQnP+gtqSM7W3TcT3Zlx37FV2sOjMu7BXyR3B
	MamzD9TFA/wX6GXW7ay9CIsMXdCmHBrpNHzs4O3GUfVZ4tDoY44G1v7njXFAuV74BwrL04gDo0h
	3S3QuFvXSevP3Zu467JXu1I5RYYJgaBLs7lMt84M3PGy0giqko1z9LH3lm/vZJw0bFYZW/WnVIg
	mB4VZEA6bwJlCeRnh39tNG+1nxlgdD9Xc7/7ZhRcRw9zqD3acsWLaVOcAZidJgdaoPbPCmLhyig
	D9Q0MN9FQBQpeEHkNKSr0oVTIiQ9pEH0RnjKMugeOHF0xh7rPF1p164R+a3goW/p/MC2ukOWSXZ
	G8Z+usJDiTy9bA1hnqs5m93CG760PhKcIO0aBC3KzXkRjMj+bwu6A0xU9Bw5LNCDKUhEE1ikOLv
	1W/mBerbg01abBer5GdGQ9iqdhuV561pMHs0Wbh2dtqNPVwegqtytJUjxJQph8so8+fuSOGuzp4
	iXQFOaaAaZ90znVKp/nLUDWZiKcYDnB5qQUbwf84I9IsDESjaIVPms+HSQS6Bo1J1MMY/DDINBE
	E8HkzXqKZiGJAfCpzIOibwhlpN62i6bZNQ==
X-Received: by 2002:a05:600c:3e15:b0:4a1:dc8e:edc1 with SMTP id 5b1f17b1804b1-4a211b4ab4emr23850455e9.0.1792743293730;
        Fri, 23 Oct 2026 01:14:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:6877:44a0:5297:9502])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3804450bsm3520690f8f.30.2026.10.23.01.14.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 01:14:53 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH 1/2] dt-bindings: i2c: ingenic,i2c: Add the X1600
Date: Fri, 23 Oct 2026 10:14:51 +0200
Message-ID: <20261023081452.44118-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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

The X1600's I2C controller is the X1000's, except for the register that
holds the SDA set-up time (see the next patch). Give it its own
compatible, with no fallback: a driver that doesn't know the X1600 would
program the wrong register.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml b/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
index b61fdc9548d8..43de2856bf0e 100644
--- a/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
@@ -21,6 +21,7 @@ properties:
       - enum:
           - ingenic,jz4770-i2c
           - ingenic,x1000-i2c
+          - ingenic,x1600-i2c
       - items:
           - const: ingenic,jz4780-i2c
           - const: ingenic,jz4770-i2c

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.39.5

