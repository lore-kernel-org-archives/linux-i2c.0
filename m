Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316029;
	b=oNacFzQiboBz+p1YpZOQ8eTTMsuUGzGVoq8PpFnHsSn2+iBC2icDbwusBG+L193ZPKzi
	 ttHi5dX8W+bfJvSXglxrTZpmDNtLs3x6egTLBu/fRyujMw9TTN9i0XMSYaia/wOHmgKhA
	 t1QFnrGRtTpsfi7z6Ce8E50Dc8FK/n8L0ybNoDvaa9UMmtYMyNjhou2JrWk1q7yKHK0I7
	 hfuf7xT+zAeUw4v7nWnKvGWtnlifU6i4ZBLPc3BxcaQx97BrYf3Tv3sbhzjJj5gYVsp4K
	 Q+C8Kths0jL8YpX/l+70XVEeGQjkaAKTE7f7jFfYazghFfL8lDzm59T8zKJ8jROA8ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316029;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HVSNRzFk8GeHPUsNSFfGb+dd8MKCJFb/YLMHQX/ghU8=;
	b=Ao3dwZjpkoYG6NZs6/4KKsfV+tAOyAH6jAzQCwu2QTpK0NsXwDpXcDbUKb8JZ6/F60ZZ
	 K0VdoXrmFXZX5zy/Q5aLbDInnETauTaG2ljroChjg/d6LvHzXHL0QLNEqZUnOinHVUI2g
	 VcftdRDSouYl+zuLRJA47MrbNIl/ay6QfVFNziOiW8eMMJ6gU/O11G9Z3UY/cGp3xuMkY
	 TN7h5UJulASQ/IyeiWodLp7TePCBcXVfz1FptaVFweKWWWo0YWLYGnJRT97aVPzkaJShf
	 eOcbJV8I30RAOace+jfYBg3lYXVv3utFXsmDCxl4hgQd0Q3RegJRh2KwkexzgMVMV4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4ccXsi+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D2606BFDF;
	Tue, 10 Nov 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4ccXsi+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA661F008A1;
	Tue, 10 Nov 2026 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316028;
	bh=HVSNRzFk8GeHPUsNSFfGb+dd8MKCJFb/YLMHQX/ghU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B4ccXsi+0OqwC7LPH24kUcu4Zpl+leEU4W9VZgyddvZCP0ToJDCowqGy1UBGWwYJo
	 DGsyzRctDCJM6JGYMXV8aAtvTDK3AM7nMLvDQYLyWTqfmjd+URjusqUkcZ7VkRIzNX
	 9fSlEC91bIL5jm4k2UWIGHO1tQi25mQB97dK3e3/lR0vNQCHsdwiiLG4n+f6Fsvr+f
	 AiwF8iO+yZpTZ+dABRhWUjseftBd3ABRVw4oAVZIuPZ2IvRAzhMMd9x+bl9SjshMNG
	 jgqRy17rBLyk6irEIuPT0fOMls/27xOwOJtuOqDpEcG0ABZMBxbaK4DHr3lOYFSsRR
	 wJuVv/PQHTWHA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQlZ4-0000000AxnY-146Y;
	Tue, 10 Nov 2026 14:07:06 +0100
Date: Tue, 10 Nov 2026 14:07:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] i2c: dev: clean up registration
Message-ID: <avMW-hz61zXUbQWV@hovoldconsulting.com>
References: <20260827102043.673273-1-johan@kernel.org>
 <20260827102043.673273-4-johan@kernel.org>
 <avMFCwqx2X6pl4hP@shikoro>
 <avMRNeDGriRh6D1N@hovoldconsulting.com>
 <r7a57zw5h253lhdecxdoagdcok4lobodiouutxxq3t237imdhy@n4t46uvgvf22>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r7a57zw5h253lhdecxdoagdcok4lobodiouutxxq3t237imdhy@n4t46uvgvf22>

On Tue, Nov 10, 2026 at 01:54:18PM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 10, 2026 at 01:42:29PM +0100, Johan Hovold wrote:

> > I had rejected that Sashiko finding as being too outlandish for us to
> > have to worry about. As I just in a reply to Bartosz:
> > 
> > 	If a malicious actor has physical access to the machine, we have
> > 	bigger problems than worrying about them going out of their way
> > 	to cause a USB hub worker thread to hang. :)
> > 
> > Limiting the critical section can possibly be done as a follow-up, but
> > it may not even be worth the effort doing that.
> >
> 
> Why is limiting the scope of the semaphore such a big deal though? It's
> not a big change, literally just use scoped_guard() instead. Why would
> we commit incorrect code if we can correct it in a v3 with not much
> effort? You're fixing a use-case where user-space can hang a kernel
> thread, why not do it for corner-cases too?

A *malicious* actor with physical access (and CAP_SYS_PTRACE) can cause
a thread to hang while janking out an USB attached I2C adapter out a of
machine if they try really hard. Don't you see how silly that is?

I posted this patch months ago, but IIRC it will complicate things
somewhat without any relevant benefit. Probably just a larger diff which
is unnecessary for a patch marked for stable.

If Wolfram insists, I can revisit this, but I don't think it's needed.

Johan
