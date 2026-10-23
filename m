Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773714;
	b=e3iG3s3Ye4bG0IkFHCen2PF/oFs4ssbAqeDRXdNczMgJZdIWRnEWHL3KdUorw/L+larG
	 ZNRnov10rZ2nzZfakrgG432exQESlI1ERP+EsD9wgx+6zNvDxd7EQxn5nwb3a/vHtUHMr
	 WDfaDAwAp/XcSM7JFeQLl1W0fHnlsAfiKjr5EqVHCw3DVT56ISxmlmj8ntH8dvPar7Aji
	 Egn12odQGc3hip2PW+POynqN0N1gEZ0sy+LZFffw0KryaMkKGc61ph2EPEGkWRToVUL75
	 FYhgPNEpLvcnW6j73bBaiJ0mQbiUKwKTrUtu7kavC6LwF/01IfnhQxc3ccIZUfUUm0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773714;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VnDYIIJpa8hOGMaysz7TE+GWovCxog753iYcM5WzKyo=;
	b=v3u+j5LEyJLBupMhdOPs66Jgm4fZWG6VZZLx2B8HDomwPu2rlHI5ctRnmMRACWQIxphg
	 lr8jcGVN13UHd7r8bm40hw1c6jdvgxwbO/5Dl3tVuL+PNrrR4pjolWPj4bB9wX5hlLy/O
	 NXpFnjd5dtYemOUV2c/ElP06LUmjVOh/gjcZzjdKLoV/ljUKp1h9+49kvlOXK9srVnC+6
	 Qp4sjYqZroPKLJcpFuZbFtDvxjps49uyrSHkq2oX+b2j4sS0pnrQSGgg45igVdHIMW3bi
	 gVRedc7iohNCupQpxw/PcQ1ARbNYpzGVbq9StpuOnuD5RPM+GIwLSa0W+T2E0NvSm/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQ31nQI2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5E606A31A;
	Fri, 23 Oct 2026 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQ31nQI2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FBB1F01825;
	Fri, 23 Oct 2026 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773714;
	bh=VnDYIIJpa8hOGMaysz7TE+GWovCxog753iYcM5WzKyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AQ31nQI20ChWjT0klhf0z2BvZ2hEYL3sSKZXMzP4rcTvAdUIrJ2aIMOsUlDL/WXio
	 rZRGXpm+aeML+UI+goJbYXDWx96t5Po0WtZKSr1QP1WEGA9DXVFf1N21sJe+JT4k3P
	 TGEYQaEM3I8rc2Hx1jPjWOU9W7DLcH4tS+VDQjIV2THxJ5X7yd6ZdqIWtssKiFpS/e
	 F3JJ0tUvhAozzT2qvO8ol/SDYBfC2lg3prbOh/6s0iZPF8v0QWulm5kTsmrYtvINzT
	 P8p+W47HaBdzA4HDY5OHknmwlsPYGppQy21s9aquz5nPeKFzXM/FyT2sJbnvCm3Ftw
	 GiPKDVN69TmmA==
Date: Fri, 23 Oct 2026 18:41:47 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Igor Korotin <igor.korotin@linux.dev>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?Q?Nicol=C3=A1s?= Antinori <nico.antinori.7@gmail.com>, Georgios Androutsopoulos <georgeandrout13@gmail.com>
Subject: Re: [GIT PULL] rust-i2c-next for 7.4
Message-ID: <atuOKm_Yj5JXsrb0@zenone.zhora.eu>
References: <179260155969.2966.15552703862037914616@linux.dev>
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
In-Reply-To: <179260155969.2966.15552703862037914616@linux.dev>

Hi Igor,

On Wed, Oct 21, 2026 at 05:52:39PM +0100, Igor Korotin wrote:
> Hi Andi,
> 
> One fix for this window -- a real use-after-free (KASAN-reported, GitHub
> issue linked below), not a cleanup.
> 
> Thanks
> Igor

merged.

Thanks,
Andi
