Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF62F12AB;
	Thu, 22 Jan 2026 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087649; cv=none; b=I0AWgeM+Xzh9yJbOXqnJ18OaFmg0WdFpbYCx8WgmYJjIXgZUwnrO++7MOFmmjgwbOYXHJGIbFDVmikceAQkrDclaPyKl1Hm8dvSUDV2c6nB6ZSDh6CkOE8ZKODXsuA6TAOJPKdK9U+hWN2y94+sq9bVpNZkTCDuRa0VQZsIY68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087649; c=relaxed/simple;
	bh=8k1LjBvIpqNRmEfQAczgAJsNgpdot1XoDuz+xT21Yds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F580dxgNy2dJ7zcvxndGjQhFDos0tv7sxEn1mnCMSN7+TyZMITtzcZAvsvs8wG7OsKEcpLpAJq+3sgmO/ORs0rksWTD9cm5s9yrb6tnRzEKMM7EbX0tONOVp5e51VfI/YgM4j4OF6EOEtwhoX0D16CtXXheu/xsW2IVDcOV6adY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgI+oYGs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgI+oYGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4094FC116C6;
	Thu, 22 Jan 2026 13:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769087648;
	bh=8k1LjBvIpqNRmEfQAczgAJsNgpdot1XoDuz+xT21Yds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LgI+oYGs6Dck1/OLZZkU2DIAZ4zRqoTrAfPbF7BBUUO5UtqZM4MyhF7CTXnLJvjpd
	 DHWxFPeCbwjVU+ZxVBtfn1jiBTINl6wZ2JYkjQp84NJX1gC/aaKaUJqLY3Gl/xWlf9
	 ZN/LCFzsvjHUBddA3YZw5eftLUzx7S8wa9BU0nU1O9HxvCPO9nDVf6Wkl5guxjjxgf
	 y29oooCoRJE4oRunmLCn8SydxRnVn6IeQyl1bYDv4tbLkgcKZKBI2uPtcXaxZgIV+D
	 08gitftdapP3icfelqKmZCPKvFK9E6JfWBwPvWysLY5T9YKIS422QODo6uXRJnPBD6
	 sVPo6vwS9SR1Q==
Date: Thu, 22 Jan 2026 14:14:05 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Alex Elder <elder@riscstar.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH] i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request
Message-ID: <aXIih2q2lWw2wK6Y@zenone.zhora.eu>
References: <20260122-05-k1-i2c-irq-v1-1-9b8d94bbcd22@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-05-k1-i2c-irq-v1-1-9b8d94bbcd22@kernel.org>

Hi Yixun,

On Thu, Jan 22, 2026 at 07:52:00AM +0800, Yixun Lan wrote:
> In commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT without a
> threaded handler")[1], it will check IRQF_ONESHOT flag in IRQ request,
> and gives a warning if there is no threaded handler. Drop this flag to
> fix this warning.
> 
> Link: https://lore.kernel.org/r/20260112134013.eQWyReHR@linutronix.de/ [1]
> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
> Signed-off-by: Yixun Lan <dlan@kernel.org>

merged to i2c/i2c-host-fixes.

Thanks,
Andi
