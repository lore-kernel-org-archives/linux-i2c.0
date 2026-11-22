Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375147;
	b=Bzj+IoUYdwESeP04Ra3S9DrPC8K/ngHjlYELsHHRu5NiyfekbpP1s45U4Q0ZQCf7Ocry
	 N0/BkTxitBj1GzgBvQMEQw2ZDJipR+9P9BOxSzMQU/cfpXXAbvQXKGsxx0H1PeI9rTIit
	 jiqS0FL9jFmJPwWyqkrVKC4oK9ICZZtsxlQ8gsK0hFyLnzJw2MFxjJD30l3fxnYAsB0jy
	 F6GaT2Cuw71kF/2T9UqQAwqdjElQ+WrgB3shuHqJCIMun1kJvGXfdizvR2ABz+1yQXCDr
	 EM7dxNFp3LBPsnSXSS8nlWXEd/qXO2wqBizUbeU3pCgroiPtCf4mK2lFtboV2s0r2NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HsCFnP3ndBaofMImQLbTwSbFB01O6iMTbveJrzxvAyg=;
	b=lbdY8LYEU+5SsTLn8UfLj+pnqlAAtFZnQ0v5qLNP2abKrBqLLypZJfydR5oAypi3G9n0
	 iFj20ufnWcqVp/Mw/A9WVJDbhEzjYVrN4ynB1j47ylAhVYHCaAyx4sxhf5Le85VAqTb1v
	 17VEDYZIheUKWlXiktMKKx7bzSIfVNWuuqYDTF8nRSiUYVtKRlkfTRG70JVilIfy39aaR
	 4o09PDss8pXByGLaYglUMqmPODBrEe6bOnUrp+OW8ZtP4wkwhXlAWLKZEGMTvTLFVpXri
	 sJpfY4a9cOygUfcurL8dIK9PD0k7/HgKTBtQUChAVxH49BdEgW8aKrDhyssEQXkapZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ANktN+JD;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E5606A327
	for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 19:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B47E5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ANktN+JD
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so1962721f8f.0
        for <linux-i2c@vger.kernel.org>; Sun, 22 Nov 2026 11:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795375145; x=1795979945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HsCFnP3ndBaofMImQLbTwSbFB01O6iMTbveJrzxvAyg=;
        b=ANktN+JDfZJG7QsoqdiLxuAKT49fs7fTbIzA99ZCabxHp7x2LLHtqDiLp0KWlhEXRt
         jzWunnHP06VbZRVrw7r15yxpsUN+ohIoW+2jyaSrvrDn2L054VeY9M/jG4KW6lnTgquo
         s+MzmztFVpXICqtnpaJz04SCjvf+sHB+iZjBiVhrVOHakLuDIhEyqgyfdahe6CHgkHD5
         g6db38/jacnBnh5nRpPAlHP2Lc7/x5DfHxJkSHFPpjuIzrRAHLQ9wxUHhfqE4OzQlG1h
         8q08wXWruuDYqeHuCEhVq9s7tZUZ7jbEf3uZhNWI75b/M9+W0hlbglhfzIpctJj0cQ6x
         1Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375145; x=1795979945;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HsCFnP3ndBaofMImQLbTwSbFB01O6iMTbveJrzxvAyg=;
        b=wr6xWWnzR9/qjIjA7ddIBGB9D8XpOUUCa/wnzmCikzRg+K0zjS5dwdQp/P79suY/M0
         H8CvnLTg8wJv3GZzpkGfmtGuGHsDzn2KJYDCNCmQQcR2lEXKR6q+Y9kKVPtQK8khIzSI
         /T09523yh97L3JazHfno91m5qeRAUQ5cGVXEOxK/w5Nd6v1ms1A7U3LXayRX6mdLXizc
         Ct5I8XL+GQzpmkzpt5Xy6XxTbMGIirha77VQCgFS4v3YDP3IE3/pCQ3Xuybw3H1RWEvh
         RyH1cc1ZsvECoWt2mxkbiXJk9862zfEW51V5pkeoa8qz9RPfWg47Z2C37P+Jwx2VEQfw
         J9Vw==
X-Forwarded-Encrypted: i=1; AL+hErErJ9ySs4PigM0kR2Y5lLL7nBTu5Em5GeaqSQJX31irUNyLpCNQi3+DSPLNxkYupzuPMLNsgB7qriA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/T7q2KwV1HyihRkv7jzjLRqQYwby46atiKh7rLHfc7SDeWpN36
	DM2aC7GyEHrMQXbQgNa0kcF1P+iLEt1Msljuu8SdLJr/tHATEQ+jBFVe
X-Gm-Gg: AZFdTZdafkvbmzxzpkdchgkNAgs4lymbFIPJ8CMtOm540V3jYCWInVTSgEbf1x+lL1R
	gVwJqxxoB4tTvA1kLclB+JuyMmkkVdQz9wS8tmACAcPmg8rr9iaIUh/5CqrJTGlCZsQmnFyPlXi
	MeD5f6NKhOvSSABka6IbxTSMDEDDPVCLnD/LtfOLZS3dHuv1CgKVWBfgmJQX9r2XRi9eUlx6Eki
	TDUMFQYIaAF8uNCq2WLP0jQx5/MkhiFhlPdExcmq0ysbooRS9W8QEtNbK6DVz+R4qJX4/vbJJ2t
	fYo9uZYW+5rlWXGz3Sn8ibICOnwJHGPqbVDcG3wx99dFngeUSSaSG7w1vtnMgxP7NDLJ8G+mr3O
	aKbsQHF6uSbW/75A1CzuCpizfQ0fkAzWvJlYISfC/30zND5NK4LyVjJ15kd99v+DHWfclXdL1Z4
	hlkmL3ShaS2dmcBc8NvbGj+FqWuAgSScxidDCj780Wzcim6ax933oSY9Fi61Ax9KY+7rfH5TlF0
	LkfBF/8L5nSroGxDJVKijQwPuEJY8ehpGaplz18R2MUQvAt/EiDP/DTr8aZvJWZg4mZE4HJ4D1A
	noL0ArQgNnqmb5Sme9FN4qOSLCupWzN3A3FohQdk9AG5
X-Received: by 2002:adf:e00f:0:10b0:494:bf39:21a5 with SMTP id ffacd0b85a97d-4abb0e4716cmr13169170f8f.10.1795375144988;
        Sun, 22 Nov 2026 11:19:04 -0800 (PST)
Received: from cachyos-x8664.aetlocal ([2001:bb6:e78e:9100:cdb3:c7ee:74a4:5189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm14926556f8f.46.2026.11.22.11.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:19:03 -0800 (PST)
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
Subject: Re: [PATCH v5 2/7] riscv: dts: eswin: add clock generator for EIC7700 SoC
Date: Sun, 22 Nov 2026 19:19:02 +0000
Message-ID: <20261122191902.2183925-1-mervynpretorius.oss@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261015125454.1381941-3-pinkesh.vaghela@einfochips.com>
References: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com> <20261015125454.1381941-3-pinkesh.vaghela@einfochips.com>
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

Tested on a DeepComputing FML13V03 (EIC7702X), on top of v7.4-rc3,
with clk_ignore_unused (without it the board hangs; that is in the
clock driver, not this patch). Details in my reply to the cover letter.

Tested-by: Mervyn Pretorius <mervynpretorius.oss@gmail.com>
