Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA256E051;
	Thu, 15 Oct 2026 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096854; cv=none; b=kpboJ2at4AUPGY0iKBv5Cku529CJV/IKK1a1C72+j0MExYLVEqqh2jNTNM4rf/q1PIBZ/aykKy9UkLtWcqCxkfU31KJ51oCvHBCEZ0PEowEAr1bkEu9JyJRt1rcWIuKCj8TBYu8mu4SMo81T9oFdR6BKQD0g9MYcSKC/g4eOZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096854; c=relaxed/simple;
	bh=awhRxtTb59uFrw9BcmOadR/YY1+NLLAGsGfYTgdJp4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbNZiZ19DKK/p67fqjEUJ93vlYihNqeQam8Bvov7ZPaOfKC46vlTNfKx727PVqQTD3CgnESOmkkagNjyFf7bSLf49hXX31MkVCmg5Ndf9M5LTc2jLPYs4Lry4VSlSPCyr1LuEfIyEYIecYCmVUTt3KGLqyiM0Q44UVrsvQN8QaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeSobAKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeSobAKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721E81F000C4;
	Thu, 15 Oct 2026 20:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792096850;
	bh=awhRxtTb59uFrw9BcmOadR/YY1+NLLAGsGfYTgdJp4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FeSobAKIBHtsxNGahwJm3YVst3IQFjTWGtlNOyojnC4A4Fp4N4J5cTYEiE1h91DaU
	 OsaDc+zbFhl+6ZKDHlpSyTfUrqBj89vMq9bAvgY+CIjVg9cn7ZRTLpdOm99Hqi55Mj
	 VzT5lUBy2+PqY29fF3sPnlIwL+ZBRctYw7Nx/SGjpn98ZffztBF7d+0/8gK5219gZ/
	 oXzlXZFgxGnuCN/foPqyif7We/eTR+W8T2+byTpzDTQ0YbXJM9v9P6oFh30lKdf9eB
	 3fNb3ka6aDBRjT65LsFNLQ6GjScvxyD33SyucdF4Led0g8s5ERzpPhyMyVh25vdzZT
	 Vt46uaxBjk45w==
Date: Thu, 15 Oct 2026 22:40:46 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
Message-ID: <atE6LA8SFpFvZfzZ@zenone.zhora.eu>
References: <20261014-i2c-xiic-restore-runtime-pm-teardown-v8-1-40668c270069@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-i2c-xiic-restore-runtime-pm-teardown-v8-1-40668c270069@nexthop.ai>

Hi Abdurrahman,

On Wed, Oct 14, 2026 at 04:56:55PM -0700, Abdurrahman Hussain wrote:
> The devres conversion replaced manual pm_runtime_enable()/disable() with
> devm_pm_runtime_set_active_enabled() and dropped the remove-time runtime
> PM teardown. The managed release tears runtime PM down in the wrong
> order: it calls pm_runtime_dont_use_autosuspend() before
> pm_runtime_disable(), i.e. while runtime PM is still enabled, and devres
> is LIFO so the devm_clk_get_enabled() release runs afterwards.

...

> Fixes: 50c63491ff26 ("i2c: xiic: switch to devres managed APIs")
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

pushed to i2c/i2c-fixes.

Thanks,
Andi
