Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B83361657;
	Thu, 20 Aug 2026 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254017; cv=none; b=TZS3RBWP5kfWz2jrYa7Z0n/MFWOQyFJTk2jFDDLlhytOpPcABKVY4g1nVhyBeFOKSrrsZHBPgDUwRK1GpNEtocGLfddRfHYxeFBs4SXmsPYJhYMk+aJs3SQ+BMDMks8ZiIo51PxwbWeg1GGRbtdKHrJCVOpU1DqikxRgdSphxi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254017; c=relaxed/simple;
	bh=uucTC63SAPkuR0I+4A6ySIMR6YWXwsS1kWEnRLKxcNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKDZjG25mJaSbScgyVLs0wwf4LCqcYAPvjUQDDadE8eJSeHvipHMp4PIEz484o3MZ31ByG9ualav+95YTBdpoWk+gT+NlhdzIEwzJP5JJuWlz57QgbqZtgRUpdKsIbK2AJvau025E73/Y9Hui1mbP452TQehh+K3rAYX24wvy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8GMc1s1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8GMc1s1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777911F000E9;
	Thu, 20 Aug 2026 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254016;
	bh=r6MalnLPoqoCIrdRy6yIbZbwJv7MpxxIyN+87LgvivU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H8GMc1s1L/yjUGahP4znIPORR5qA8/zz/4Nrg20W+TwqWtosmaW1cfLp7IldGR1oL
	 C6wIYBT9N35Ah1lykYIw1VmB7eemNgAhOKIOjNgrYQyL8SukJ6vxUVGeeb5Y0yKfxX
	 u4LunAlApLbetSr+PZoPrHx53GQcGi/MUcypEG88MXqpw1ECNHQj7Xhq38CtK6wxN2
	 DgoCLee1My2UT+B1lGBAuIe3zqWQ+jnjwwH40NdN/YGuWplhnvnXhAeIx9jZdDw6ph
	 SWcbW7StHfoxBNl9uyG1y8OR+cDrWEPcNDg5LNIBrQJ5m1ga9BelYmZ9wWSdZNy4L/
	 K4jAF7Lw8r2FQ==
Date: Thu, 20 Aug 2026 21:26:52 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Igor Korotin <igor.korotin@linux.dev>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [GIT PULL] rust-i2c-next for 7.3
Message-ID: <aodUPU8RGR1ZJlQm@zenone.zhora.eu>
References: <178717488339.2840.16053648973983973210@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178717488339.2840.16053648973983973210@linux.dev>

Hi Igor,

On Wed, Aug 19, 2026 at 10:28:03PM +0100, Igor Korotin wrote:
> Hi Andi,
> 
> First pull request from the rust-i2c tree for you.

Thanks for your pull request, but...

> Thank you.
> 
> Igor
> 
> The following changes since commit 527dd7fb6209857f8ff4426055b3a418e60faa8b:
> 
>   Merge branch 'i2c/i2c' into i2c/i2c-next (2026-07-29 23:40:39 +0200)

... do you mind rebasing on top of i2c/i2c rather than
i2c/i2c-next? The latter is my testing branch for both fixes and
merge window patches. While i2c/i2c is the branch where I pile up
patches for Linus.

Otherwise I would need to cherry-pick.

Sorry, I should have specified that in my kernel.org info page. I
will do it after the merge window.

Thanks,
Andi

> are available in the Git repository at:
> 
>   https://github.com/ikrtn/linux.git tags/rust-i2c-for-7.3
> 
> for you to fetch changes up to 61ddec70c9bcc3d4b0471c8683e57d3b03cecf0a:
> 
>   i2c: rust: mark I2cAdapter methods as inline (2026-08-09 12:04:34 +0100)
> 
> ----------------------------------------------------------------
> i2c: rust: mark I2cAdapter methods as inline
> 
> A single cleanup for the Rust I2C abstractions, targeting 7.3.
> 
> `I2cAdapter::get`, `inc_ref`, and `dec_ref` are trivial wrappers around
> `i2c_get_adapter`/`i2c_put_adapter` and were showing up as their own
> symbols in the build. Mark them `#[inline]` so they get folded into
> their callers instead.
> 
> Signed-off-by: Igor Korotin <igor.korotin@linux.dev>
> 
> ----------------------------------------------------------------
> Nicolás Antinori (1):
>       i2c: rust: mark I2cAdapter methods as inline
> 
>  rust/kernel/i2c.rs | 3 +++
>  1 file changed, 3 insertions(+)
