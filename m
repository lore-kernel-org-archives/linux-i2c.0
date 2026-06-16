Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B303283FF5;
	Tue, 16 Jun 2026 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781651900; cv=none; b=WihjvTK7xVSRcbwQAVJr5EsqxO8D34PHjE4flhoJCMEhj+pEGAf8M3EToU/UwYX+0Df60Ti4/JyrKafctSD2LfqkuvsHpd52iL8MV+Bz6TneMmsFN7l8XX3diGC3FsZAGIC8FgZrrcA50ddsoRreU/5qOkhXYsaZuwjL+ip1X5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781651900; c=relaxed/simple;
	bh=tPxweJfUOnNi3nYFYFGOwOppY8+P5BdN3O3dzIJYXhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb0VNlgnawhQEamkCL+yLF02JYnBJVA0ftQZecypcsau8L14DjsZ65+JaHy6wMMbZor4Sebj76Dv9oEh9txPKYgGFy5zNK/Kz37egfpeQG8h8RAaEiGVUlpNim3FxlSrVermsoLz7v3xa4tQ6Gvq9jy0Xy04+nc1xYKA1RtcY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg90PenM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg90PenM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B891F000E9;
	Tue, 16 Jun 2026 23:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781651899;
	bh=2uIFQDYqrhlKjWeD5rf3vmj7TAhAKI5XKv0WTBppYP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jg90PenM5pUumMc46VrLSFfmUZuMbDFODJ1X4JRsLtHFI7Hmi+E7Ic9TDdwzUgh1y
	 vH86LdSwTAdwX1wnN6o8aGhMD8OhleGjjS3h7YLurkFSWHTXXQ9+ORhb3YuxLI/Yo+
	 KuV+Gj7s1qDsNZsCXyTkBl/k4G8N2XYChgMaZNDolLehbWJdGsDKS4Z9yzjwLLuvmB
	 6xOTs+vwrwZUebG1UzLLxeSQOJbqp9kkFHLmIRaH15Jf/2YcuDGM7Ukmk9fIAC7/S2
	 Qi5t6VE/5/pgu+dmg9m27l9c6wcAt0llMnrWHmJJ6mPwB0Kp8SHuyw7vjsAOASCqOu
	 ZbyDw5xAYhr8w==
Date: Wed, 17 Jun 2026 01:18:14 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Alex Elder <elder@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Subject: Re: [PATCH v7 0/2] i2c: spacemit: improve clock handling and cleanups
Message-ID: <ajHZlsTAp3bWRF1V@zenone.zhora.eu>
References: <20260508-k1-i2c-ilcr-v7-0-8c2dde5c3ed5@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-k1-i2c-ilcr-v7-0-8c2dde5c3ed5@linux.spacemit.com>

Hi Troy,

> Troy Mitchell (2):
>       i2c: spacemit: configure ILCR/IWCR for accurate SCL frequency
>       i2c: spacemit: drop warning when clock-frequency property is absent

Sorry for the big delay, merged to i2c/i2c-for-7.2.

Thanks,
Andi
