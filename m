Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061343242B5
	for <linux-i2c@vger.kernel.org>; Wed, 25 Mar 2026 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463516; cv=none; b=txpSUh47+MssAnHC1Y6WhgEQgUpv1MaRvdHJ/CmGWAak25u6zWV2uypOP2lCmDhectVZ13vqgdWkS7xGzAfa1v7KNIEHAtmArIZNtW2cyReE8xsQGjaURaw6P4Gm4NyF5Tzd+nRK3O/6bJ2HRKOfqLBUYuy28WbmXLvt6R2Lq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463516; c=relaxed/simple;
	bh=4xuZhglcoJDA/BrhgaQMDHF2urWeAaGI1Z1eNAwKbsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7xH4zT38rFRgv8a2VLI3EGVuWAIEh5xiH5A+D5SL4W0QrvnMeq9TmlpOW5ovgyKO3w5ULZy2s6d90yk6N7/tsUq3sNB0/pzEwgOl5+dFzKchJU67QwrMNtGStiRlsT3Qj8agVCXKvlcjobIDwqSiXHlss9QY5dpAfmBT5P9PDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJLSN20a; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJLSN20a"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35c0e7b751aso141907a91.2
        for <linux-i2c@vger.kernel.org>; Wed, 25 Mar 2026 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774463514; x=1775068314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gy65ZJCUKrHKtVo+Gt/tJ26gW+mdGsVi4ZKpe38qdBs=;
        b=qJLSN20aIAzHJK9Jlp5ZX/9di1iuEJhQdyHNljf/sbAwyPV2gV3Ye/HsjdXPRODv5P
         LQRflbaFBVCHkjw34XscIWOOv6YUYBFyo8PvNuM9K5YhPWz3YQOgM/uqJE7Fvfg5aWKE
         IOhJvMc/yb0P7zFp+QBP58MlkzAXAk+JfG1Mx/xBgRRrg7cKCOfHmyeVuBGUwoIAY9ih
         rgyGVyGoumPAVLJTvA+pwnznjg62xHETSjKBgkHueX/esefLYmhJ2k+POnG9/4CO4pSC
         4i4ihdBjHnoz1/PWTKyLo4vqyC9UiX9sLBzrUqYdV2QTCzQodqVyuQE0anlC74hlheho
         qMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774463514; x=1775068314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy65ZJCUKrHKtVo+Gt/tJ26gW+mdGsVi4ZKpe38qdBs=;
        b=ENARbby6KbHdzawWpquIfSledHYz6neO+x8xzyZpBbc6jK3+vXyiR8mYA9ZLJhtC9i
         gwje4UDeI2fMEkX7yMuvDuJ/ja/iKZo5WOMt/R7Av3l0Fp4ghcAr4KHgQ06+RLvNHYJF
         Sg22eI9bQqdkrxd5ltYLmC01lTvGoKV9f+8Lf3vo+U2m4fEEHuehuzKnZNAVhsaBXNva
         zvGr6wc799FMgHb8y9S3wxGv2Qz+Oum9wCeAVYRMa5F5CsFbtXJ9mSd1iMwVwG3IS5UO
         R8Ckd0fxwr1bX/poj5tqZonGXWyD4buLnXD54bwabltJZ+l7mEyCJbPsH6LfnDD8+9St
         5iYg==
X-Forwarded-Encrypted: i=1; AJvYcCWrQXAYu/SWscVpaY1J1eCCdOPrEKxKSsF5AWGTuqZIJwVJKnhzbhQGXKC5m+DJHVnLfYAWj6b1n/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3MRUn+v5GH/44CHlx8Ft2H7ZSKPyHFZBjOD5CiadEIoleq0O
	W4ipL/whaicvBtPD6KBil5KIbAEiS68knlYzUG3tZH69ED2vYO9rzKHS
X-Gm-Gg: ATEYQzy4KfRy4h6gnY7030Rpd7/3u2GLQptrswe/0gLbVHlCBcze1uSZf63Szqp8nUi
	5HRVk5lbBbjHiheKsXWyvqYGHbycZwE0Geyq4jCZR4IvqBBu0ap9GpCiToGfZEcFHPvMccuOrmQ
	IAAP3cPHdE5pEhVlK3vSH0AqYHpcMAPWGbgdOMUbndxq6F0kRqUwx8qUUBgzVUQUHWwKBt6cDdE
	BGM+uckyPIEGnuWXiwQ+jMKl/7WNPNFaBSe1QhG65eczZyVCVcmtB/Yo62fTUDOMA5NpNRBAdGm
	m0WTOg81O9mgmcbkhxi8tXyPNDb6zYK7/rN/n4J76blQ7uTNy++nqwNrOe3Q4vAwnFV+3p6AdbU
	zd/lstCgXBGlHOcqY3PxZLFLlu1kecrOoWPOVVbuCT64H1JSaXjIGmMGltojyjmkonwS3JVv7fV
	lPbZMujRPgnJqEhDBbsWLNlLw=
X-Received: by 2002:a17:90b:5305:b0:35b:e519:213b with SMTP id 98e67ed59e1d1-35c0dd85d0fmr4311947a91.30.1774463514471;
        Wed, 25 Mar 2026 11:31:54 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:22d3:4161:93a:b87c:36eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0e954ba9sm1336724a91.5.2026.03.25.11.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:31:54 -0700 (PDT)
Date: Thu, 26 Mar 2026 00:01:47 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andi.shyti@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: intel,ixp4xx-i2c: Convert to Dt schema
Message-ID: <acQqE-iW51fOJnTJ@fedora>
References: <20260324135010.17730-1-i.shihao.999@gmail.com>
 <20260325-bulky-mushroom-of-science-8c95c4@quoll>
 <acP69aM-euL7wl87@fedora>
 <c9b68d56-48f1-4ade-8711-fedd8acf0666@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9b68d56-48f1-4ade-8711-fedd8acf0666@kernel.org>

On Wed, Mar 25, 2026 at 04:15:39PM +0100, Krzysztof Kozlowski wrote:
> I don't understand this at all.
> 
> You did not run checkpatch. Neither with --strict nor without --strict.
> The --strict does not matter, why are you even mentioning it if you did
> not run the checkpatch in the first place?
> 
> Best regards,
> Krzysztof

Although I did run it, I think it might be best to pause this thread here.
I will send the next version in the coming days after properly running the
checkpatch.pl script. Also, you mentioned some guidelines regarding GSoC
could you please let me know where I can read them?

Thanks
Shihao

