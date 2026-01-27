Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7225022A4E1;
	Tue, 27 Jan 2026 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769555522; cv=none; b=oGfUIqTMkZ31mEjqUI4lzp6DwFxfaW6al0ky2s8lbEtfy8p1m87iccB+1cUoXZPfqKFMSGapz0dvwtKx81QJDMiFZSq6FSBawc7gMPvinr2+TMnSGCSPezmhz3jZu1vO3wjRG4OUKUL0PbZFEaY0nu8KJ3xjt3U1F5AiXAkE8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769555522; c=relaxed/simple;
	bh=68T7+hi3GfRvxGadzdFMnWpR0kgpN0ZAWw8675OdBp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6AWym+KX0QA36oaOmIfRT1LVumuov+zY9XNQEIW78yqI5WuIWmnYnrtVShgD4HYQB3ItnJH7iTtJkLy7ULx9o7vc0lTXFnQbGp94mDUvL705lvRficFU0SkPChyDOqcGVQpROp4CaMNrLQXILABdOx+fg79eb5XLwUlDFrq44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=MyelrmZN; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="MyelrmZN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=XoNz+bFESqiIGSGAFsK2z8pn76uXh1Dd/smWOqdRSI0=; b=MyelrmZNPP+LD/KVFoFjD5qoxK
	AO3plmelrpHz1/VyoszrfNftC+XWnYj5wNJxWp3OPjESIEFayi7M0PYJSmf2R9LshW2qIDGQbEpd1
	kJWNzE0D0dk+PU7x5OaV0KhDqUrw/muicVeHlGShOJOAf/JkgiPOXj4OiFhHuqQv2O8roITFutrRR
	ZDLGsFBhrVKBcZae+j2cLAeBZxPBpG8JWgn1HGlsp9T+0Br86AJ9n6BcMjsFlNsPI3kSM/1OWeKQO
	6EdbqDfBIzC1s9MiG5T4CvROj26xi5KOooUAVJpNRwGTe2URat8P9HgPedYN7UGFHjMUC012it/Ql
	Y0uLXUPw==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1vkruN-000000045up-2NS5;
	Tue, 27 Jan 2026 23:51:39 +0100
Date: Tue, 27 Jan 2026 23:51:39 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Troy Mitchell <troymitchell988@gmail.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v6 0/2] i2c: spacemit: introduce pio for k1
Message-ID: <aXlBe1CHq_HbbpCR@aurel32.net>
Mail-Followup-To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Troy Mitchell <troymitchell988@gmail.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
References: <20260108-k1-i2c-atomic-v6-0-41b132b70f68@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-k1-i2c-atomic-v6-0-41b132b70f68@linux.spacemit.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Troy,

On 2026-01-08 15:52, Troy Mitchell wrote:
> This patch introduces I2C PIO functionality for the Spacemit K1 SoC,
> enabling the use of I2C in atomic context.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
> Troy Mitchell (2):
>       i2c: spacemit: move i2c_xfer_msg()
>       i2c: spacemit: introduce pio for k1
> 
>  drivers/i2c/busses/i2c-k1.c | 314 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 237 insertions(+), 77 deletions(-)
> ---
> base-commit: 003e84792ce811256114dee4f4ecc1cafdab2b0d
> change-id: 20250814-k1-i2c-atomic-f1a90cd34364

This patch series got a few comments. Do you need help to address them 
and send a new one?

Thanks
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
