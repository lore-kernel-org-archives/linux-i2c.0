Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D23BB4A;
	Tue, 18 Aug 2026 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048199; cv=none; b=fwHdMIGEHQMmiyc/qE4nrN5B6APfxzTF9cW6WWVrF6AxiUk0R9x1p2lp55w1U3SPJANZ9bLvpQJsvbbrLm4ji2GX5LU02iW5nzFt62xQkdG+Q7Yecxo6ccQLbz4crteTIVnNAz4lBop99pRYf6CbbOcjVUnnC+AMB96n/3nbFWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048199; c=relaxed/simple;
	bh=ktLWHrLQABTN8G7qMbVja7IOv53BDqLu8I/Z6XlF6ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p27X9F2iny/yGR7dpj63eN6T94CpBUg5zWtxKQsYKdfyV/oQA24wE2AHDziMqC8yljLV0XNBpe3GX1Y+OrzMUVSYrv6QIjIiRwrnk0mN6NZqKzshHCxrDQaEVD2zQ0PLfbN9yhoGLftW8gb63RAFHUAYCIzOC/I/3LfGcWwgDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/b0NZou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/b0NZou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1291F00A3D;
	Tue, 18 Aug 2026 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787048197;
	bh=d0GfEC89nlBesL8oKStTldMrIaIxQUV0w+3dHJkeydE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C/b0NZouvhaVMBM6NorRvRcvDIJBqEEXkh8FD3qT5jw/aeQpXnKDgENAGmriMKysc
	 4uPCYLomBkF5fDId4rrO1yYJ9V5qCOvNoiuobzYuu72Gvcap87C5KEZRVMOtq3THl9
	 zFC0cMHPp4ENF/rweYwjTxCu3eT8Gt3YOoTQlkCm8J0BKeRAsbaJGl6v7Uutf6vnr8
	 lE0V+S6np4Ba+6eJsIMbpqVOgZLWRf++YK8j1/qa0hqxIDVN44fPFXu52CMs6sXAlu
	 NelmCXZ+atH75xrWvU1Hn5o0aAQ4vgbNPnl4GSmt6Xv5gdMbVAcDq68U9eKyIq9Eug
	 tiBfyfStmuAxQ==
Date: Tue, 18 Aug 2026 12:16:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: xiic: restore runtime PM teardown in remove to
 fix clk WARN flood
Message-ID: <aoQwxxaPSjWD8Zyd@zenone.zhora.eu>
References: <20260814-i2c-xiic-restore-runtime-pm-teardown-v2-1-7ae5d0c30ff2@nexthop.ai>
 <aoHf6UDxD68YxLYm@zenone.zhora.eu>
 <DKQN4CNOESWV.2XRL8DIC87HYA@nexthop.ai>
 <aoNdskB_y8mOj5qr@zenone.zhora.eu>
 <DKRWHA3VO9S8.3QNFPU0732I1W@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DKRWHA3VO9S8.3QNFPU0732I1W@nexthop.ai>

Hi Abdurraham,

On Tue, Aug 18, 2026 at 12:44:27AM -0700, Abdurrahman Hussain wrote:
> On Mon Aug 17, 2026 at 12:20 PM PDT, Andi Shyti wrote:
> > A solution would be to drop the managed runtime-PM helper and
> > restore the non managed runtime PM setup and teardown. Otherwise,
> > this ordering issue needs to be addressed in the runtime-PM/clock
> > framework.
> >
> > Does that work?
> >
> > Andi
> 
> Agreed — that's cleaner than special-casing the ordering. v3 drops
> devm_pm_runtime_set_active_enabled() and restores the non-managed
> setup/teardown.
> 
> Let me try it on hardware before sending v3.

Please, also write a nice comment explaining why we won't use the
non managed runtime PM, I don't want to receive in the future a
patch adding the managed runtime PM.

Thanks,
Andi
