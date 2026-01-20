Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034814F70;
	Tue, 20 Jan 2026 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917334; cv=none; b=E/btaAbVOEtbP8+t0ivpNlBIR0vtVrYrVYpClxy9/myEbDoR6C1EH0QALFFXHEuRYce+lYfIszUu61kDD87bCPmJ7rMZiDQL16lQOO4oA5y7lZfBCFmgefz9eDyPnKSde5YfgjaZBZsLGRp1czpeyJbTV3yRPbd+LRd+B4tfhYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917334; c=relaxed/simple;
	bh=OgJDwEQTz8VFXH0/BCxXN+NuMKFqoKOXGRAjbzSp/A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/lbpBFsqmKAALGDoADOB835pHOFv82m/Yli4wwEtLN9QwKKGBVq7u+3Tk0o0C8BxlEPMG/lqaevYnqA4XnYJlVuMYB7R5N5aiISioRoesTIPI58/dr2LkITOpOt/ZYHdfLAkwWZt01T43YnwgKxelxuDxWyHOUZGrveI6seIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+gzPxeU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+gzPxeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4BFC16AAE;
	Tue, 20 Jan 2026 13:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768917334;
	bh=OgJDwEQTz8VFXH0/BCxXN+NuMKFqoKOXGRAjbzSp/A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+gzPxeU59xJ6BjmobZnsg94Wa9y3Sli63sE//CjdKK0+Y15FnLG6tns/4MNCT+GS
	 8H24NRpMxPvu9Y7JY7VMaPLSsOleRAkbHFrzPg7VUuKnW8XdJNMU+wkSypIyecDQ9l
	 Q8KbuE8l6fC9HKCRPqwiTSj3S+5vQgN0jnRXCYD2duQ9ozuXwOUFuB0Tv1owh2sQ20
	 9zt6ntGLg9MmaoZWXUC8AkCP7YKgtb1Uiu7ESDWlcb2wNhkc+TeXbFHTM9knsDlWqm
	 HTa2hBl9rfA6NtHMLDqHmZ0lbbIQKakoMEt+k7lekJgfAsIOt8BEtAFaKIx+0vRfzW
	 MvUmwT0nckqLQ==
Date: Tue, 20 Jan 2026 14:55:29 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: p.zabel@pengutronix.de, andriy.shevchenko@linux.intel.com, 
	jsd@semihalf.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mika.westerberg@linux.intel.com
Subject: Re: [PATCH v4] i2c: designware-platdrv: simplify reset control and
 error handling
Message-ID: <aW-IlK4GXnJlVxpB@zenone.zhora.eu>
References: <743a73399327e0f11825b1b50b4a0fc90948625d.camel@pengutronix.de>
 <20251111145536.3232456-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111145536.3232456-1-a.shimko.dev@gmail.com>

Hi Artem,

I'm sorry, but in one thread there are three versions and I don't
really know what you are addressing. May I ask you to resend it
without linking it to any thread (please don't use in-reply-to).

On Tue, Nov 11, 2025 at 05:55:36PM +0300, Artem Shimko wrote:
> The current implementation uses separate calls to acquire and deassert
> reset control, requiring manual error handling for the deassertion
> operation. This can be simplified using the dedicated devm function that
> combines both operations.
> 
> Replace devm_reset_control_get_optional_exclusive() with
> devm_reset_control_get_optional_exclusive_deasserted(), which handles both
> reset acquisition and deassertion in a single call as well as
> reset_control_put() which is called automatically on driver detach. This
> eliminates the need for explicit deassertion and its associated error
> checking while maintaining the same functional behavior through automatic
> resource management.
> 
> As part of this cleanup, streamline the error handling by removing goto
> exit_reset and goto exit_probe labels, using direct returns with
> dev_err_probe() for cleaner and more linear code flow.

Can you please put this part in a separate patch? They are
logically unrelated.

Thanks,
Andi
