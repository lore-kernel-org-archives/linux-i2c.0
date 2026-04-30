Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE5340DB8
	for <linux-i2c@vger.kernel.org>; Thu, 30 Apr 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563618; cv=none; b=GBmDa7SXVwWMTeCZhvvCUFV1XSrcwrQClc5Sl9zxDx3ZFMVc+WW8/NHMx9E96qmiN3WGTPSD0V68qf28KCyd+7/THUkoKi/RyTrNZllfIt5VemxX+JnOK875WQB3ZaptROaFvxzlouwOJCJIcfg+CGZIAsEDu1j8l+CumBS7Toc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563618; c=relaxed/simple;
	bh=kcIz11xVPCvgWKPHYx9bwHFqi6EZYkCJ30+F02FqwjA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jVzfim/8H3f1q4zF3aYFkgxCpSw2Sh71fFIQsyp20x4wc5mhvqtxFgkuecscXm8p6Plc//Dwr63T/oDUbjLZIUF6iTCkSsb4PnEVcaMBOdb3jhJdjqSsUJbBnm3i4EAIGp2pFfkg9atPWEKdZZMOY62kKBc/ryIfvmkESr/7fRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=QF+Ryxb0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="QF+Ryxb0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso13786175e9.1
        for <linux-i2c@vger.kernel.org>; Thu, 30 Apr 2026 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777563615; x=1778168415; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcIz11xVPCvgWKPHYx9bwHFqi6EZYkCJ30+F02FqwjA=;
        b=QF+Ryxb0RFJK0Kxjbs0HGjsuHyzH3mN1MJGFxHv0jHU7iGIn8x64kiSFsxal5kn3xH
         g6GJoF7CK7Vu9yNkqzPGvO5KY5CO99lJ6MgNv9gopM9slgW6tZsxBvictmzsxORULJr9
         svHhfXRgSv+0Z2x7COup3wcE1sTLxKOzXLR6ZvX0ORI+tiYxHr5SO9xBbmV7KgJPUK9L
         zIkdYT7yEcjIy8sbISdvr+L8f0Kz+6VkeaAzWq8bPOEQk/iX/9DWwvwrk9t8NaoKVpWz
         9O6li0dvHoUmHDVkCsmDwhYkvwfkw7lzSWng+pUHc3ITMW5Cr3xpEHf5hw9fzPng6CLq
         4eYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563615; x=1778168415;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcIz11xVPCvgWKPHYx9bwHFqi6EZYkCJ30+F02FqwjA=;
        b=c/H0Xecds5HNkiZpS2Lj3PpOHpuNYmbvBNELQ3+82K8nsW3voe+RlLbCoyxYkzoFLQ
         /ChKS/g0RlrmIqiG6mlvf7GT6oYpGTBXBRXtMg0ko8vTuviughzGBofIP0rTB/bWPHXG
         vGECzgD2d+KNBI24l+r8GyRuDtUXdEmcjRLCCPMC8iEZBzlqPO8uMdhVWGq2s7KA2Jvw
         NhCFDsRF6oaqEOipE7vU9xRuqKmMomozjeaR0OP8Wdkg9ebxghoiSyokxA3tplFcMW4A
         K7kNVPxG4QERuGkbqC4ESUetDGjQlUHQ4kzFF89co9pLGtVP6zLd8asigrvWJjE0XiSg
         Ue/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+oKszqovirsuhqD/iHRsf2xtsfP5euE9zh+JRmkoCJvRZ2ih9Z6j/4YDh7TG+snqS5bYj3C6y+bAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuCpEMOZOclqdFyW54LzfNTAAN5N39RajEzuCpECVxiR8Z/clo
	Te2zg94xl0Zby52F2+ZmG805LdlvJXSw8fqjG1MFlbbYAzUdB0d6vxePNlOgy09Oiv4=
X-Gm-Gg: AeBDievpsO2wL24HuMQsh+lk5FeoPkKXiHONvNK9epqinBTGnqYErxKaT9pW7G8fyna
	bBkNgkO4KCv1WabGpgR5C+L8fGCNW2sfDy3QxGkbX5b6IwrfBuZgUWFmXQti5pTFBzhto+1Pnv7
	Gbw0sf25DeNCaV31eby6CZo2/FRW4Vpdy7v4G/lz1oH0Tjj0Q/pRuNAfb7H1l1c5Czbav39lACO
	kT33jxkxk4lYGVEohQ/1/B1ZEKEX47ZdJaRhskj+cpEaoDgS8m3qZ5xknD/f7lnsc708AZHzxtL
	32AJuzL87i8p/oTnboNazKGpC2MfoUd4L1pnOQqkHvsWFk7enR+loX17IfTKKv8qxhT22kruTfN
	VwzBgW0jF94VOcOexAR/Mdi2QvPz/44AzJlNrxoNN3fAksLqT3IVaP4aZO2HGfZx4NE6itqioZD
	MSylapYCux8ZWc47pG0OpqlTJ4
X-Received: by 2002:a05:600c:4fc8:b0:48a:7772:c26b with SMTP id 5b1f17b1804b1-48a8445d259mr60312165e9.26.1777563614220;
        Thu, 30 Apr 2026 08:40:14 -0700 (PDT)
Received: from [10.19.106.145] ([151.19.88.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d481b2sm14348812f8f.4.2026.04.30.08.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:40:13 -0700 (PDT)
Message-ID: <f5991c1e5c1c71746b543258ead46caac0e6ac6e.camel@baylibre.com>
Subject: Re: [PATCH v4] i2c: Add FTDI FT4222H USB I2C adapter
From: Francesco Lavra <flavra@baylibre.com>
To: Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org
Date: Thu, 30 Apr 2026 17:40:12 +0200
In-Reply-To: <20260225112046.2394231-1-flavra@baylibre.com>
References: <20260225112046.2394231-1-flavra@baylibre.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Friendly ping

On Wed, 2026-02-25 at 12:20 +0100, Francesco Lavra wrote:
> FT4222H exports a USB interface to operate as I2C bus master when set up
> (via the DCNF pins) in configuration mode 0 or 3.
> The USB communication protocol implemented by the FT4222 chip is not
> publicly documented, therefore the name assigned to the various defines
> used in the USB communication code is a semi-educated guess after
> sniffing
> USB traffic generated with the FTDI FT4222 userspace library.
>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

