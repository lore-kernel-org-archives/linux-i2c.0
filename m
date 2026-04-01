Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C4F383C73
	for <linux-i2c@vger.kernel.org>; Wed,  1 Apr 2026 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775085875; cv=none; b=TlPMoYerqVebDZnZmTezMuQIam91TEGyMxuZaMfUYso1RPaW5v/0uaUhyAaxj1q9aWUrZrX6+/0Xj8fnHmhjEW8lXrjK5+bIXfwz+Jy8hHDSuLbQ5vDCFv7dQFFgvLvf9HYhPeJyWLDkx1FWSOj5asKvu0HGktTw+pye+Cn5ZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775085875; c=relaxed/simple;
	bh=UXiz2zZVclEdDKqq9cI8MNsK3QkvO/VIQMWP6DFzfMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqRHIJ8n5JuGgnybFGllvSpUP1ey6yg8zrJhdXLmlJqDTsuX4fVGMPqEhV0Rcp0syOUYgX9iu/PkJg5NQ37t/+TcBvjIdRz4PVQOynI163MrbkLe72yMdBXHX8uiWL06ADYAtvhR/Dfwy527UHeVZsIf2Kw7nzmtfsnMQ/6NvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdkknZ4K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdkknZ4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5E0C4CEF7;
	Wed,  1 Apr 2026 23:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775085875;
	bh=UXiz2zZVclEdDKqq9cI8MNsK3QkvO/VIQMWP6DFzfMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BdkknZ4K17L+tTwiqaRziwEYLfe0A2RqA9pDPf3HSGbQp9kiK9NOWPd0j4F8gz3xj
	 q+HxCh8375TTAIWKrHaPN9Z5yiQb8aXRa8+jVHOKr+2nCj9RjWgOOMWnEphPUTjaj4
	 umy6Pdd6p19KfXEbnO/+gLlmgKUehNio1nSU+lM8hlzd83a05bVYrIwLmkSew5aBk4
	 GbTHn4fOiBeDZblHUOhQAU9Z47ZCxCZL3YzUP6kjov9KUZ25gGcITnUi1MXoVfolL8
	 5bh7dceBsstIuD19F08b29YflXBmqBADBHDTPiMp8hmwWJ5q7NSGrcfvqpN/Iyr+IW
	 jskc3fIozi2lw==
Date: Thu, 2 Apr 2026 01:24:31 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Anthony Pighin <anthony.pighin@nokia.com>
Cc: linux-i2c@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH] i2c: imx: zero-initialize dma_slave_config for eDMA
Message-ID: <ac2pCemxk3ux4qfw@zenone.zhora.eu>
References: <20260331182632.888110-1-anthony.pighin@nokia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331182632.888110-1-anthony.pighin@nokia.com>

Hi Anthony,

On Tue, Mar 31, 2026 at 02:26:32PM -0400, Anthony Pighin wrote:
> commit 66d88e16f204 ("dmaengine: fsl-edma: read/write multiple registers
> in cyclic transactions") causes fsl_edma_fill_tcd() to read
> dst_port_window_size and src_port_window_size when building transfer
> control descriptors.
> 
> Initialize the structure so unset fields are explicitly zero.
> 
> Fixes: 66d88e16f204 ("dmaengine: fsl-edma: read/write multiple registers in cyclic transactions")
> 

Please, next time don't leave blank lines bestween tags.

> Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>

Merged to i2c/i2c-host-fixes.

Thanks,
Andi
