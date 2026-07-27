Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1D42DA45;
	Mon, 27 Jul 2026 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184950; cv=none; b=M6OuAVBPwDAUXaqyzpl/N3elUFTbtBrAAXHN2JXsU2Z6arjYpSEF7uOUNnfHPGd1M3lOEHq6jrelmIwm1mQZrdPBE8AEFGaPBtiS+mIf0+K7Up5bWudJ8Cd6d/I2NGxZhl+zRj+gE8tMymBsx3DHC6W8JqAq2Hb0eJjqtaPv+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184950; c=relaxed/simple;
	bh=ClpIV/dYmo8QIApKdFYOU31XO7WVbv2jLDwmiam9A8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgqCnRsqZNo0c1hvNnef6WuYb2iT7dmMLvnIeDSBuLu6u4rfTolF7pycOvSAeweEXBehl0w70qjPynNWn8hqcOLhT8WCapIJKScVq83qYNXqpc035c02VeBJvUJlh2EwCvtWZn/eLNPgqujamWDy9lZK4Wt/TlTHtV5zSMY1V5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMGjl6h7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMGjl6h7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBAD1F000E9;
	Mon, 27 Jul 2026 20:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785184948;
	bh=Pp4Tl2Ls7v7HGSxkjzMUgBscZWn39kifXrL4ELP+m/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZMGjl6h7nR3QgPAKw8+2gJoKnuF5AMfDZk4++O2qUgllXSH/QSQanymB1RVrCXFGF
	 Mump4INVi5IBGHs3ENwchjHf0j80QjLuLozLvnTEVieo8hHCwOpxZBVmNroBonP5zZ
	 B7+CxKvTHpKim2LjthlmsdbDGDnYsJCTbgwEQgQCKAgBH8xXV4PWg6SGnTvBap0SYH
	 hOaY0oLERXbRwwAIHBKYYSWcaP061JHqzSFIK/AM5MU1Tvg2a3IkMMndDk21C4sJep
	 EQzC3WPF6xpXcYLMHuZT1GCmreNg3ezEtwFEOOJkAB95Hw786Xe/SdIQJpOmc700ml
	 oHcN+EG/67iGw==
Date: Mon, 27 Jul 2026 22:42:23 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Aniket Randive <aniket.randive@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
Message-ID: <ame2tX1RwOo4F6Lk@zenone.zhora.eu>
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
 <amZkf3lu7gjWhw04@zenone.zhora.eu>
 <0c0d1406-949b-49ee-b203-3833b9f8433b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c0d1406-949b-49ee-b203-3833b9f8433b@oss.qualcomm.com>

Hi Mukesh,

thanks for the nice discussion!

On Mon, Jul 27, 2026 at 09:45:23AM +0530, Mukesh Savaliya wrote:
> On 7/27/2026 1:41 AM, Andi Shyti wrote:
> > On Mon, Jul 20, 2026 at 05:11:19PM +0530, Aniket Randive wrote:
> > > The transfer timeout for an I2C controller should reflect the actual
> > > message length and bus frequency rather than a static 1-second value.
> > > A static timeout causes unnecessary delays on error paths for short
> > > messages, and may be insufficient for very long transfers.
> > > 
> > > Add i2c_update_timeout() to i2c-core which computes a transfer-specific
> > > timeout and stores it directly in the standard adap->timeout field.  The
> > > formula accounts for 9 bits per byte (8 data + 1 ACK) at the configured
> > > bus frequency.  The caller supplies a safety multiplier and a minimum
> > > floor so that each driver retains full control over its timing policy
> > > without those values becoming public API.
> > > 
> > > Storing the result in adap->timeout makes it visible to all consumers of
> > > that field, including the arbitration-loss retry loop in __i2c_transfer().
> > 
> > this patch does not take into account a timeout set by userspace
> > through the I2C_TIMEOUT ioctl. That value would be silently
> > overwritten by the driver.
> > 
> 
> Can we make timeout handling a kernel responsibility and avoid placing this
> burden on userspace ? Every userspace client already accesses the bus
> through the adapter/core layer, so the kernel has full visibility into
> factors such as bus frequency, transfer size, and controller characteristics
> to compute a sensible default timeout.
> 
> Also, if both a userspace provided timeout and a kernel-calculated timeout
> are specified, which one should win? Having two independent timeout
> mechanisms could easily lead to ambiguity and inconsistent behavior.

There is no explicit policy for this today, and I am not against
a driver selecting a timeout according to its own requirements.

However, once userspace explicitly sets I2C_TIMEOUT, I would
expect that value to take precedence. Otherwise, the ioctl
succeeds but the value can later be silently overwritten by
the driver.

> > > Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> > 
> > ...
> > 
> > > +/**
> 
> [...]
> 
> > > +}
> > > +EXPORT_SYMBOL_GPL(i2c_update_timeout);
> > 
> > I'm wondering whether changing the adapter timeout from the I2C
> > core is the right approach.
> > 
> > Perhaps i2c_update_timeout() could return the calculated value
> > instead, but then  do not see much value in exposing such a small
> > calculation through the I2C core.
> > 
> > I know you were advised to move this into the core, but it does
> > not seem particularly useful there and, as it stands, it looks
> > somewhat controversial.
> > 
> > Unless there is another good reason for keeping it in the core,
> > I would drop this helper and keep the calculation in the driver.
> > 
> 
> There may not always be a userspace application available to configure the
> timeout.

That is fine. I do not expect userspace to configure the timeout
during normal operation. The ioctl is mostly useful for
debugging

The driver can still provide its own default when userspace has
not selected one.

> My suggestion was that the I²C core could derive the timeout based on the
> bus frequency, transfer length, and a reasonable safety margin. This would
> provide a generic solution that works across all clients without requiring
> userspace involvement.

Is there a standard formula which works for every I2C controller?

The timeout may depend on controller specific behaviour, hardware
limitations, clock stretching, FIFO handling and whether the
driver uses interrupts or polling. A calculation based only on
the transfer length and bus frequency does not seem generic
enough to cover all of that.

> To account for variations in system load, we could optionally expose a DT
> property for an offset or scaling coefficient to tune the computed timeout.
> Even with such tuning, I believe this approach would be significantly better
> than the current fixed 1-second (HZ) timeout.

I do not think a safety margin or scaling coefficient belongs in
devicetree. Devicetree should describe the hardware, not a
software timeout policy.

If a controller has a real hardware timeout parameter, that can
be described by the DT. Otherwise, I think the timeout policy
should remain in the driver.

Thanks,
Andi

> > Thanks,
> > Andi
> > 
> > > +
> 
