Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DB27707
	for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046063; cv=pass; b=G1O04i9iJYMe9x0ggcmx8LK8zo1D1M3zKNMRR0Bw9RXLCxrSALdnNBeJQGJdnrkXSXtBFvIAQlF/58LLeWESeoJj12CJLmJ/Vp1NlzRLz+fkQpIDENwuGsh66OQ/rKk+K4hy7CEKnkbY8RGp3zrCJpnxU5Z0Y4IgwUq/Kvwx6Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046063; c=relaxed/simple;
	bh=w/hWVgWMBEAi4baxYBKguUNUSjowVNXqcyrAzFXEtd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGyOg/FtNF6JHOzzHo5uCkIO8WGF853YsoMCfFtnaTsulMVfDbuk3CV7BEiXoFiwI4aSzIiV3ivKo0gjlZzFjCWagpbDk8xRq07RNHZHddc23iAzPAKb6lJO+Pjf32NoNpxnCwut2OERTwv6f5/px5dpPlu6SrnKUxXIL05namU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o88uYxWm; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o88uYxWm"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c7fd21b63so32073691fa.0
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 09:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784046060; cv=none;
        d=google.com; s=arc-20260327;
        b=NMX/EIhVr1S6MY27aJY2yJsbWgFoACWEnZysQD3tcMHas0XVINJofv+FK+Vx6ZOcC4
         ZjpOtDFSH2b/WmRwOopMakskzymBnc8QkavTNUkOKgoaYphnDLTQ2FW7tmaKdo3rej4z
         kP25RsJXXznsdswsx0mMd6eluBfQW5166kqxwHppT1DNWeHSvVNBfzuO3A3cuffgmpTz
         QTEHNVgFCaM0Z7dE2uLX7DsjqCHIKnnJfDY19jCnxYwJE8JUpEmEkAMgs+tz8hJK6k8G
         ix1Aln8Y8kgqrQR1VUvvEzmiZy+ym9fTc2i2uRqu8xxQRJwjylTgIQgUpi0JwVzoFMEa
         20FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=w/hWVgWMBEAi4baxYBKguUNUSjowVNXqcyrAzFXEtd8=;
        fh=4Tm5bIuSu4GHnpc1J/9KvMpQVkm3JSF7j2fg8Sjhp+U=;
        b=aLPR9Vkh7EmnEcCs2X+BBpVkC1K1IfwXG1KCQI3zzqoGapYQ1MdsoSzlXY7m6yjH1H
         O9gaB+UMnRNiSAPrvF+O71nXQHX7/aoBRcQ4jUqG0ZYTUZiX7GcU8/wqMoDMPxCSCKd3
         6SIiZgWKPkjj0Gf+vCqFKpHsbGsTjOeksdaPG81dVq62XzsgAPE05/TdGW8dgojn0t+K
         +njH0UqHNZpl6sbvBQ6cS8HQTUu0kl7Z2WCErQHV0pNEsenV9qm/XegtxA+WTRCIZqX5
         aszgoCAyXh0faVwMQrpLv8SPwVuKKg70+qFt+n1LFJaSSAGXvV6vSqUdPDVvHdyLuhaf
         1z3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784046060; x=1784650860; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/hWVgWMBEAi4baxYBKguUNUSjowVNXqcyrAzFXEtd8=;
        b=o88uYxWmrfOlrLoUAui5B1keRvLo2aRYCLAqClorVJDOjWJ0+60sz9JdyhgwoGiaBv
         4AVJC9ZR7CjU9S4SaqLYhX0+ramX/orn5b3PPwvxe38m2GOQOnNlTCxDnAoNZMX7wJRc
         DcsX6POpWAH3n6NxS2xS2T+3fjv4j4OOfbnqxS/JgDxoOQfQbix3ritMvzghfrTR2M3k
         jR94NGB1prk8cZ4fYECOq6zaxMGAprVlqXeYw/AeoGhEW8tn8nY3N+PKCwD7MpnPIFfP
         h0CBoH0hE0YuXAUtZxnoFHNXoL9uUYbFrSds/QLHIptnvhHxf025hO/MV+JymmXVLYYM
         X7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784046060; x=1784650860;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w/hWVgWMBEAi4baxYBKguUNUSjowVNXqcyrAzFXEtd8=;
        b=HJhLrBG6zozzv0aaPsN6Vj293AQNBqgv8mnlOmS4OE1qU7NNR73mVYF7zstvXlj/aW
         bGOc3n+hi2qadopnT3L/6DYYeJmmKJaTQXfnlasu4Z60LYyFNzGVCkQnO+dRUPi9z/WL
         6zRoweQSwXGo3lXoC15P/IXvN3gmUQa7pWv9dsKcg1TnDYAc3bPqcoiaQ1VxoV4s5/MY
         Ny8pplL1uBNxoCWCELEP9mLJmoZqXeVlyT6HWuOjOiGbbA/UKblKS9qRDzxfVdNITUjF
         w6OTD0iZbAjt9Rn3EBELhYnGgn+8mwckqRKbi6M+kc/TDYt0G6JgNkPlWn+KOFluHYVE
         wfbg==
X-Forwarded-Encrypted: i=1; AHgh+RqfqXykRDLnMWTG0/oIZ+gCHpQaXt4LFYF7chtEIBWP0dOd5XcKPRckNES2bgzrqHMWXZ/2qi82uqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlykMyEvo2ROOQIoeo2uFpVK9arTOpmGhqTgQvIqDAVwE1rsLQ
	l6ILrEuXefEHfZRQ4kQups9Qg+JtTzaUE+eHamGPtgZKUdiAp3meTzjos4auA67oB8dNAdZNfs8
	Aycu2MV23rr5fm61AWQHY36iXr1Iba5UxsOv7
X-Gm-Gg: AfdE7ckjkW2S2wJlz0aMzNi/N2m0LaCx42Dh1NOxBLLYxykBw37Jd24QtrTeLft1kkB
	3Tnw4m4mMi6QzVN+eqMnU+bQgDv2nrpWI9rviGBUrr3AH/UnU8hHyoci8dPSZ8aDUnAoqfnigou
	QoOEDzyUMqdbGUsBp0O0JPWtQhRfzLuz+CG4yHBvbFp0WWD02z1H02GaxmBE7yngHCmSkEvS8pj
	KYoTro61RPdKal3RIxcz0WtPHNkcz9NKpRSWUhX2BILHeMjF0Voo9bTCWXHGBpJ0QFrv0CRnB2u
	NpT9iAzQ+6m1wBIU7rFe9stWF6vr/3HX2ba+dbwWLQ==
X-Received: by 2002:a05:651c:150f:b0:39c:92b8:dd9d with SMTP id
 38308e7fff4ca-39daa839b20mr9821661fa.26.1784046059486; Tue, 14 Jul 2026
 09:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-3-muchamadcoirulanwar@gmail.com> <DJVQDP9J54K1.AANCLIJC23YF@kernel.org>
In-Reply-To: <DJVQDP9J54K1.AANCLIJC23YF@kernel.org>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Tue, 14 Jul 2026 23:20:48 +0700
X-Gm-Features: AUfX_mxf_FzQxVLfuQI_7jeEOA2orrtEW894cnhKCVOqUxe_TyKMO-fvHYnHX4s
Message-ID: <CAO26r3QDbT07dTsMfMB8Y6H+qBzh-PQxgcTTVKqJ7C9yv-emsQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/3] rust: add minimal IIO subsystem abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jul 2026 at 19:12, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Tue Jul 7, 2026 at 5:15 PM CEST, Muchamad Coirul Anwar wrote:
> > Add safe Rust wrappers for the Linux IIO (Industrial I/O) subsystem:
>
> Does IIO's iio_device_unregister() synchronize against in-flight IOCTLs?

From what I traced, yes. iio_device_unregister goes through
cdev_device_del, device_del, sysfs_remove_dir, and ends up in
kernfs_drain which waits for active sysfs readers to finish.
Please correct me if I'm missing something here.

Thanks
Coirul
