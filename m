Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18C13822B5;
	Tue,  9 Jun 2026 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987182; cv=none; b=speGsKAGICVEFXt2t02tvRTzd0DdFZpS5aGGQ3J4aJh4W9t4JWC4qv/QahgRLpxM1p5lNJTyHQAIXWquJdEwsd3tLIHIqB5aO+hR0x/sfpXHWTRQ4CLYCWqsHgWR09EfqzK8xrrlrLqKl/O+KV1muODY+Jh2yjxdNf1ODKAQSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987182; c=relaxed/simple;
	bh=6GhRNbw18fGJngPVs30vPhxw1lzxZLuo43RNTks+D0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M36Rf7APLn6tveQR4QHrnXYq0QweNOMIvc/ekGbjGV0a3C1HZpRjOFX7YAxZgLf/zc7jXM8BVQLUU1z8QJuAv6kCJdTiqw4iOHWqrAIFREM2HcSABAe0c/9MC7U0AzDbu5OYdo3Zcw0vehFHuuTiC4f38+g2zCzhG0GhuFvDVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPFZzgON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPFZzgON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA601F00893;
	Tue,  9 Jun 2026 06:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780987181;
	bh=xcImQOqL6PDWwrlJ5hBM0I6IaHZiTAIqROkPTLemc4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oPFZzgONsCmpDVEnv1PkmSV4RZfIndjsWDO3yz8yPSWB+KrMr5I2cFId1WVCrxzuT
	 KXoUETYrs87Kh+wLbN/mv970JcAgST1p3f4tqGMqvxCZmMIB4Dp9AA8drEmo995ns0
	 c0ewJGdIjsbYHzwTakmBvn835Hn+Wzzt5T013EycT0n0LkfTvkSHVYmDIlbxEGkWlL
	 z3ZlLFWbhdtvNloBiKXD3VQ2oSU6/lVkKCfcVqwIwePxro17ihQa7WPNxTzj3wN6L+
	 DwWGeMR11TlydKxOuWsC8J8e9Ri1D9RBTJZi5DhYXyQ0vbBEsFlViVC8yEav10MmUz
	 pBUABFqv051sA==
Date: Tue, 9 Jun 2026 08:39:36 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ajay Neeli <ajay.neeli@amd.com>
Cc: git@amd.com, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@amd.com, 
	srinivas.goud@amd.com, radhey.shyam.pandey@amd.com
Subject: Re: [PATCH v4] i2c: cadence: Add shutdown handler
Message-ID: <aiez0H0PPX2NYkyv@zenone.zhora.eu>
References: <20260430053050.3590173-1-ajay.neeli@amd.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430053050.3590173-1-ajay.neeli@amd.com>

Hi Ajay,

On Thu, Apr 30, 2026 at 11:00:50AM +0530, Ajay Neeli wrote:
> During system reboot or kexec, in-flight I2C transfers can cause
> spurious interrupts or leave the bus in an undefined state. Add a
> shutdown handler that marks the adapter suspended and resets the
> controller, ensuring a clean handoff.
> 
> Signed-off-by: Ajay Neeli <ajay.neeli@amd.com>

Michal's ack was missing here.

Merged to i2c/i2c-host.

Thanks,
Andi
