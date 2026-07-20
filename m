Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C70043934D
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564251; cv=none; b=RCUKXyRe9Q/vPkOaT6ZS4S4BbAce2TBuXfpAtjI5+Jjad0ilyQJUyAbL6pZkuyoalNc8k1b6BDBCy8Tt6d+leyndmE+McFh1gHQvyu2j2CO0cFM4fkrsSmGBVNdIBmRMjPD6Zw6OTs95tuB5lJGULp91mspbwysIYHZesQP0l84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564251; c=relaxed/simple;
	bh=pwEE6fibC3x6lQyfDb+v+RGRyll+J5mMBnA1XQCUdSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcd0LdndNVkMkketeI1wrce8HgaBaDY/1rEX7OYQgiBoSE+tukkYcaHbNh4qKtxsaIRCiyRt82d5pipFqP36XUKYmfzHXsHbZQdJzkExtlWJpfNE1qTOSpzv4iJBlj4dbXK0STV1/x+Dh92w6MGiy5dQVs/whG11CcBpu2Hreg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrkwtfkE; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrkwtfkE"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso2536818a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784564247; x=1785169047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bgWQqTl41PqRe7SjquS4u/1d/gci4UsHSjvtso+pedQ=;
        b=WrkwtfkEcugP8+LlhTWYVodze2uxUaw4UknXzSbamJHUTLYfT6ffFFgwrMrpibpTX/
         THYIk9X8Qso8qyU+Tv16nEIZtNucu5LvqHtF+/xtc/SBk6rITRnEZ/T+v7sreU53pGz/
         SvKo7r83d3dO0WhZ7mcYvbZrNVqMFevvhAgrTtLBGyjdbSYV61suJp0HzdRRpT7tL4Za
         5IWgod+vPzv7Qs+Ww9ZmFdVJ/4PeHY/K7N4H0W2qnFlmn8xadnghJPvHZjVqKN/n2hA+
         yELhgObUJt4jNayVHkmPivafI2wt4+kBU4abo/jp7QDhIoSDLt+5Zj/mltKVlCWLRfau
         ltCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564247; x=1785169047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bgWQqTl41PqRe7SjquS4u/1d/gci4UsHSjvtso+pedQ=;
        b=U7PiKZOZIKfHwmhF7LjJtsK0aGn6pj58g2juoL+GnMhUYCIn7wn1m+OnbZA26NkqPJ
         XQr8MBjvl9I26FWqNrGn/EyiCKP4PqvR/p4LeY43tz4MC3H5W7QT747pfT1zE4GvxWJr
         /fBDADsNe0anU6RZpRJ1BWxagFcR1L184caTdlb/UpdrK2XKYak1LoXUEfbShaddtu6u
         L9FQhiM8tzLXTAhbPMwRDmlkBLpxeROXP3hdkOwQ/KpBaMd4+fvLxmGSGmpkf2QF0xoN
         Hh8zDUPjVJy8y5cVp8Mjrl88Edc/YzckFNgHB1p48DF/jP/wtcLp65OPGn3Hrpl+oTf2
         9cRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXk3skjJ7yH0wiE6zvtGmzsS0SteZpVSIjO0Pi0HJyr1myb+TWZIonGbc89+Z+4QLWxzTl0R3RIeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBlCvEUpbYcjpBcfBdOm4LmVql9VjlGZIpI8VDgC2wAZHrzBw5
	+o5tE9Tro0SETLyfrBnv7gpxXgj8ISzr2b335mA2Jb4eTIL8j/SHdWsb
X-Gm-Gg: AfdE7cl2k7Rkw3d9feIFeQi/zjtdYGRo9FP7CY6hUHp07CbfrDBbMIwvv9JMPKR0CFr
	wqut+pkae3L9Df8Wm4clE7tKJLfwnZfXLHW6NPz9jK7/LyLHrOt3DQ17oo2uqv/eaC62sVsZwpf
	xYE7IodWU9+xlb6XDzGVscPpPwnvd5LHPwkvOKh51xl2KiW/vi2ERZkltsup3AOghoC0qzOwVpR
	3Yp4pa1HAylFArECKq0kKEIzf0z3+z0kEszJoNa9aIJKAdsdXjGuf8LKyGHuIeTc7kOCmJ3rrok
	nBYRBm0t+EHNkHr5jPLtEaKhjzkObMEWn1gU3xsRxE/qGrT9P2ezUEgmu4oPAfJ3JZTPOWwuIhs
	siA7ytIcpPPOmtoXcbNGl/lzdF/Z/qb/Qy6jpeqdJJ5Q/3pmFrRJtM4mIoMAXgYVOg4sYIuF4Ep
	MBXqXUYAqNYl1b2JrzbCNsoZNLiw==
X-Received: by 2002:a05:6a20:939f:b0:3bf:ecf8:abe with SMTP id adf61e73a8af0-3c38d512647mr21472934637.0.1784564246909;
        Mon, 20 Jul 2026 09:17:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1ddeb6sm43145565eec.20.2026.07.20.09.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:17:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 09:17:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 06/11] dt-bindings: watchdog: apple,wdt: Add t6030 and
 t6031 compatibles
Message-ID: <f0d4a047-5dd3-484b-9fb0-89c12bd93ad0@roeck-us.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-6-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-6-55b305833123@jannau.net>

On Thu, Jul 09, 2026 at 09:30:52AM +0200, Janne Grunau wrote:
> The watchdog on Apple silicon M3 Pro, Max and Ultra SoCs is compatible
> with the t8103 (M1) one. Add "apple,t6030-wdt" for M3 Pro and
> "apple,t6031-wdt" for M3 Max and Ultra as per-SoC compatibles.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter
