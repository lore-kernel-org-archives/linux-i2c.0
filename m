Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E074B04A8
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 06:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872374; cv=none; b=WINLhPE9NE/wFJtj9c6axLF4lwvs0Gf5Wp67lL3TPLNlA29pVKr2lEUtlf7B3B1TH677HlOXeYhIWkfj72aB8MCxP4lgfu2XnP9q4n2QiH7RM7+DkUX0yBBs0fNxqU8Y4Xg/KKrqNDab86YZ+RqHTrLY1Fb4iGvgBD4/gUla/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872374; c=relaxed/simple;
	bh=qVZJr6BGUqZMkmvvywtMFv4Y+FRBCFB7MBPZsxpnpp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S3LBUALlVqmrB7X3mlUyRTODFhWzv9G8TN0BYXMfct8NFYu9rwoM+dYqUwFE7+6OXgdLFvBLF/xqzfTBPaxQO84TG2igBQI9VUsNTuNFlnE4HIFTxa9STL3Nn8APeXLwpwPxpGcfqxuz6aY2g9lXXZn+98rew0CQMNIv5JJTW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbFOB+kH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbFOB+kH"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b0ef9c76eso2046080f8f.0
        for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2026 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791872372; x=1792477172; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qVZJr6BGUqZMkmvvywtMFv4Y+FRBCFB7MBPZsxpnpp8=;
        b=LbFOB+kHfGIvJmHW/7rO5K/rmUnwR2M0fAdOf3rpNk9XKwJQ8m/0tGz0SIKZCQh0Rb
         9OVUCCltNrgwGPfmKYa8beaOh3q5aOKoVMnagYIXLhleuYENI2uHmATmG1R3yN9EXxEd
         9wtxTyZ5CrXgG1PG0Fs+NOyvm829MLuhzqUd+liDSIHuWoiD3RYKLRtdGLou03QVa2LI
         PRB/wn9Uh4jtutFzV266YZ1NOu5LZMF87UKclgiNCaDJMKBnzKPGRwGMhw6oraijCcRu
         rXSdLrN06o9EZA6MClFoA1ZXwNY2zqw7zlKH+ighaPpDulr2Vk2ojhiHCQUTqUSMxpxM
         5plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791872372; x=1792477172;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qVZJr6BGUqZMkmvvywtMFv4Y+FRBCFB7MBPZsxpnpp8=;
        b=Bmx1DoNZ2g0AJ7mufNMOLgh4dft6vamIJAmJoOim55UTWR6C/X69VyDxStw6pukIqy
         oCHm2JNH+BGFity8vB6jqkJF5LPG6Y5QFWnRK/DW/56SOv0Ik91JHzs4dtdg+gk5w5iQ
         2YZ5D4XU3PBjK0u5Xv3eLS+jjxk95wk+kjpamqt7MDk8QIBka7LDnJWYUnD0Ev1Ym4rA
         /DjP3gKaZFVwdrgW0fERIFvCpmiK8zTo2A1W54wr4+1gSTBFDchkcT2VLUL5uxnHOSs6
         1T4uMzHzDBK0+ku48W0L3WBXYNEXJHLNNO5HoHIH3Z7LGIhDKeiKQIy/Y6TPsvWJfr3L
         bAPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3pTuIF7M5Df8SSeCMMuSozm0ScwHW+1reUc9Secs/Ye+8owcaSVB5Ynh7hINiEjeu9pPCF8WrCkk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIfF2iQ1vVFSSJkltoDDcJjqhT+9FkLHNfoTKz74kwxBKO4eb5
	u2kHFBFfdxbfTxIZ/nNqGsrvGPf9l89v4YbtbJ+h1xtB+IyEBmIM5ELh
X-Gm-Gg: AYBFou2qKNLPJJGgz0WwHCydhVJvEzkXEUi/wS/PgmdXUoq0tbNdYMHYEaCin3vUMQn
	P+LxHLN/GOkUtN91peiTtqQIDnaKRs8XSaS+xVLyea7Z/2DgBLEifd+hPjlsb2QQeIte4uJmQF+
	g4qi0b67NtGgpsLwxRZPuJP+NCYMs1GmJhuJc3QjwJVHO428J9ByrFs+aB6Fh3972XGA0PIKwPn
	mmst0e6XpFM5GmMYdaXxrKTaj0UrzEh7pWmKam6vn6/d8OWhLA0CD7ky7o8Rt/iEjEfqRpp66Y4
	MGN0/V00PXztNsa2QcidHFn7sFjrBnjZuDCn7jBhZ5D97kVwx5ms9crypU6oXtSL7uUbh3jyXEr
	n622OmO1TlNlNg5XtQkJl4Q6vRbtwRdBdrr7sQfdmP3yAz6t47xz8w3Je3qqFriXfeLJI385iGg
	pQQlXrrP2XC0WjXS/f3lXKQHAZsmxyuKJvUTKlUGvHXK4vK6X75VoMAxU6jZyHpFBxGcjEagZjY
	Guv1g55q4+w/xSANzvZ1L66c3WqTOdVU8aeOC1HdlH3/e3X9vhyVLnWQQ==
X-Received: by 2002:a05:600c:1549:b0:4a0:25c:8af2 with SMTP id 5b1f17b1804b1-4a18e491051mr250154825e9.17.1791872371668;
        Mon, 12 Oct 2026 23:19:31 -0700 (PDT)
Received: from [127.0.1.1] (ip-024-215.users.dtel.ru. [91.210.24.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f249692sm264395905e9.3.2026.10.12.23.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:19:31 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Cortina Systems CS75xx: interrupt controller,
 GPIO, I2C and TWD watchdog
In-Reply-To: <ad388a91-404f-40cd-8153-3a0df3411c16@kernel.org>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <ad388a91-404f-40cd-8153-3a0df3411c16@kernel.org>
Date: Tue, 13 Oct 2026 09:19:25 +0300
Message-ID: <179187236532.3113955.136062642054162547@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On 13/10/2026 08:18, Krzysztof Kozlowski wrote:
> Slow down. One small patchset per 24h. If you send some big work, then
> once per 48h.
>
> Implement previous review.

Sorry, understood. Your comments on v2 arrived after v3 had gone out;
they are done in my tree (I2C and GPIO as modules in multi_v7_defconfig)
and will be in v4, which I will not send before 48 hours have passed,
and the platform series likewise.

Thanks,
Fil

