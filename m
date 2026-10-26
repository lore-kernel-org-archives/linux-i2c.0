Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036697;
	b=wVHpRgx5yHLOu9WEmuopAfefN2Inz3C+Od7LRKzeWuNHfjfjjdeklRVhlJo1ZFgi2Pie
	 shvCj1FuUmDji+CrFxHj7RX0M9AjQb8gjqqW7NwSl2FKVnuBOT7fHY9ITpChSoHo9q9uw
	 EdThzlDLMWz6ceb4uyJqXZdB1suCmxYkKTwnK8b+ngv8ekeJoOgPLfCHi6sBvZHH2crUI
	 MQcr7OByOCEAVHT1L9LaxUe4BXQWrohD5u8ZT0fA1HzpsI9+5zzYGoO8Ledv0g7Rl8oks
	 0vpEl7pjWiGQKrGkFZKjlvfhDJz8uH64FR1MTETgLJzhUvgisriLCCjsViu/r7rQhQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036697;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dvIv64xlhMmY+4XIQOBJlL8LlNwSU+nt+kUCyLgMH1Q=;
	b=mQVRGhgX5ayho3rkRoPppjsTm7TpcxMVaZfKVUTKLT04JtTFF/q+U2TjXB4ijYoHOmqL
	 LFlchtx7+J7B0dFYb8/AQp6S1R0PstGgOjF8gL7GWmXW8cg+uQwfrpywf4OBgS2FLW8kg
	 1b0cIjR0r2zkGrFFF/2uO5DboujzYP3+5LiPwC6h27MKf3zl8055md5is+q+dEHuPTiCF
	 7xbu/bi6e1ZfAFlwGA4pyKiSl2jN/+4uVjtAva5YGA3Ph8H5deCJWp3+xKhMLDPTpLl/Z
	 y0TMovkpqRbfohyO16I2sn3gO2uae15PWQO6WSZXTMZTYIqr/UoWDGzUx9BdqTh/zog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLnTZKLG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59928606A320;
	Mon, 26 Oct 2026 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLnTZKLG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DADC1F01825;
	Mon, 26 Oct 2026 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793036697;
	bh=dvIv64xlhMmY+4XIQOBJlL8LlNwSU+nt+kUCyLgMH1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fLnTZKLG4/yCNxKSZ+FOolgT8cUqE8frIhhAVSPn1w+eX0+lKKEu6MOd8whWoskkU
	 acOaLXb6I8Y/k0xDm6VZ8fWO5eXRS0Tdx57LmkaFQTRnvnKIkG4FI6i4+6+l+lxDSM
	 JbtFa4mXEtJqU6dGLvFZiCGnfjuOmFVWjHVKJ5s9T8iYsurTjzk8A0jMNx0iPE3VN4
	 p7wz9lmC9fMju/noY8kWbvdcMlKRSsgRmfrE/aSPh/OX0y5t8XlunAafvQZVXqqiw4
	 tm5wND71htKRW33/s6X8EzQP1F/5OcnCY3C4XUIL8HuHAxZ7DC218cNay7VarsY62H
	 ejR0fmWf4mT6g==
Date: Mon, 26 Oct 2026 18:44:53 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c for v7.4, part 2
Message-ID: <at-RVmsf9Tjs8LgQ@zenone.zhora.eu>
References: <at5i65e5wjMz2TCA@zenone.zhora.eu>
 <CAHk-=wiMOMfksBhvDa+huuNCAu_EfpxzLiSawNxdady0r=zFEg@mail.gmail.com>
 <at-MCkIj2_kLxgAY@zenone.zhora.eu>
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
In-Reply-To: <at-MCkIj2_kLxgAY@zenone.zhora.eu>

Hi Linus,

> Am I still missing something? Is there anything I can still do?
> 
> As for my mention of a possible third week and a part 3 (not this
> part 2 pull request!), I was simply trying to check whether that
> would be acceptable for trivial patches. I understand now that it
> definitely isn't.

sorry, I understood you were rejecting the pull request. We are
fully aligned.

Thanks,
Andi
