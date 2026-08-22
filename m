Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3125771;
	Sat, 22 Aug 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787401495; cv=none; b=DvItMiinEeJFjZBSYUD3SbkbaPyhdJGYtBQvVlNzK72V7J8z4DSKP4pJmQyefGLHfXPBooyAn+lmarDBe95xxHEVb/2iRZEs4JxHyYnDv+IfM+6t078qh7zD4EKTkq+7SGDKOOBvNgeo0Fnl0XKbN5BRn1U+cfehJ0j0En/G0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787401495; c=relaxed/simple;
	bh=AXf+u6yWYEyarvR0W5gm0K0yFy/tngJo1J0u/oOLvPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYpMXGgZ0vfGg9YjbS/8ZkGckVcVoiwCsETzAepwJVmCiM8QKX1qxGA3eSpYAgFEsqYJ8BfZUpOt6W2rlVM/ZlQ0spSApbYhrDXkkWaN23fMlc2/a6qvT7iD+QZ1g4R45vr3d+tHKDanZwr6OOu7pzzXmySzlG6+kiaBiPyP1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E22hb4iw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E22hb4iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB1C1F00A3A;
	Sat, 22 Aug 2026 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787401493;
	bh=pesUoZmqXlgW3G/LaVBq7JeB8v0G43omy8GYR73IFPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E22hb4iwb6lhFy5QcX3CU4OD+s9fcdXvP5layT8rDSKmOIrMH8YTdXLJYOF9q8Zxg
	 kqmgjHxC+geQaOOdArETZru6kNZfn6X5k4N6lxl+8yRp0B52QEj8yM9avQQIngi/kr
	 h6FnaCJLDwsXoRGLQIBT5taPaxyxFtkCce/oJJONKwnSFRNRVSlafpWSrpKDl4q6M7
	 VMcBdCAlkcKmFl7ff4URUFOMu8eVIPm0wRwMVPtmqX8It4Ib5B/Dhxqw7Z1Gec/fSH
	 e0ZWlCBhE43lqrhK/qOWgpVYdtmlqzTwjNUsH6F4Lay380O233TZP93Xfq0jybQnpK
	 NE4RaPYarbVhw==
Date: Sat, 22 Aug 2026 14:24:50 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Igor Korotin <igor.korotin@linux.dev>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [GIT PULL] rust-i2c-next for 7.3
Message-ID: <aomUXhYE0M37I-hI@zenone.zhora.eu>
References: <178717488339.2840.16053648973983973210@linux.dev>
 <aodUPU8RGR1ZJlQm@zenone.zhora.eu>
 <178739872719.9834.5401695033021882071@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178739872719.9834.5401695033021882071@linux.dev>

Hi Igor,

> No problem, rebased on i2c/i2c. Updated pull below.

Thank you!

> Thanks
> Igor
> 
> The following changes since commit 7a79b02dd1b09c235c3cf6075bccca2160d1b826:
> 
>   i2c: rcar: fix reset handling for Gen5 (2026-08-19 22:07:13 +0200)
> 
> are available in the Git repository at:
> 
>   https://github.com/ikrtn/linux.git tags/rust-i2c-for-7.3
> 
> for you to fetch changes up to b5fa55ad007059547c9139d4c4872e158ae255f2:
> 
>   i2c: rust: mark I2cAdapter methods as inline (2026-08-22 12:22:27 +0100)

merged to i2c/i2c.

Thanks,
Andi
