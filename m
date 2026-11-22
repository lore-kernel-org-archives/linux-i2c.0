Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375154;
	b=3pagUb5vUa0VfNfBYtxqKJ1gb+boZKELMlr+zLkc8BRRKVl7zwOK2A96Mz60ZFDYtobR
	 KAnOmjHnxd77p8h17I5ejOG6iyKEmv0XHm5GIDH63UENc863TaY+pyzuXFUONnjjyAYBO
	 7pXBUiB6dRryHiZr+xj82XHV/03QKYFGhPsCc1ZZyVExjZc17g8lbCzMZj0emoOYFThQj
	 PHCYKc/IsPGRs+AsO5k2C1PokYLLeUoOGZMnMVGDYYsxur98Aa0uAoDM7ndgDXNCEo0ph
	 ATACCEXcmqhRoCOhRduqKWxEyLqSGwPLt8SrOlnSxWluQ9pYKeCTL9WPvrLtXJZZFhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JgVB/O5hBKCdOeqZ2JLGG3q/f4KIK1fx085LNchkx34=;
	b=Z5oVhBNbbwZhb3tjEVaOmUb17bJw+xfDdS3IF1fdyxoT4qCW81X64PvcjGhXHWZKuRBY
	 6V67N3ulTicdfZ1rJvBdtiqk2KxoyeigDE/Z9aJPfM+QL+IJ7rkAethrke1u85DI5Cs1/
	 het0E4TvhLf+iMpcKkQCv8DC24lVfAPpUFYGsRzLRRFvJ0A+JyCUNaFN6QyTBZoVntBrF
	 1qj6GRDCeJG6ImSYz94aVZPzm9QRBIH2oVLPS6R+CHoxM6gzobCBgX90zetDPV8rN9ZBc
	 0TtrptS+gS865JVcz90M2r8IFnmo/KvH13VkQ40gmIjIKxDLTF+pdSYnGwT0X6FnL+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQdClBoh;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A292606A31A
	for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 19:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A292606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQdClBoh
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so19376875e9.3
        for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 11:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795375153; x=1795979953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JgVB/O5hBKCdOeqZ2JLGG3q/f4KIK1fx085LNchkx34=;
        b=KQdClBoh8jcCpLG7uk8RfQGxzzKTBS1Vz22R2mosQpM4g6tHydr9advbfUzmde37yW
         STvgE+LR7Rx+tCs7ZvSTW6NpG5uHYbFiwxwYFAr1VQRb0XTXknUsRJys3QqBs/6rFsm/
         swBdSyIk8a2U2PsvjiDvKCnEJla209oAQ/CxXfth5bmZlFTiACcIyFSVNK7M3NsSCyy2
         ZnbSOt4uPkTN9QB/3EqwltEuRhuJDLVxAfjwO2c4TToZdwSBKfs7rO62I2ogcsw0SeYm
         QJfCdhXcwZJMkSkyIAT1mzeq4TdWs8muaXAuuTCINtHGVBcciTDtufcEs0RqnAH3XAkJ
         h+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375153; x=1795979953;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JgVB/O5hBKCdOeqZ2JLGG3q/f4KIK1fx085LNchkx34=;
        b=sWjA/PA8jtAVoKjFJzuZSbpCZyb/MYYcN9m5jHVwyw5uvLRVHB+iC68ftsVs0aC6kJ
         rUf1LcUm2W9X234NE6cJfOBvjg0ONEJXfT0EZzu5x8j4kGiJo/hY8nPJstKUpXZ9kIPN
         78692epLbhwo4RSQ5wC+BIw1/1Q0qZlPLdfQSmeM2f5J1Eo0myzSXGRDw8v2Fsjyc0Md
         r5cNIKHJeGb+kIY/l8XU52NSY1SYIyKjjhTK66IZko5IIro0Z98yMTtch6YsqvuYYxd1
         bcozY9Emp7EFfI3sYFfTDGWWNF4gKo2l5y16oww61MTfY8Asbe5fwYxORGpMoZLNj+F5
         q7Vg==
X-Forwarded-Encrypted: i=1; AL+hErFrMiGUqg/CgubyqiT6saOKT2prNhepqKp+ZTOyLm9V9dS/oR4vpod1VKJnhNfvS0EpI09T5nWJm1k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WiY9b0e4v/Nn6Nn/mG/h5AqF14naX7ImNwRGLT6yBoHMOhI1N
	/1EY9rMssmlX3FXJLhZCDqFgZu+oQKBD4Gz/o8Rh4GTNJf6kqcjWoNef
X-Gm-Gg: AZFdTZfOPla9EiPJ2oxE4zuXhzMDMW+NtAzTXtS9JCajslihzZ7gS2XbFI7hSWAOkxn
	NnJWmYz8INJ3F2R4/xsN/6EmPsvOvbt9Km193xA16yMsncUplCgZB4UfjBOIh+kKlNzy4q1gC1O
	Rq5izSTubvjmioz6wtDfSXfMqB5h+AyU2lk1QlHp85V/P2RbSLm/IQRe6mLfqOll31Ktn7IEht5
	PhsPHhatM4nTnGzLJh8iNSmDSVHpnN6LahFE3HzJZayDVrrpJ8rRubhrmYSrBbBzcXmyZXVKPOF
	b8zPYvGs5aEV4sR1MdFlPluVEGEJLavipLq/0UBygUAdzEfJd/k7yMqmv7n9bVxXosx/vf2stC0
	sy8urGB1xd/yxwdGb1VrTWk0bFEEGve2Qj9wwHAQfQHAdW8meGzZ/eH9kMXCH4U7rP+SiTNfFm6
	ZrjkPwpbSGhuj0bGzMTHKaZcTcdsDj+laZjbY6E5obwXKHdz8eikHBczC1/ZxWdWpnhSz8VOxUF
	A/tCRBPXkXPRdN5dtRUe913KfaLnTeRSa9u1KdcpLZRte1EyVbeRg5Yxjp3eJsLnJCv+xYq5Zun
	QOTSXId899DzsLdrHolUsjcUT2fFI7v+yxvSsqGuEVjO
X-Received: by 2002:a05:600c:1549:b0:4bb:741d:ea8 with SMTP id 5b1f17b1804b1-4bb8880ad4amr192535855e9.7.1795375152884;
        Sun, 22 Nov 2026 11:19:12 -0800 (PST)
Received: from cachyos-x8664.aetlocal ([2001:bb6:e78e:9100:cdb3:c7ee:74a4:5189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm17465595f8f.56.2026.11.22.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:19:11 -0800 (PST)
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
Subject: Re: [PATCH v5 4/7] riscv: dts: eswin: add hsp bus node
Date: Sun, 22 Nov 2026 19:19:10 +0000
Message-ID: <20261122191910.2184037-1-mervynpretorius.oss@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261015125454.1381941-5-pinkesh.vaghela@einfochips.com>
References: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com> <20261015125454.1381941-5-pinkesh.vaghela@einfochips.com>
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
