Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E83254A8;
	Tue,  9 Jun 2026 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987396; cv=none; b=iHcVrF7ea1XdEC3yev/qvotOkbpqNpHNNgqzIUlF2MONJacSXcdtNCvIpfPcp1VE0Sd0wU/w5o1abhMrfikQWa28xTd80Rl0xD8BJzBERKx2JAb4F4uV54X8qAgWflwtwkHB/VTekhJFvEbXqU+ix3bfaGpRczDbHEvzzN9pJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987396; c=relaxed/simple;
	bh=uz2GpeePShIkAXjZRZ2MiQ0lN6WwYae3js1CgqH8ipA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvnWXTFg6JBnrqEdhSNzbsALpIQBiAgb1QCNEE8ZTUhtDB+rQZBYVJZHGZMgls3qE85xZK9BZWXFouxcI18oCUd9sS6rDMo07g0/GRIDUY7VoxAoY4Rd7bMrHiEhBVqlU3MLBJLPTZSrFIdvpQ0U3T+KZ5e/PQwKxbKZNC/WEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUoPRJ3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUoPRJ3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E631F00898;
	Tue,  9 Jun 2026 06:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780987394;
	bh=IJPT1bHYjTanTRPxEAyQ0+tS4qnjbS/S9yshyQbHp1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CUoPRJ3PgPKZWdLae3uYujKgjdRKdmOEv69sF3JV4xNU2/kJdTv1GBdY2qb/vUSQW
	 QcauFfghdu5eCwIcoZqLy741xukXie8ooZboIwcVVDs0JdhXJpSD5cu+2Lr9holMkY
	 JfHjbjlKQ+Ff9SKDHrAArNiOiP71oqXqy3f3BHfeJBmtqHlRQMlqOfLm6AxyBrUT8j
	 d3q7CppTzxYOn+N8NEamXQZDRQ5tNu97iIhxs9F7o/QzYJcMEXGb8FK60BQx5u00wo
	 hqxZvw52C3EENJwZqlV0vU+M/N3YT54N9MVi6ZiZ6b7RxA8X45BEx1o9n5tRuU4Tok
	 1TMppXCZCqQ4g==
Date: Tue, 9 Jun 2026 08:43:10 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: florian.fainelli@broadcom.com, rjui@broadcom.com, 
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: bcm-kona: fix spelling mistake in timeout-check
 comment
Message-ID: <aie16wKAS668TeVd@zenone.zhora.eu>
References: <20260503165925.1738-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503165925.1738-1-sozdayvek@gmail.com>

Hi Stepan,

On Sun, May 03, 2026 at 09:59:25PM +0500, Stepan Ionichev wrote:
> Fix a spelling mistake in the timeout-check comment.
> 
> No functional change.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>

merged to i2c/i2c-host.

Thanks,
Andi
