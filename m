Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF43F8243
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194995; cv=none; b=O0PuDhITHiAbdwdxVVAqilnVqHbVsFzOeVTn6MtTzHXIvTdi+UTGc/jIvK6E3MsptFLJavGMTUtZgoiYJSPKzTQ6fdI8oOksf4CZZVwPqDT91t9Nsip1lLYb4cCKrd/BRdrqj5omu0IOufwb9Lg7FPnKo4DRKlANYiF5qG9WEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194995; c=relaxed/simple;
	bh=9msDYNKS2pX3bRTMRkqLXL2c0qeGUzPeGcRivpd7UC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2LSF72fU1yoJr+s+tpFqFx7xjTLMGBeGG1tzE2oH4hxCqyc72khfrH1qDTyTl4uxQKGdwTBInSKP5IRZjrK3uJ0yhVhf/dnH4Z6WURU9BljeQkMMJ4lc3EYY0QTyHk367u6AB+OH7m13PxeAzb0XH7GE9qhvvInZWQOwk1y1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1tP7Fn5; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1tP7Fn5"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b1eso218101966b.1
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 13:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194988; x=1790799788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K6NdCou4tWyO9h5BHGqM0MWB7dKTxAp68NTU6wlSIys=;
        b=g1tP7Fn5T1naBF+UH/jpfkBlYbWdxxg3xDTzyuF8coAGMYevR1Pl8iac4Xq6eHtXra
         +33Uvokv9jeXW4E+pxaSlGqDVYZNDEDsVgxesW0qrzj69DUiLP/I1NLXrFbWWCfXwE+6
         /foVqdlogYYHUFBzH0a5mjgLBnWve4zusT3Fygs9FOqAdvohgJ1fDKnS041zIHsuJp++
         DhvdJV/vvXmeLCFK7xmiFiIxe1S84aYH60HV+j9DGnYzeccV/ewGd6pKCUazbKp4o+cF
         HuwqC4yrNJ1bmtzmGGldWBjjFH5nzO7nJF1Pe4IijhGpDXqGQmIReksteREeUCPnmucK
         /1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194988; x=1790799788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K6NdCou4tWyO9h5BHGqM0MWB7dKTxAp68NTU6wlSIys=;
        b=wkwY+iaUdf9CYK1nSuz06ZvSryFJiH7F6ZxqZZBJnERtlXaiNf2vIVn0z7+pmismpZ
         criB3F7uggFVJtm/EREqbpBSH9l100CEb97dwzEYrrvEGwOOVaO7WqrOAQ9PF+L1GnwP
         +CUGFXE3qCh3vvMGJkKDoNT8QPSd9Y6x/5ngIKLZYrxBEJKRRrqsvEoGCcPzyp2CCsmx
         KISmqr+l4+3YQgN8MMVC26PBirRyoN8iiENIbjcH3gWL/XDFv8CMSbsiTo8BkGleIWI0
         9DQ0ShwppyPV5/HxYSbn750gPXaMfIW1biiALveG/r9a4SaMt27ST7JgoBYbNOdqMiiW
         ld1g==
X-Forwarded-Encrypted: i=1; AKwUvByEMnsDVg4wjqFHN3Bc8Vij/Dvdv4IPOwj6XxsThH3T7oIxqTGnftgwGU0HILgr2SuyUcTc0QFWW4g=@vger.kernel.org
X-Gm-Message-State: AFuF++lBATQsqiLlGNKIMY5ePM8SQU1aWPzupkClX1iLEX4Rv2z2BBWm
	OqN18L5nKlgEszkFt19gbbbZUBdTEdZi8ujiFrO4seDlks1MCJmA6JrB
X-Gm-Gg: AYBFou0ER3rdiDUMpdfFhLDe46hduGEAEc5MJTcRnCD3CrwilcmtT7RX4FqL65g6/YD
	9p5dS+JX9TViV8Dktuz9ydNMn9JJpUp454mfUqXCU3wcrow6zKz0SAnLRVSckyUemNNdoq0wWya
	dh4FY2PL2FMvCuRO0LSst8Pa21aivXJQUvl3OYXFsMdrXRu0TY95KFghJRw93FEpUafIj93sUAs
	0hjjwXt99t0E+6UNCEsffoXlpfW62c2xw/GGnRCI+DBEnnY8f97YlDX9YmUMzBuOizNsEJc9rz3
	AEWppZoC+2cmPBpHZf7kXSa7u4SAeQrlF6LkMR2qM3JHcy7Uwhzr/CZxZ4OtAihhckAHEXvyBtG
	M8ZmT3BjG35B0ANpt7wm5X+UrPLNmPtSJKVyLs2pZ5Z9fBW5LdrqiDgmY8ws85nneCqOMFIclYL
	yXZUuW7QkQy96+UkwDK2pUiduyNT5BCqFf1M94hUxekgV7cVFCIOcWjkOzJIacghZKmgFzAJDBm
	SNKoqduBSZHDVnWuHA35QenlPScP1OV5usfOyKsfLQCk/MZbKWNjg==
X-Received: by 2002:a17:907:6c17:b0:c29:f5d8:9c71 with SMTP id a640c23a62f3a-c2ac223e35emr24501766b.32.1790194987758;
        Wed, 23 Sep 2026 13:23:07 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c8a44sm177243566b.20.2026.09.23.13.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:23:06 -0700 (PDT)
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
Subject: [PATCH v1 07/11] dt-bindings: i2c: mv64xxx: add Allwinner B288
Date: Wed, 23 Sep 2026 21:16:57 +0100
Message-ID: <20260923201701.43391-7-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923201701.43391-1-pmazzini@gmail.com>
References: <20260923201701.43391-1-pmazzini@gmail.com>
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

