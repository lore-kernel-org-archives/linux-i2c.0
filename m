Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036526;
	b=z/qemG8/ccI+o+cKHmCRcXfwGt0ktKnVDEKWpS0FTeARRYcpq/bHIbgrl1Yk4sgv6KVP
	 bqhOFm/iW1MH5IAoQfP4NWO3j0hwv6LbNPhXeZGt4y3jO4zxnz7riptbTbP17Zs7t596n
	 vEAUxWse9lXXBxib/5oPcUCqBhoKkp6ZaNyBtkZsvdh4kmLn4bnlHdDdMvJJKJ62+JVYo
	 QnLI4Pv4ieQRc2du/VBxyIoTV2ib/fDdW1ZReQqVNhLdv2RMV8PuYTq7Falh8e10stoN9
	 TTQL0xgDJIeuvK4gRSDBCXX4fFaubW5P6Qd7xfKVCk7hO/Aa1/KacuaTI0+UZBCep5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036526;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lW+60CqCGiKqWMT6sfEWNVQyKUdP03cTYPBnmO6VxcM=;
	b=yB45b21PwxWcj2KZWednbwCz8/1FD4biyIJzS12zVEX8pga1fLQ67xrbyXtzMRjVM5Ea
	 gL/tV3z/5CkUv9ptyDZWljkcZTcoSEnDytugIb74hPtrVlATjUdrXNLMi1KWa79apz7LC
	 /qvjH+gqrmZwDaquAPa15lCVPWvMPZC8cwXLOZ34CgW6hjPJj+ZksOCkEDKFay4Mv5q+T
	 ohCD8a+zqoFV+VDi02NlftCt++GYpRRUUw1PW5uFQggaXQ0xHGhNZ0bcQq0tq0z/Ro9JH
	 8KDIFcCzXXVlbihMvxhjYkBR/qAifPTIJybmUcqlYhLgxm3Y9zI8brhsw6oa/mwenSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnrfyN8M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D3606A31D;
	Mon, 26 Oct 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnrfyN8M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C7E1F01825;
	Mon, 26 Oct 2026 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793036525;
	bh=lW+60CqCGiKqWMT6sfEWNVQyKUdP03cTYPBnmO6VxcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KnrfyN8MnnCoHch+P1d7MsDaTfKoP0ANBI9ps/LwYtCyVPMWMjMHeP91vzXLGrIPN
	 JRkFWeMMRw19WmqbyMTQ+hcDMOcOTw7ZBZHBOnQrHNKbtSM38t42kti7qlJJUgZY8P
	 HUWw1O1bmg8tdamM27lyH4BCTecOYtKr/OcGqhqU2wzXXmIf/NqahVfWBGpB5D5Ap9
	 tFpytcqtu7Ef3Eqk9IMSX4lFluyotQl8xNDbGs6G2u04q7A9vuhh7bMwFrKu1OwR/O
	 +QhFMslIgKWlyfEwYsWt3IpX0pYeG+6KUnMDYuJZafKCkPq7YVla4/D44dgxBctcZ4
	 nHC7ulQX49WcA==
Date: Mon, 26 Oct 2026 18:42:01 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c for v7.4, part 2
Message-ID: <at-MCkIj2_kLxgAY@zenone.zhora.eu>
References: <at5i65e5wjMz2TCA@zenone.zhora.eu>
 <CAHk-=wiMOMfksBhvDa+huuNCAu_EfpxzLiSawNxdady0r=zFEg@mail.gmail.com>
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
In-Reply-To: <CAHk-=wiMOMfksBhvDa+huuNCAu_EfpxzLiSawNxdady0r=zFEg@mail.gmail.com>

On Mon, Oct 26, 2026 at 07:15:52AM -1000, Linus Torvalds wrote:
> On Sun, 25 Oct 2026 at 10:20, Andi Shyti <andi.shyti@kernel.org> wrote:
> >
> > I'll now start queuing patches for a possible third week of the
> > merge window. Otherwise, they will go into v7.5.
> 
> NO!
> 
> I've taken this.
> 
> But the whole "merge window is for new development" needs to stop. I
> will *NOT* be taking any more patches from you that aren't fixes.
> 
> The merge window is for merging stuff that is ready BEFORE THE MERGE
> WINDOW STARTED.
> 
> It's absolutely not for "let's add more to the pile". Never has been,
> and never will be.
> 
> The merge window is two weeks NOT as a way to give maintainers two
> weeks (and no, it won't be three weeks this time, I've been keeping
> up) to create new stuff. It's so that the stuff that *was* ready
> before the merge window can be merged in a sane and controlled manner.
> 
> So no. No more of this "I'll have a second - or third - pile of
> stuff". If it wasn't ready before, then it wasn't ready, and it goes
> into the *next* merge window.

OK, got it!

Just to clarify, most of the patches in this pull request are
fixes or patches that were taken well before the merge window but
had to wait for some dependencies to be resolved. They have also
been tested in my -next branch for several -rc cycles now.

Since the merge window opened, I've added only two patches that
are not strictly fixes[*]. One is a trivial fix that doesn't
deserve a Fixes: tag, while the other has been properly reviewed
and in my tree for almost a week.

So, apart from this last patch, which I could drop to be fully
compliant, I believe this pull request meets your requirements.

Am I still missing something? Is there anything I can still do?

As for my mention of a possible third week and a part 3 (not this
part 2 pull request!), I was simply trying to check whether that
would be acceptable for trivial patches. I understand now that it
definitely isn't.

Thanks,
Andi

[*] f7b70efba269 ("i2c: sh_mobile: request IRQs after mapping registers")
    c2867bb0fa1d ("i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART")
