Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0893ECBDA
	for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525177; cv=none; b=GFThkiwu7X+MkGLTCoG4v4jgZgAriU/BEgT/VJp5cCURMF1DdWp068woOrdqd7Ynf4Ud7ZUnQyOlRx+yOfXDClYf2QTpaXiZ6G1tM+lZFMK4Q5zluUFuQWKDsWT7GddQoGYsLbYINBESJ6YjZOPJZzVh+DoWhBt6ILHjD5zpNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525177; c=relaxed/simple;
	bh=f62V4X4hSvGxJKdk/w/IZZ3abRCMpC8myNrDjm5ZBe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjS5rWl75hSL6i1PVnFv8jX+vebC4xexyiY++/hY66vZSjhMTvrDnVd+yaebwUKiAY38nblaeIUjlZ4YMRKNiwRx2Lcc/jxhqqYlmHVhPf6Nsac1kIWX/Sbmfn8V0oc/wCjb9xkgAccsIj+gGk3dicU3N/TeOPapZlSCFRm5XN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxlPVJc2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxlPVJc2"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso1038217e87.3
        for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774525167; x=1775129967; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JL83gbLudZtH8CT7uiZfcAOnl7OPRgnYQKRWmn1MAfI=;
        b=FxlPVJc2MUKH2AmviRK1mChmKLuinzobiZGuSCCKQzP/xKuhe4tvCoaX3Q7bE5OwEg
         uNK2rwc6LYACbB4S/i1pAxffe26r3HJfbE0vDfWCtQ0l7QhqFSjK1kKSH4yf/lyxpf5H
         gOq6miYpdCXXEhRR32ppudAnKRocqW8qBjMZ7CChHT78yWdGPw5wOpeF4c4wVYNex29G
         hrkM+2TSpDuq6/BNeh/IOtnhxYh3/rYPt95fl6KNVqNH9b7udkVPj6BQQMT1KrVbu/Nw
         lIB4/vRJqtvlrZyfV6XbXUyWsZUswrrVWcjFzM1cSHGGiUf1wfHqEJpe3odlFg5lyRFD
         dCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774525167; x=1775129967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JL83gbLudZtH8CT7uiZfcAOnl7OPRgnYQKRWmn1MAfI=;
        b=ToWtu+/VkNGOdhNVSQtGf3bYSq4livAK3GT4b7ydmaWDiEkUiDOopkNGIgyBBBoRQR
         T8YzCY7Jr0c4Lo2LBeuf8XTwC7Sxw2drp4Jza1zOgNmfHB1vbeVDxoZ9Za+/H4Ov2/L4
         hdYsFoijYjaMUYx5xO6E8efh8VNGzX2EKjIykqVAB3G/V6GXAYjgEDAAO2NfHMyhjJ4q
         br9V6tf+HGOiwvtQSvX0JxPMTjo2OO2Pac07a1pqPI3mvqlj3KXWNWFFMI43bfsyvft6
         A4PW/vIRcHAxTfNpdKA4H/3324Fedk7FxcNnwljj9pChZGc2kK09uhpwOLk+g2AojOfd
         Qpcw==
X-Forwarded-Encrypted: i=1; AJvYcCVrFY5IWWRUYv4zkp4yTa2lWIHcWGSKnF4YslNxX64+pMG9lb964IjfzSbIbxKw6T5oAWXOec03I6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64lHt/gRieuITMpi6hkF/hEhkoJx0YknVmwB97yG56FKhl4Nv
	yxUooW8Xu4TnFoeAQzmUMoFGqb60/VF79hocCvP/LnOUL237lqk8OuwE
X-Gm-Gg: ATEYQzxPiwbuTTCWiPWO8do2n/w9Q8zscJB3uUpM1HPV0n56xD7ZIFZZ6MI35WJv0l2
	cXnqx3Ix4NlOGoZyIrKzGHOaonyTjRPpMklf1zdGXtF3Yq0IOESchcirvL3kQW9ENJG8UnwXRvu
	KH6NeBk2jxnPn6C2U7NbF0nLJV3rZJyX/Hf/3pR0o4UTDUYMCMc0RuUy7ZaSrdq4ngvvuLL3Fl2
	1N31D12BRprDklt99DlYP1vSOCQJKfDdZPH9T15SbH3wtt+xmK9jn+isO1r7/dPvTLWKiC+i4yY
	YekebIqpHF656vgwpJBnFGmGkmAahl2E8h1etPKz3GFx9cr+KI0L6yjYikd0YChS3YIFsWkM4jV
	DeSzzXQPV0fMV1o9GAkHZa3cmtM1BlcHH9kIr05AsNvfbYf3GBpal3FEXR0W8aHwYy5hWTYaKq1
	IRoMMREn7skvQw8ZIxhwfwQF6/L69ZoWLXM2kcVXshRYu3ubDCZivKbObRKKV5upcKb44xd34=
X-Received: by 2002:a05:6512:2254:b0:5a2:a5a1:4732 with SMTP id 2adb3069b0e04-5a2a5a147e0mr437733e87.5.1774525166301;
        Thu, 26 Mar 2026 04:39:26 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a063dcc3sm546963e87.7.2026.03.26.04.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 04:39:25 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:39:23 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 2/5] i2c: mux: add support for per channel bus
 frequency
Message-ID: <acUa61a_XIuoOobd@gmail.com>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
 <20260324-i2c-mux-v9-2-5292b0608243@gmail.com>
 <acKbYhbwZzv2gTnB@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <acKbYhbwZzv2gTnB@ashevche-desk.local>

On Tue, Mar 24, 2026 at 04:10:42PM +0200, Andy Shevchenko wrote:

[...]
>=20
> ...
>=20
> > +		of_property_read_u32(child, "clock-frequency", &priv->adap.clock_hz);
>=20
> Wondering if we may use existing API to get i2c timings from fw descripti=
on?
> i2c_parse_fw_timings() (it might be that it needs to be split for pure fw=
node
> one and device wrapped).

I like the idea, even if I don't see that many other parts of the
kernel will be using it.

After this patchset, I intend to make all other bus drivers use
i2c_parse_fw_timings() for fetching their clock frequency. I will
investigate the splitup in the scope of that series.

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20

Best regards,
Marcus Folkesson
