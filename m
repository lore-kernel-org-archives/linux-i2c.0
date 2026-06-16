Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D235EDBD;
	Tue, 16 Jun 2026 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647230; cv=none; b=YTQbPrho/6b1XT1E4btkQM1iG1eXatFewhSDe8Nd0JX9afsRk7aqimOij3GwoXPUnW3sENXfjMmbNelPV11tkpDGbDySAPdgzuSuN8reunCWhCyiv5Rj816KBCqdbEKx2dF0SUMHlXWVhEXbPaLxFYEuByB0ASjnTg5KQFpXH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647230; c=relaxed/simple;
	bh=GW2QYTdB57IxJjpJpew22Y86kBQhhyqCBMlJ/dY2Wgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmqbyytihF2Z1mm5qpN/oCnNTMQ4zvvLry+IsKHVCLNpFt2fQRG7mTDsthKnI4yFwFfxQdHFvruWEOQd9G83oz1aqqZE6c5k4vIb0msAZ/mlQJWMVVLWoPyVmzK1AncRvcb/QFOduWEEqw5g97Bd4rkklomJTSmxNe0j3dWQs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYq1m8F/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYq1m8F/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAA21F000E9;
	Tue, 16 Jun 2026 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781647229;
	bh=lu3LNxrRh1XtKFlWZGS2o59qWJb34GfEKsfXZfFHfEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jYq1m8F/i4pTUWUPNvMNm5gXXE/mb8iRXEupzPkPywj/E7QpZhtVwlMj7wgMATsJB
	 tNHywvoyvL00Qt2GiF6tUqoaUaOnOsISwq7Ygy+B9EftYz3qRO3H8/wbxUjBzH20MP
	 BlKUAgpx+OJ10o2FfAobtq8rOHuVINY2zUBfcu9kP4nEKPuXSn/JHVVyJnERUexhJ5
	 d2wY3FfRNYpWHGklWp1p/OfMuWqG45CSFIbVwXWGCA0pZa1Z88vds3ZogG6F7lQvwx
	 3IiTj1kI4Nj7bla0xgaRJTb44qYCFXcxKtVmnYX9JHtbSHsoJ2LMZTXOp4rJLqUPqH
	 MMbzlJH8uf3FQ==
Date: Wed, 17 Jun 2026 00:00:23 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: algo: bit: use str_plural helper in bit_xfer
Message-ID: <ajHHYnh56SFxMgU4@zenone.zhora.eu>
References: <20260511104911.183606-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511104911.183606-3-thorsten.blum@linux.dev>

Hi Thorsten,

On Mon, May 11, 2026 at 12:49:13PM +0200, Thorsten Blum wrote:
> Replace the manual ternary "s" pluralizations with str_plural() to
> simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

merged to i2c/i2c-host.

Thanks,
Andi
