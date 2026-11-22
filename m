Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375161;
	b=lwNPX1pKOvryZOxf1LyVkCq5MK/U+ygwcGs7P1RRTSG5RF+SnMgMU8S51enoaZyHAHJU
	 XvAH+8+RUdPmPDUQB3P78GbTPPbBbSDbfZBJ4zE5rTbW8vTzp35jxMCgnVXl/aXdrOq9y
	 XpRpuCm7I+kRVOlmZaboaJ+pBpJJAhMa5PuGbS5I1yxVuD2swzjyAsJOiNA7FoZ2w+Wfg
	 Nkh3Tw5joBHIuz5xJLxL9KCEH+Lu5veQbn2rUDDazGkqmNj6CrZu+IjyZyzn04yLhkWzv
	 sa/3EvywkQL8HFcElM+DOa2aJgBrAeUNcxVvdYiU3M+jtlJTVx5YwMg+TH+fQYod0rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JgVB/O5hBKCdOeqZ2JLGG3q/f4KIK1fx085LNchkx34=;
	b=GSk1jxRPgGdX/5yE4ac97+22lmIzT7PxbfYnqZc6lSSjN/aVpVoFIvvI3+sM4r2HUx7T
	 0/7Trq8Ub6w0ofxHwYwiKDxAE2xgdK3XWhZCsdhyMkN0qHnAd7+n7/PTktEz6RbvteuGA
	 ITbG0bXyxDUJDab7Yw1zrM/FVm8UkO4Fwz//eCfyHtWyEfcc89RThBNjrDk2CgZSpmD5x
	 hpp+gV2bGucshjTdjgO1q1InhdQs+5aFp1mntRK5UbgO5gpk7Z8ZtzmpToX0Emicv+3Lh
	 skBPf4UYcIvWU4EEJQXvgsqbwDi6kISCMrVfOJK+LB7ZNq3KTPfZywlreQw00rzGX4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6dSI3LA;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E607606A31E
	for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 19:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E607606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6dSI3LA
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so31361655e9.1
        for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 11:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795375160; x=1795979960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JgVB/O5hBKCdOeqZ2JLGG3q/f4KIK1fx085LNchkx34=;
        b=U6dSI3LAe1VrIYxBtdeXBr+mcGP4NRfxblw/6vXiYnN/hUemD+dcYCiyg4bNuRa7Fc
         PDwZ+RAy6HDwdH38XPhpIuauHU4m9/cBQGAJp0M9lxLx5Zqlssd+OGlQ2IMKtEDYLJCp
         Pwzi1BJffZMEU2tbHRY/eDAW/aJmWrUEqrJaipHLzdRtcoGWFieYvDL6hWqR8w3W0WoG
         +JhGcDs0po7rES+U5o4htIhLKEGZGca+4iPm1NpNTrjk1wnWIXEfqMQugIr4tUs31hSB
         ZHA3ckOWe1qPgo1hIETJIS0bSY4TNEtx4lKiipEjEtj8uarOyuCXIe4lTBMn2cinS4Re
         bvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375160; x=1795979960;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JgVB/O5hBKCdOeqZ2JLGG3q/f4KIK1fx085LNchkx34=;
        b=SOzY9dgmCHBE7qsUmM1CfjnB26EQaue+KkXCsdn/JDA8TqXehThDjeuc3jSwDXhMbu
         8eo0v/yj69hmTYOTdKCt3Bgb9h4MKxPGI9JCRPNUp2vcQN8mNJiFHV/74tSivY8ujdru
         eZqMbvd1JUs3e/POblZQoR3L671vXaJjo3Jhkat+SZhph2hl0TfjeQ1uLZ6XgXnXQX1Q
         KD62E6rtUcXmi+jH4muDXhI04BfQqOwsRIU14vm0hhlg73Uhiv8PeL/TmyvwIvwVCEyh
         Y3peI5FxmLj1vNzjvs0FaWsTmdp9uu2DfFIPFDdBfYU57jHzzkdDpjUowT1gU02LQ7hu
         Q8wA==
X-Forwarded-Encrypted: i=1; AL+hErGN70gSXRH0ZTBEV/EvR1VMZDjrlGZgJPPsG3z65FR3zTnR3GlNMOsfZKrNA1ZjruaCVpa4drjK2LQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CpVMONXMVea9F5SUPFpVnWBoZ17K4tDKX+25RuEjp+4/UT/MY
	jhfeVnGAa6Xj35YYqJtjZDM9INAoc4qAc09VQLMYN8ct8jfqz/RYFg+C
X-Gm-Gg: AZFdTZeHNimVGFdgjkF6R6CLr7vxZfPc3IaGVp4tXtcK3MyMC7TCVtKByP/jSEtAlbQ
	3dnSMS9iDd2ip6tAh/n9xHMBRWjgOLc3As+F4UQZZhXQ8u4bHIlN7kiWaIo9tVUYtZcvR5146C7
	uLw8HsgmdlUdT3H2IU/ewPlRRlSfgW97QeTP7SV0QZWgZHuU+UB7OS3jYEUh+IchQscoAAwy1hj
	UTXPqEgtI4t9iU5Z6C/FQdMDKmtJdJe7EjALmFwYTLV5TeG1Dvbvxc0rg38RDDVBxO+ipgYOunp
	WETLYtUuLrtZ9Y5RqHp1ejE9zb4lst29fDUBWpgvjNXqN+Oj6dtsrkNVc0H4JLch9OBcGeE12V2
	V6FL1Z3fXGOKad3z+TBJCWd1R/xrux7AJr1zfwG0zBeC8PV9jMOcV/iEyyc/xnsKfFu0HS0SuxO
	6e23mCxmh88A8rEjSX1nGuxPCvDbf0Ids/3ZnbU7RDgEkfjWP+N2MIMEuh9/bCStT699QN9x8yR
	mmL8yTagpZYLBUNYXhTnEHw06QeFx3E8Mt0UrYMIlwNDkYpSp539amihJ23ylbPz3vIB7pQKrfF
	XDWMgGR0/e5iS/m+cyqVQVLbiGIBSRSl3LATra/Tiqd8cjyhkbGwwjKdQ4+tBtnESg==
X-Received: by 2002:a05:600c:6749:b0:4bb:5f95:c014 with SMTP id 5b1f17b1804b1-4bb8880f283mr208928685e9.19.1795375159763;
        Sun, 22 Nov 2026 11:19:19 -0800 (PST)
Received: from cachyos-x8664.aetlocal ([2001:bb6:e78e:9100:cdb3:c7ee:74a4:5189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm389657845e9.13.2026.11.22.11.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:19:19 -0800 (PST)
From: Mervyn Pretorius <mervynpretorius.oss@gmail.com>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Min Lin <linmin@eswincomputing.com>,
	Yulin Lu <luyulin@eswincomputing.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: Re: [PATCH v5 7/7] riscv: dts: eswin: add watchdog support
Date: Sun, 22 Nov 2026 19:19:18 +0000
Message-ID: <20261122191918.2184139-1-mervynpretorius.oss@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261015125454.1381941-8-pinkesh.vaghela@einfochips.com>
References: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com> <20261015125454.1381941-8-pinkesh.vaghela@einfochips.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tested on a DeepComputing FML13V03 (EIC7702X), on top of v7.4-rc3;
details in my reply to the cover letter.

Tested-by: Mervyn Pretorius <mervynpretorius.oss@gmail.com>
