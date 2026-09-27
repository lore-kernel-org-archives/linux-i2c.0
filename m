Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEDF391E55
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521954; cv=none; b=UHEvzD5+Jb+Cv37Tl43cPyxicZIfRrSG1fAJl6J5moE45J1hP+7SKx2n2Bv2wy5Ouh/M7KSe53TOwuzntX+83+05r5Ag77wgNYhJY6BkPXb2aevxrXBi9k3C5bNtDLSt/ekBI4p138WN0/orUznipybd/UydrnW/bADQ1Tbl6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521954; c=relaxed/simple;
	bh=9msDYNKS2pX3bRTMRkqLXL2c0qeGUzPeGcRivpd7UC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4GL1R4omSSPXEotgzpgFE34/pKnn1bHpjKL3tX4CuJu8udXDDhIRoTvWM1stEch2cW26LQ5YCgOkrKV6WE0P2ZxtXoH5PR0a+y+E/ZJA2E85sXRqAQAFaLOxmAOEyM46X/2LCOlfl4Z2MR969K1zWaQeDeY0Vols475ZpNPl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7L0XEq1; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7L0XEq1"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4888129c46eso1080673f8f.1
        for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790521951; x=1791126751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K6NdCou4tWyO9h5BHGqM0MWB7dKTxAp68NTU6wlSIys=;
        b=Z7L0XEq1o/yYfa1zYAUiJSF2WUBFSiMzjrTFF4gGlrZrvINqv89DDaIRONcVQPR1LC
         VVwe7a7V0GG2Ipa0OgKmGvrSEYfodmCU5b040IqbfyggbjZamtjUlJ8dHuAJmURAEjca
         jacFWqTEdasf0Vy3vi9KJQcnd341cypKbdWUBPYtYIuPWh4FRKiMPXL9UdKphJTPaAyh
         VSYazSSSdOmmBl47RXtB5SnxSVCGJ3xq8Hhjx0Y9yzu1wf2ZUrsuTVlYb8Zkj6LwbUA8
         LuyNBwfiRK4HpyntC4Ey0WHw8SqZ14BcP3tI8tUD7Y5fd/EOENbJIA/ESpbRqPppRWSL
         A+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790521951; x=1791126751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K6NdCou4tWyO9h5BHGqM0MWB7dKTxAp68NTU6wlSIys=;
        b=guj1zkDOxUkOgQTfa9+/JvRjPn+wRNdUcl25WCxRIt34QWwSEOALUFER5z15WIMpH4
         mz3kDMvVpzG9f6mucciA1+iCY1tFU9XsEoxZJNigIxoruAof4S6Gsnw5r73NVyipVVQg
         +843kSJH2t2dhu0tfX0eWETytttzkeIfiLemvYmQhpN+zNuqphMBF7XxbxujdXsVyagj
         QDky3c2k9pdyarTlFT14irAgZVMWxCWb4Iw5U+Dj+93lf75/Aj5o1OAm05tTi+UB3pit
         07w+xn/nOEMiB1/AE+rtC02/OIULHkr5caQs3PIMOcBUu/bp3ENyED6UY2xFG6OX3PnS
         OXrw==
X-Forwarded-Encrypted: i=1; AKwUvBwepVG6pyyIDNO+Ldeloxgxn4JX8xYsLjF6KzaWuC/lcx5ZHJeVvgQQGdzobDT/+chxGhSVHbYzYVk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKkXPXJewMkhbsec7+q0DkbU5kCbj3x8F9WHZD3GLGGNMGX+/u
	3XJIDYyNvzJ77F5eJTXsyco83+kmWjmhLD2EntdcyUxXfmqZrdtqJsGuUyM7wq7UV3M=
X-Gm-Gg: AYBFou2cj8J0/CjEPz1TyIBcFcAAs3PoFZpPoNJSbGxjLOtatJTZn/6LYGhi6faKFrJ
	9nQ6NTMN2+rreRQnXq0QbDqFZMmMHTwX2kY3IPVZg76z1El1Uh914E58fH3bHYtBvUoo5Rv5odz
	hR9BetjVa+KzfwiN6hQkCnxo2ed6zqgz9tQJ/5Syzn6dSbfevtgtRkTJ8Jh1sNBJTZR60SHmWXw
	/is0LQALNlTErhrl4mu2267X+OaDfwWQeAmKXJZCb+USd17IlciEMl+7dTU28T/nYP2Bq23Yrca
	/brzMoCcfNdBOkzmPXeq1vLmaYrXfI7K6SqMoHWO0I58yH0orOh2EynE7PkLXVnYT7RppoiOfRf
	qiNecqI32nYqXGJPFkQ0vlSF3k28cxUcJAZKTrcj/DIIMC/9/FAR4H9aDM/7Qtx8lxWwzrCC3rz
	Gr8r89KvPly5NHA7oBqlkIPXbvhVAvsJJtxR0tqADiIy/AYGttxYKdMI6LA2B+9W3H2iVZwszGo
	STSbAaK/DRCp3Xkk7Ozlfjvnkf5vCvW
X-Received: by 2002:a5d:5d0e:0:b0:488:7f1d:2735 with SMTP id ffacd0b85a97d-4887f1d288amr14500751f8f.57.1790521950666;
        Sun, 27 Sep 2026 08:12:30 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a746c57sm19764208f8f.35.2026.09.27.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 08:12:30 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] dt-bindings: i2c: mv64xxx: add Allwinner B288
Date: Sun, 27 Sep 2026 16:10:12 +0100
Message-ID: <20260927151016.186493-8-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927151016.186493-1-pmazzini@gmail.com>
References: <20260927151016.186493-1-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The B288 controller follows the existing Allwinner variant.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
index c4efcef59133..d3b6f7668621 100644
--- a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
@@ -21,6 +21,7 @@ properties:
           - enum:
               - allwinner,suniv-f1c100s-i2c
               - allwinner,sun8i-a23-i2c
+              - allwinner,sun8i-b288-i2c
               - allwinner,sun8i-a83t-i2c
               - allwinner,sun8i-v536-i2c
               - allwinner,sun50i-a64-i2c
-- 
2.53.0

