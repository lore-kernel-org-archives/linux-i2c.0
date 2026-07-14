Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAB3644A4;
	Tue, 14 Jul 2026 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043437; cv=none; b=pcj1J2Xwg1QC0sgdIb8fU5nnptQkLIOZOdVHqAIPSwgA/3ygQ7qky2aqMB6iSWI8KF0CP5QZQkPlIdBOiELji9zuHJ9KKVPYEvkBjC5tSP4nKIDOfPIml/fj/A2z5XxSPVO3RwfgH91raN2cabIMwQpARKoLjlKoPuFA6GOnVRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043437; c=relaxed/simple;
	bh=p/WVKNRgG6HCMh8QdcHkpFgg2wBA4OGdLOMQQGR5bXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtOwIBgV25erhXQ3LZCcKU0gv1qf00BJiVI1MQho0xxvJwIr6RzPFAQSc3aMBI8jQKK7cNOXVuHX4vRW2j2Oyfxxt0/FIp5Er5rakvrn/r2WVMkzuKl3Wac/rGOY8LmCJAmTs/XK6uvSnUKob32f2nw6s/Gd1cIIfGWSm75/ZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSudT+fh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSudT+fh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2191F000E9;
	Tue, 14 Jul 2026 15:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784043436;
	bh=p/WVKNRgG6HCMh8QdcHkpFgg2wBA4OGdLOMQQGR5bXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mSudT+fhGsjkm1g7cHqsqzU9OFwdWKZdQdeL6LMnf8iYmh+1TH0pMbblp2eT5BvVR
	 EQc7YaED2+psd6tI4QUVFHYcWtjr0Bq7/Ia/Fl94B6DY4k6b85Qk8e+hDJPw4F1wir
	 ZhFCa1sR6Swq0A+/zlsBdmOhCtrpx9L8JpVDdOdAEX08Wp2evSJmnd7YxvjX62Of+0
	 uWmLmcAeURVSEe1HCSbCKazOC91BCEMdVreaIerBOtWzB2/vERh2FNWTsQu0jNN1Kr
	 gxabJOOOFZxHjoleatK3GksI3w/tEZZEgWJy61vBEOCW4jEqz8Oy8/h4myZPxkVzOz
	 8tv0PjlkgtzmQ==
Date: Tue, 14 Jul 2026 17:37:12 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Subject: Re: [PATCH v2] i2c: spacemit: fix spurious IRQ handling returning
 IRQ_HANDLED
Message-ID: <alZXX4xX-f2EPNIJ@zenone.zhora.eu>
References: <ef8b623f45d4e430721e46572c2598d882044aed.1783667603.git.xiaopei01@kylinos.cn>
 <ef8b623f45d4e430721e46572c2598d882044aed.1783667875.git.xiaopei01@kylinos.cn>
 <DJUQ3TZHM7OO.34ULEC76Z2BDY@linux.spacemit.com>
 <e453a825-4d73-4d35-a699-a495b0ca1058@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e453a825-4d73-4d35-a699-a495b0ca1058@kylinos.cn>

Hi Pei,

> > One process note, though: please don't repost new versions this
> > quickly. v2 followed the review comments almost immediately, which
> > means other reviewers who were still looking at v1 never got a
> > chance to chime in before the thread moved on, and the discussion
> > gets fragmented across versions.

> Because I noticed a simple mistake right after sending v1
> —I forgot to include the version number and changelog for v2—
> so I thought that by fixing it without waiting for reviewers to point it
> out, 
> I could save reviewers' time and get the patch merged more quickly.
>  I may have been wrong about that. Sorry.

You could have just replied to your own patch. It happens to
everyone to make such mistakes.

Andi
