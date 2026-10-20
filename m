Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460248;
	b=ToDx/5+gbirp51ZvYjfr8nRDTciRnp6fNKV1wa8ThpGFGIHqR/rU0uOO5JyVZGwHWfGU
	 ro7qofyanWa0t1I99sjjBy1rCR9j1eiM0XN91smoSKINEQrjVGMtZF1YHP2pE8dzOgFyn
	 lr/aMSL2zlROg9nu6HbmjnA3mNNcUXEcDFsM20KjLBe5InwJRfU/l/MgbPj4i6l6UtjlG
	 Zx/iXwbPL8rFlC4buPBsdj+Zol4OsvYar4URiGY0P3B11JdGJW03k0YzEBJiFkSAxNyVB
	 D9Mfx2zSARioUdl12+Q0klP30iYSnW/3op/j8LtvD4MN9tUlu2gJmv8jHXbVcUrYZuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TcJGBZQnqhTqIvez5VyLtXAFQZOBgnnr6VaSTFruo8k=;
	b=EqT6XVn2+6SKdpmTH/lwSeRcuBc+w6HoxYdGbZzhmbQj0l6JeeBrWE8ws33J8UKXJf4f
	 00AdJrjl5aawKZm8L5BFABXK6um0JAIHm8J8Y8akuwt54bkUlvzQ7NkgEOjN3zuprtWCn
	 GPUpvY1LgUtEuzgWl54BjlALkjXT8UHeIu/HChzIW80vwDjy9HhFPnGo8KpmTttAQB+xr
	 5IL1bGltOf7653byQ/xiKr4CYeXyJPTqrahKPaPrwgEcV7QXxkUtcZoGBzvSqCNGvwR8d
	 FWdMeoQFfkHTVsAlu8UxQhF79G0ewu1Mux/Lcpf/0JShrfNPMV9YgtR59rYanqsHFWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecmXx3NR;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD9606A320
	for <linux-i2c@vger.kernel.org>; Tue, 20 Oct 2026 01:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05AD9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecmXx3NR
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1701582eec.0
        for <linux-i2c@vger.kernel.org>; Mon, 19 Oct 2026 18:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460247; x=1793065047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TcJGBZQnqhTqIvez5VyLtXAFQZOBgnnr6VaSTFruo8k=;
        b=ecmXx3NRtnKBb0bx3OKSgxIGlOywd+JyxPJp60E/ketB3hMnkmpLkH8L4kcdJeA6Jl
         EMv31nRk4M5/ktlcZJcz0TUpYNZrDTjGmjF1tedEYBM7w+6xPr+Lrn+qPR8G3QZ6JbhG
         NESF27cdh0velfvj+2DrkT1yLnB/vDSgAZOY4mATGCWkyZKYKXVEe9SoJOmfeDb++d4E
         LsU8MtxwGj6M2KGicp3ue91OsgkOef1ZKEnqKl5cto1+sEfHdlu/c4CauXWRFZ7L2FpB
         5HAi4OaYB6E5btRgmlcTXLc2QOcDGhYjgeNwmoMugrTDSGeJXWNPju0Z3o0fQLnWuN15
         jnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460247; x=1793065047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TcJGBZQnqhTqIvez5VyLtXAFQZOBgnnr6VaSTFruo8k=;
        b=d121Lz4xsZozFe/MC8QSjGBXZCOvk3frVaLYCE3cHHoV+KOzT5zdxe+pSShs2qYLuw
         +61IiTpHnLhHBI/DVqqWRRoqMe5xwgcCuO6Vs/WTzG8E8vxfRWoTR0UGtnmgYVrVxsCZ
         XuKBtOzlZ4KoKA6FYUx1eVuJG5VISw80oSqw7lxqLi0r8/63llykjPP2ctBXTaiQJ4h9
         UOo4XXIifkwtQf0t4PFwojhw9YBGdaiKMrLtDh+4P3q2aIRyiHe5jemW0F8178LsvkjC
         SYyBojfwRLusTzvntwxVYQ+XlYhkvkn8jxookGRYRYsNSZ7l6ghtp/BtRGutgl4w7W/o
         lciw==
X-Forwarded-Encrypted: i=1; AKwUvByPNB+yEwT1UaeMEB083Jln4mQ3T6AnS3eh2we5f3bJaBs1RUVs1SjodtUc24DLe7KvLRiOi3G5hAk=@vger.kernel.org
X-Gm-Message-State: AFq9FYII5cnB0m/zcHHyc6HwfPBxT1Dbxc//6GTSmSieDISwvL6oeMCq
	AzcLbWMMsz4upj2xHVBac+APqrdneL4Salh1aivgg4pxQkytniIW2j7M
X-Gm-Gg: AYBFou3GMANQeBbymNwkxSF4em0PNmb09lP0LRwJVy1ASglgsHufe+enuc57SzsUYrp
	gJxWn3vOeOjpfYsVVxnybwFRYBgi/8b1pnsdR6i2DC+k2OBAHc5yy5QSlgudrgO3b+6nvfhI1tn
	RbfS/slR4MFSADckH6mYmxTznzfHWaN8DCMrm4NsH2wP2Lxyog+3OsaaMlbgtCeG8c1lHkvstHH
	7Zx+ecilaqjakxkIQQo2+tF552lBdKfQCSYf0FFcTE2/S4suAv/OGiWwLdc+0tJ2vheAyItOTrA
	vWefYfQsgHHNTHJ0lFTusKWfQpJu+FrGof1PKn1JbxG+FGk86FHXJ1qPY69sHVA+f2wMaMdmjGB
	mzJM50h3f66oXEd6WEhk6GcnUdFYocEK8Qb+YSyBvRLaa2KZSq6+iR9k/MtwB6sDZgQh5v/xOFi
	rm1E5FIqMb8EgLFRvHw0nug+cWIFvEAjiBH+J4Ie6tQZ7+9z6MYgnvmdRIK9rj9MbwPMFNMHMW6
	sQxiFTf+r6v
X-Received: by 2002:a05:7022:120a:b0:171:a066:938e with SMTP id a92af1059eb24-18512c384b3mr12193156c88.21.1792460246891;
        Mon, 19 Oct 2026 18:37:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm37626819c88.0.2026.10.19.18.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:37:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:37:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dt-bindings: watchdog: apple,wdt: Add t6041
 compatible
Message-ID: <1a720dcf-9f67-423d-b998-d0db73f82899@roeck-us.net>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-1-961edd8d661b@cyberchaos.dev>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-1-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:08AM +0200, Yureka Lilian wrote:
> The watchdog on the Apple t604x (M4 Pro/Max) SoCs is compatible with the
> M1-M4 SoCs. Add "apple,t6041-wdt" as SoC specific compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
