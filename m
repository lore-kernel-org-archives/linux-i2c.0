Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1E4756C6;
	Tue, 28 Jul 2026 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275122; cv=none; b=VLiDZdg2vbgx/WaVqVEy5l2A41mUsIN3HquKVu5uqjXPEARHkUIcOyKVxKzQi1NCAy+6qPbHQ0OjqgHePbJlDE5cNNlUkb+gA42yj5vEibzl1WYDyp0I8/PqXGwPjbvBHOKfLJo+ToKBptqrYkDE0tsZr7BliG2QJVXUxGED8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275122; c=relaxed/simple;
	bh=h1zCt8EHcisfLKYfK9WwKSYzcS6M2hNq6PRLOlsHJV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn07Ma0zYNT7O4TCbtuC4NgUlGQ1dQY5hl6PK2oVGiTT61eSa8WgIyxpB5XWmhundqjz2ba+GYgxaV+Sv9f8LPtP0vHsYIyOOYXh1pHZicrXjt5ORUUF03NiDxsQPzRchd6oidtjNLhpleYzDnGIlZ42Gpj6pEwI77mpKEgoJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD5knu49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD5knu49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C951F000E9;
	Tue, 28 Jul 2026 21:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785275118;
	bh=qNtDWY6Bt58ip+pEibT2pyM15K9fVpCH15MHNgCkPxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XD5knu49CrjuP1967HIlOcLrTKl/yND3EPRzmBQjO9ohELJwoe5PHmur5AAZhUFd0
	 2YdS0mltOaURbgkX7wGUmJJQZTCsydKl95yO6Rxb3SEL575JkB9oDAltcYRJHkdQTE
	 mi7Mn2/9iTpCdHLmV24HDOkUjkTFAxaFKDqKDzv7wDmXXgJ0eeMSvjIVVVPzDubBrl
	 +tUTD1bAv/sFep1bPe8H7mdG2ll5HnSE/bdjFTB6xkGuxekgLGATFEKOtAiWQpC5J0
	 zeMC7SJG55mQUQTpCwMbzI2OwZiPOWVSdGFJfuHyH7T6dfipvbLiOpodBzFXyNFZpg
	 U5+jLqwyjJRbw==
Date: Tue, 28 Jul 2026 23:45:13 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: qup: Propagate clock enable failures
Message-ID: <amkiyQln7g2y04JF@zenone.zhora.eu>
References: <20260624055237.29977-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624055237.29977-1-pengpeng@iscas.ac.cn>

Hi Pengpeng,

On Wed, Jun 24, 2026 at 01:52:37PM +0800, Pengpeng Hou wrote:
> The QUP I2C driver treats the core and iface clocks as required
> resources, but qup_i2c_enable_clocks() ignores clk_prepare_enable()
> failures.  Probe can then continue to register the I2C adapter, and
> runtime/system resume can return success, even when a required clock
> transition failed.
> 
> Make the helper return an error, unwind a partially enabled clock, and
> propagate failures from probe and resume paths.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

merged to i2c/i2c.

Thanks,
Andi
