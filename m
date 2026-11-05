Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866690;
	b=Zle0NY9mUdBUUn+EZvXnP0zPygVr5UZPFzEJBvyL+Ez6tWsOwgGAZfVmgNw4PQHHc0qz
	 q1+Cxm7hie8aQbJZgYwJ2wOU7NXZKESrnKZ3AI2X4kmAK6QQPkxk6cCnbOD3SQ3abrVCN
	 CQsKSqcFmR+gaHC5BoDwOAVOexymqldpgP8lPiDug0qna8qAYtoc1M/tDNI2ST6IDxF/M
	 Iw6MR6ilKIaF9OrVhSTWRlIiJDKFHmjrSE4tMuHwnujsdFgiAgVuU75fZMcfDo07VrdNs
	 W02eHBWNNmYKWOQZFTwfP6t7tmwHdHLki40Bz8VzPyGsSicJWukxkNjFG8n0ACF2uwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866690;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xDatfRtNfh1TDdc7KvfXGNhelms+CveZOrg3U57qlTg=;
	b=zc2hRXyQFVT/Xqa4dIpMCBduM8rANerRd/A/gRC9UbeBldc4USfJCZd1fExGUy6UIGwf
	 6RmTwY5nl+dXyhxFRYyRtY25nZW0L2p7x8+MkJJps+O1Oun3aSIJ2IO+UJ6Ad9MKI8DpL
	 GMyhEE1JBrijUW6ykNGjF1QU21u6aganFuyCSzssYPNSRYzVZyBoLiJwvH0iiXcTCgscp
	 kVyJhDMVrs/68dqi0hP/Mi76DxBLAOR9vDlLRoMXyi7AwwK3UkntAViQK7kPYhYzVB9lf
	 vAwg0g5RxhwG1EB96KwjK8sxoRde48KW61ro+ZTcyDMwNk8wPqKzTrqMt4FdXZZuAag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nied4DBC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6519B606D826;
	Thu,  5 Nov 2026 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nied4DBC
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 34F6E1F00919;
	Thu,  5 Nov 2026 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793866690;
	bh=xDatfRtNfh1TDdc7KvfXGNhelms+CveZOrg3U57qlTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nied4DBCw1LkckRtq8aBj/MSoTUHy574BRlbTIOXwBHf6jUK27eJ4Hm48oh7Wv1SJ
	 +rR1qeVVGbIr+s55t5UOeOR0MR+d4SWKLEx2EC70qUjf5928ltXFh+lMrX2z9LSvxJ
	 bgrugvkVcMwbrB4AA7jjBXmCdYzlKQOgy4HrqvE90t/igVomZM/DmVw5ik8FdMtnTJ
	 BolRMyqZcIht3mqjML/mgW79wyuzfQiP3zsggOQ4TCuL8oVJHllvQqad/Rd8awSuPA
	 2PV1EoP+1yPLUK5h/xkXj8XuXIDNGVduI8aPcYoIjJ1OsyFllKQEJ7V0dbOdSgZxrI
	 3UMm/mQXPGvlA==
Date: Thu, 5 Nov 2026 09:18:06 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Johan Hovold <johan@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] i2c: dev: fix blocked adapter deregistration
Message-ID: <xg2prxfpalzclup5g6xsk5jewver7edofi7z52s4lkobesvhnp@w7yl6ozxz7iq>
References: <20260827102043.673273-1-johan@kernel.org>
 <auuKuSVcFC6lVgGU@shikoro>
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
In-Reply-To: <auuKuSVcFC6lVgGU@shikoro>

On Wed, Nov 04, 2026 at 09:42:49PM +0200, Wolfram Sang wrote:
> On Thu, Aug 27, 2026 at 12:20:40PM +0200, Johan Hovold wrote:
> > As part of addressing I2C lifetime issues, this series fixes an issue
> > which may actually matter to some people, at least if they are playing
> > around with USB attached I2C controllers, and whose fix does not depend
> > on any larger rework.
> >   
> > This could possibly go into 7.3, but can also wait for 7.4 as the
> > impact of the issue (both in terms of number of affected users and
> > symptoms) should be limited.
> 
> Oh wow, I completely missed this for some reason :( Just discovered it
> while digging around in patchwork.
> 
> I will try to find some time soon, so we can have it at least in 7.5.
> 
> Adding Bart to CC, maybe he is interested.
> 

Yeah, I didn't see it either. And yes, I'm obviously interested, this
has been my pet-peeve for years. :)

I'm adding this to my TODO list for today.

Bart
