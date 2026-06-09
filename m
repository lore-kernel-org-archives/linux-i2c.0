Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E83F39E5
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008460; cv=none; b=JphYOJoLe5HnpjvjwqC3QWnJdzW4aNeRqzt4Qq/XuUkPrW/vLVJEJrIRYuqWchNQsar+b68FkL1bvnMeQwk1gJ03d3zs9exqsRaEsRVFg5ZkCsCYcK1Pqnez6Uv9E4tVzz/sgbw1xhuZiaSoRdopRpiBAk73GqPAbiTU/qTrpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008460; c=relaxed/simple;
	bh=WQcagHGZcCvvr0jij9fbLSMzC/QOP85hwzBFaxe25U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGH/uaT80mvLcQdcgtzF9p6Oi5cNjpyh3IsD/fZxQTxRcWTKhY1t0ZVyOrm/dGgzqEemmNi/tCpLr+JMCwbRPDF2Rkfht4KSuHqucID1lVADV/Ze7S27IHG/nAClbbTOr2rNxXBPWc3r9N/U1TyXc5y2OO7oAG9e6ThbsmOG1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAtZSVVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAtZSVVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AF81F00893;
	Tue,  9 Jun 2026 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781008459;
	bh=ng3bXUlX4oMXN/8e59Qs00B4Lm4QUVHZQawdlOeflxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fAtZSVVcAV3sHZnf+mUqetASYRx79eFWk8qdXcNRJnJIwcuUjU944ZT0VBh4g9UIr
	 jGNBCw5GzPUD1uFQRSS2/ctT/gJzjfce8wPUnEe0WiNoMuKVHkPswWRtbwHByD2Sf4
	 mutocoGShFqanUIMZ18n5s8VIhOqZzu2pV1XTUZW6oYPBmvNKZJ8qrqtZDhib1wf90
	 AkXmk5v0XVzRfYA3ZeKwducpaEL3+9+Np2vP/bcUOVZ9iCR5elrCXEIUcpwtJx29la
	 bkv4aWuei9UNvs5sUVJzuMphUehU+se29Qk0+PN+RLv4vbwnExxRT75zalHPhsj1eu
	 wfdxbjQvN7YRA==
Date: Tue, 9 Jun 2026 14:34:15 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PULL REQUEST] i2c/fix-registration for v7.2
Message-ID: <aigH9xxr_2T8EZEm@zenone.zhora.eu>
References: <aiclzp0IA2Rk7NyU@shikoro>
 <aifphmi1oFYZz7dQ@zenone.zhora.eu>
 <aifz56BVLCdk-lDu@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aifz56BVLCdk-lDu@shikoro>

Hi Wolfram,

> > > Johan Hovold (10):
> > >       i2c: core: fix irq domain leak on adapter registration failure
> > >       i2c: core: fix hang on adapter registration failure
> > >       i2c: core: fix NULL-deref on adapter registration failure
> > >       i2c: core: fix adapter probe deferral loop
> > >       i2c: core: fix adapter debugfs creation
> > >       i2c: core: disable runtime PM on adapter registration failure
> > >       i2c: core: fix adapter registration race
> > >       i2c: core: fix adapter deregistration race
> > 
> > I cherry-picked until here in i2c-host-fixes.
> 
> Please don't use 'fixes'. These changes are too intrusive to be added so
> late in the cycle. Stable maintainers can decide if they want to
> backport this. While -next gets some testing, a lot more testing is done
> once it hits Linus' tree. If we cause a regression now, we won't have
> another rc to fix it. If a regression shows up during the mergewindow,
> we have multiple options to deal with it (fix it, revert it). Next
> mergewindow is totally fine for this.

yes, I did spend some time looking at these patches and i was in
doubt where to merge them. At the end I decided to split the
series.

Now they are all in the non fixes branch.

Thanks,
Andi
