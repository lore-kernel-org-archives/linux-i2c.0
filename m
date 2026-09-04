Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8959348BD35
	for <linux-i2c@vger.kernel.org>; Fri,  4 Sep 2026 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524640; cv=none; b=R1fQ0ddD1I++3c9m6TbyhE20UGAWXVD/U7mLqe936LDH5jWTLJ0JlIlLnfJBz/jiJ6Y3lUsuvnyPkJtvRWSm+kqi2ewclYsZta5vbByAVIEtajjX6/lXWa5ceTBFUtsgelWshb6CCbafiiz3o0mg8j8cxlBB5rWMJMjfffSB+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524640; c=relaxed/simple;
	bh=poUlbWaja30lXHDUeBcKx00bBCGEmEtOhGzUkRYmC9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLKh0/13iusyr18ke/ifYS/kYR39uzGjfy9rAA3w10x9xjAGE0Lykk/HhLwEzgDAnyfGtznndYnK9L9XL11oMVVQeLylG438SKrAUdJJBbTSvyInStMXwg65FTwWRhaxEVtMVk7Q7hUNkgUaK3Z5Ca7OtGwRGi95XSO+gt0i0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCmzjsUh; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCmzjsUh"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f3f52143cdso795461a34.2
        for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524637; x=1789129437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RBQDJXUvrfsElnYU1sGgm0rYGUTrAevC7wR86kwakV4=;
        b=YCmzjsUhfZtgsLIqghQPD+ep++EHtwdMXoEl0il3TFZClIZSC7POHWzbLCtSqmyQw3
         lA6oWk/FDGKoEgOHp6/GK1T6y7BdDZKXCBP2jR74ASnydE2o/mJbMxh4qILq85Oni9qp
         obUTLY3dUiYjmPnEF2kT/jLIzH7cq/P04lgQlUCaORti/vzhsDBDEJ6OQ3Teh9rADjzC
         u2IsohweNDrvSFC0DEsR+QjddvEPLRZLS0ANrQeyRCQ2928llmT74ELXETKVShgviHOC
         KPPbo6B4PmfQCr2tI2YEg/84I5dgB2m2+o43Feh80nkKtLwBr+3+96CXgw4E6Yz50qdQ
         GuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524637; x=1789129437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RBQDJXUvrfsElnYU1sGgm0rYGUTrAevC7wR86kwakV4=;
        b=Twq+cxbtr62IfG7Wa3UZEF8J9xPjYkLAtni3Sffb0PbUu4PuK7oaMOaIIw3GiN/Mcu
         EmStmYu9vTpRye4LwM3P73NzzPHxYKsx0sFor6nFjB0eVkf47tKVHbgrgekCYYCzYHug
         0IoYuiV7MDxBKGje9dfwLhkodKTcziqB7BCQTP9nSe/9M3DPgqvCYoyVB0ydLkLZRGGJ
         EjSYlW3G+NI7m8cqO8nnMFhpio7+XpXR68fzF/kc8/3zx1iMqsW9ihM/as/HuPX9tjni
         VfOELjAyV5Oe5gdY9tqVQN+l7pkrE7AlG2cyQuedBVu3zj5jSUfYPv2dj4zGYsyxr5OY
         BVbw==
X-Forwarded-Encrypted: i=1; AKwUvBxH0l5nu6g/cciDRNQUdNKxDAwRAGrSuJwEfBUZFl+vm54ugjA8J1QVO9V7i2ZJaNRyQCgr/kmvHlE=@vger.kernel.org
X-Gm-Message-State: AFuF++kKnrbLyutPR4MeWxIRryTIWdOs7Z18QlDh3R/S8s6C1UbJaQYP
	jCc+zXLApoTwMwh91Nhp8PrtZwBL13sjAg0yAx6WMrcKoqpdnP4XkuTO
X-Gm-Gg: AYBFou3KJGBcn+ezRI+b8XMUJakcc7NGflieX4T89ufe7wa6+tvXSSH18fzvXnKCl5L
	1IcU1udSUURBPNckUu5y9tOQoQDdk+eQg888pFgNgJgqwZavE4nlPezeFa84CMc0ZoRrhUwxASg
	H8UZRpdYE6hdGY5sRrfVAH/ya9uFG0i/uy/CF0Eo22O8h8F5/3mQEo5Mj6KX/4s4/8aio1yh6Ea
	cnZn4peagtdqoxjQZU/lcZCTU0ACenJJg1mGgO5eiMhI1X9rx6jwTYG9meQyUVVO9JaO4l+F0kW
	a5jbYd7i1Ib2JHbWBXqVn1Yp7IdNxJ7vqqox3XNBe9kPsu1OpEP4dRWhOTz9Efyf5sFwRfJl7R9
	CrrXGYNI4E68VNf+XzONWJDwKd9XfLr7aOcCtFDdixLXmlgK9bt4W1YKau3eJNcu8da1wbMKCMw
	spy78OhpENuieuf6JZfnkkl74Vjf1W4JWVCqxjdTKhIuucNqkMsGP5rVe/MGKghAvDlOLVrwXv2
	rjY1iTdqTI2Z7c=
X-Received: by 2002:a05:6820:162b:b0:6b6:8fb3:5841 with SMTP id 006d021491bc7-6b6fa4e05e7mr4184999eaf.6.1788524637290;
        Fri, 04 Sep 2026 05:23:57 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm6209359c88.0.2026.09.04.05.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:23:56 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: [PATCH 2/2] i2c: busses: fix typo "retreive" in comment
Date: Fri,  4 Sep 2026 17:53:41 +0530
Message-ID: <20260904122342.30456-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904122342.30456-1-hemanth.selam@gmail.com>
References: <20260904122342.30456-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "retreive" to "retrieve", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/i2c/busses/i2c-s3c2410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 15e14a6fe6dc..b52f09048055 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -968,7 +968,7 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 
 #ifdef CONFIG_OF
 /*
- * Parse the device tree node and retreive the platform data.
+ * Parse the device tree node and retrieve the platform data.
  */
 static void
 s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
-- 
2.48.1

