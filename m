Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65649272E6D;
	Sun, 30 Aug 2026 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788124503; cv=none; b=aJBzrh5mmLcHy8XNkxtomaLs59jzNfYJy8hKcO21sQrHnligq+l9oQiE8Lqw0bxTcCbptAlW83C/k42o9AbpCnENWeXQNVjpTNyyLVBJpNa4UGAfieDtqQL6UnvslW8+Xs9jYBHLib8nUw2KLMsWRFMiejpJ2T/iIlBFN21hd1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788124503; c=relaxed/simple;
	bh=MQrthRAMld1qJ3myJePtMW99S8t6zi7TBQ3efOznxCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4cdHodF6SZk7Wynr+s7uUJqoaIJLignW0gv4enW5iCJTydFXKPBQmb3wGVP2J/hmGHlaiHKcPrCSYtBm6WnXN/m0B5280kYzOlsCqwQYkd5zNmBZE40/3zYF2Caet1wsdWjgORorECf0E7prp9oeszSQC2fZ769ba6mz2gXeRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=c3EJYax4; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=c3EJYax4; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="c3EJYax4";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="c3EJYax4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788124489;
	bh=MQrthRAMld1qJ3myJePtMW99S8t6zi7TBQ3efOznxCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3EJYax4pYBcunB7NJ9zNgbuKD2Borr+jCsxcHfOlmUNmKnqD+vP2UdVLomaaTxcZ
	 xJODFRAauPlud+1rP0gmNaSxirKbqZyyRmlkkU6gQ09rdEGxsJCX5uh31CtXWvY5TG
	 g/vx2dKUtihMG2kDW2gOu589z9waqPEUuuI1xA5hKTji2njObxEgldj7IMD5uJZQ/w
	 FEHMsX8K/LELgfoELUs4OzRpBMYjhIbs/yM5XXWQnOxLPXx5v1b+MT0lYebml+IfIS
	 V69G1hv13kBl7mcEdlnBFeNQt42I7xT1iIpC3UOrgCts+TuJ8EZ13oVKH3SApm2HJW
	 J3/atUT+Vgo3w==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 975F8CC9E;
	Sun, 30 Aug 2026 23:14:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1788124489;
	bh=MQrthRAMld1qJ3myJePtMW99S8t6zi7TBQ3efOznxCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3EJYax4pYBcunB7NJ9zNgbuKD2Borr+jCsxcHfOlmUNmKnqD+vP2UdVLomaaTxcZ
	 xJODFRAauPlud+1rP0gmNaSxirKbqZyyRmlkkU6gQ09rdEGxsJCX5uh31CtXWvY5TG
	 g/vx2dKUtihMG2kDW2gOu589z9waqPEUuuI1xA5hKTji2njObxEgldj7IMD5uJZQ/w
	 FEHMsX8K/LELgfoELUs4OzRpBMYjhIbs/yM5XXWQnOxLPXx5v1b+MT0lYebml+IfIS
	 V69G1hv13kBl7mcEdlnBFeNQt42I7xT1iIpC3UOrgCts+TuJ8EZ13oVKH3SApm2HJW
	 J3/atUT+Vgo3w==
Received: from gryt (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 8180FCB7C;
	Sun, 30 Aug 2026 23:14:48 +0200 (CEST)
Date: Sun, 30 Aug 2026 23:14:47 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>, falemi@asu.edu,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: mux: avoid WARN on benign symlink creation failures
Message-ID: <apSdR2m-uibYHxVI@gryt>
References: <CA+0ovCij3QDLRzt8CwpjBy-BbJ5Zf5SV9w9QZXz8uD3Agws31g@mail.gmail.com>
 <20260830041303.1934825-1-peda@lysator.liu.se>
 <apSAfJARPgsbSDYb@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apSAfJARPgsbSDYb@zenone.zhora.eu>
X-Virus-Scanned: ClamAV using ClamSMTP

Den Sun, Aug 30, 2026 at 09:13:24PM +0200, skrev Andi Shyti:
> Hi Peter,
> 
> On Sun, Aug 30, 2026 at 06:13:03AM +0200, Peter Rosin wrote:
> > WARN() is a bit harsh and causes a crash for panic-on-warn users. Degrade
> > the error reporting to ordinary dev_err() calls.
> > 
> > Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> > Link: https://lore.kernel.org/all/CA+0ovCij3QDLRzt8CwpjBy-BbJ5Zf5SV9w9QZXz8uD3Agws31g@mail.gmail.com/
> > Signed-off-by: Peter Rosin <peda@lysator.liu.se>
> > ---
> > 
> > Hi Farhad,
> > 
> > I assume this patch helps?
> 
> I sent this patch for a quick test:
> 
> https://lore.kernel.org/all/20260828135950.454799-1-andi.shyti@kernel.org/
> 
> Maybe they can be taken together, as I agree not to fire a WARN()
> there.

Hi Andi,

[sorry for droping you from cc, that was unintentional]

Yes, sure! And fixing the root cause is of course always nice, good one!

Cheers,
Peter
