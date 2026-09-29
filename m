Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40234E3EEE;
	Tue, 29 Sep 2026 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721970; cv=none; b=ruhwV4PGO5xcelBVRo4z0Gl17d7cE2la405N80mu80rqERLz768XeZQLl6b+6ZDstukwA7n0xPUKfwYuaK6PaxAAwRzWWdeYqwRyY9FHwov6NSrFMU5Qte+gnNOchPcoMcY7t7QaSZ+UsK/ilNSeCt7YIzfhOagC5uQ7SduvFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721970; c=relaxed/simple;
	bh=KfKqXejq9BL7bFwdM6jX4EMAcDS0vT8EMdRED+8WjeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY5j1Orxc1LxIIcZ6B3CCdcBoPTl/+NNY8DOlgGcv4Kr/3ZgSYk38eHBBy0cKUkO64Pxx4QMa8ec7qLybaIhok+xcc5CKOaonpyT7+uXIqAKe3XFJBRuzxpXo2mn0NU29F2eE4fqyB+01F+O61bsF7SLdeaA4M/LUFuqfIJ4yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahTVzLST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahTVzLST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FAA1F000FF;
	Tue, 29 Sep 2026 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790721969;
	bh=fqVl/uq8tQd+R/oqQRK/fqdIcHIo5NO0VtwrM7Y7zY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ahTVzLSTS0PIiYm6uyB+3jRB6/imGmPuQwH3c10YUT+UoT1nx279WQlQB8kT8r8rd
	 V0kJFjtnVHhDLsKg7pj8a1sNfaqp6obwUvGenRfd0JO/Lmj5ntc55ZGNuvhDEfiAtt
	 ZwFrSnlzxLnoS5OsWySwpyWhtW/stCczPaqGd1xrQT4LolaxXQz6L6G64REB4EvY8u
	 gEoX4ITfyLRVBk8VAYoTmuPjbZ+jPhXhgksPW2i94gnsijzqvg0NMePDiqoRDzCZBm
	 SW/Vy0iWM5xW8N3TSpU/gxAY5D+d19wWHGfa5FtXdc51rIIYtcOmlBHL1izmbPbnN4
	 9ydHQuByKBvOA==
Date: Wed, 30 Sep 2026 00:46:05 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Bryam Vargas <hexlabsecurity@proton.me>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: smbus: make i2c_smbus_read_block_data() safer
Message-ID: <arw_B361gICP8I8H@zenone.zhora.eu>
References: <ammWUROtUGeriY8G@google.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ammWUROtUGeriY8G@google.com>

Hi Dmitry,

On Tue, Jul 28, 2026 at 11:00:23PM -0700, Dmitry Torokhov wrote:
> i2c_smbus_read_block_data() is dangerous to use because it may deliver
> up to I2C_SMBUS_BLOCK_MAX (32) bytes, which may be surprising to the
> caller. Callers tend to allocate buffers of sizes big enough to hold
> data from a well-behaving device and do not expect that
> i2c_smbus_read_block_data() may attempt to write more data than
> expected.
> 
> To make i2c_smbus_read_block_data() safer to use, change it so that
> it accepts size of the supplied buffer as another argument and ensure
> that it will not copy more data than the size of the buffer. Signal
> oversized responses with -EMSGSIZE.
> 
> To allow users to gradually transition to the new API employ some
> macro trickery allowing calling i2c_smbus_read_block_data() with either
> 3 or 4 arguments. When called with 3 arguments it is assumed that
> the buffer size is I2C_SMBUS_BLOCK_MAX bytes. Once everyone is
> transitioned to the 4 argument form the macros should be removed.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Sorry for the long wait. I pushed this change to i2c/i2c.

Thanks,
Andi
