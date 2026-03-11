Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157D729405;
	Wed, 11 Mar 2026 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254568; cv=none; b=hlXmxMHJcjH6/5k9bjnWtbFA2yAGG001RrA8LcATMpu9P5OMPCcwZfotW/Y1ESOO+Hvi+CCWrxf93E6hO1p5scsaAmHJ1fGkqZ+VVqY1mg6ClqMH5UOrAJ8QaVuEoCQerFOuqhvaYwYJD3XpePBoYFGw8ZakqM7tm/RjFkT48JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254568; c=relaxed/simple;
	bh=rU/nfh0eiw/BNYyCsoK9SG+1YHVi4GWvwRM8+A4rGC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icg48obwnmYT2mqySgWr5CR+Ug7v1kQhkuQ41V/DFQ7uW09dNJxBhDlWaNWzG29lQqbKcickgGNRdvqX71fZmFEvgor1zCKEzCakhlays++qvFfCbwv5asEujUL4KA/J983xmb+9lpF+7aj2VmLBRUHcWLRKG6f7OoefHOu0OxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=mrO41Wn2; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="mrO41Wn2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=GD2NKC1NguisWpvw6QCUZiLG2drMKNDcd055CeU3wTI=; b=mrO41Wn2J/SeJauPY7KsZiZlwi
	r/Hx8AmJ0uowfY7xOPtbX8UnScMn1I8gVmZbCM4m5vYq7AwNHzFCA5SFAIL0JRvDtwnnj7c++L6gt
	pP7czcQSIeV0Hy7cZdEeUfwdgKPWxewSM4FqBYYWsuTwllzQl7zfsUguQXztRRJxr/Y2cQrQyBrHW
	B9nPA2U4JHRgfi7QIZ/Rkr+6Dnixks3JlKQm+crdRSJUPnVVSCeiU7awT6pZXpeSlC75y1+rpavUG
	IT92wQ+Bv66p86pnPRzK67fSLRzIe0SUgPRVk6lRJ/4oFs+P312EhN6gdO3aRn7BDEDdSd9NPj4Bs
	WFDpx/zA==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1w0OW1-00000007fzj-3GdE;
	Wed, 11 Mar 2026 19:42:41 +0100
Date: Wed, 11 Mar 2026 19:42:41 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Yixun Lan <dlan@gentoo.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Alex Elder <elder@riscstar.com>
Subject: Re: [PATCH v7 0/2] i2c: spacemit: introduce pio for k1
Message-ID: <abG3ofh1nLWPO_XS@aurel32.net>
Mail-Followup-To: Andi Shyti <andi.shyti@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Alex Elder <elder@riscstar.com>
References: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi,

On 2026-02-07 23:08, Troy Mitchell wrote:
> This patch introduces I2C PIO functionality for the Spacemit K1 SoC,
> enabling the use of I2C in atomic context.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
> Troy Mitchell (2):
>       i2c: spacemit: move i2c_xfer_msg()
>       i2c: spacemit: introduce pio for k1
> 
>  drivers/i2c/busses/i2c-k1.c | 316 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 236 insertions(+), 80 deletions(-)
> ---
> base-commit: 2fe0719258a48c204270366ef574066122e81924
> change-id: 20260207-b4-k3-i2c-pio-318088c1b3b7

Since there hasn't been any further comments on the latest version, 
would it be possible to consider merging it in 7.1?

Thanks
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
