Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6B23A561;
	Mon, 17 Aug 2026 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994416; cv=none; b=rTqKQ6880FoTyYjs875Jx9+nJ6F7TnPOK+FbGb9E7KW7PnMZjGUSpC+clYVtU57MApvAzjAXSc321rXWJrVXjlwpzVU/HzXyeyGmgysEfek4SM/I7hdpaa4bwp6vmg5qRo7VawrXx2w4yMvvFTI6p8fN5tGZBaLafSXwoIUc45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994416; c=relaxed/simple;
	bh=otq/CC1DyvdZa7JIbM54hbbsu4n9bJdowBwJvC2uXYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyuHitSw/XYCj93yIFXkC8U9q7Li4dTNeVZWAqD3UFNO6nfymRAeM89mHnSn56oN9qK1i6dZsLFpT6S3NMlo40wknxnlMFBT7DV1ufUQPhzQuwX6HsVkIZYcLZLOOtbmZfyjj3hmVyXuLvyVA4ob0T9RZ3CKt2N+F/IJknvs2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpDMikdx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpDMikdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091221F000E9;
	Mon, 17 Aug 2026 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786994414;
	bh=qj1LpBLHaPSKpBBQikx2X5MWB+eO+B4IPml/AHn48RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QpDMikdxPODQRdzqbNH1qCaPrpy3zSeaUC8wDRyuxujKTmdbnguxSNFyvijWJwZ9L
	 /UieoRZhAI9/4/xAXALDev67NgIXWwSqAKnX2YQRV0BHO71cPtUD2Bhyj4jaiFqoj5
	 sTn8zH8HmCvyhTz+aGsy+dhQQRgcq23CIRLkOU5oBIL+etqg5TfMGPNBCDxkLsax7W
	 91g4Fycr+zFyL+gxK4POUtoXznqlmYNhYw1bH6S22i7wlFg6sHfimpJYD7rcMcW6Uu
	 yQ5PrYcwTvTaVr8cvn0zLl43v0ZG9xjJspc44odGIw5daBR2/X8HLl53l7iZp1IO0+
	 06yZZUkSittsQ==
Date: Mon, 17 Aug 2026 21:20:11 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: xiic: restore runtime PM teardown in remove to
 fix clk WARN flood
Message-ID: <aoNdskB_y8mOj5qr@zenone.zhora.eu>
References: <20260814-i2c-xiic-restore-runtime-pm-teardown-v2-1-7ae5d0c30ff2@nexthop.ai>
 <aoHf6UDxD68YxLYm@zenone.zhora.eu>
 <DKQN4CNOESWV.2XRL8DIC87HYA@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKQN4CNOESWV.2XRL8DIC87HYA@nexthop.ai>

Hi Abdurraham,

> On Sun, Aug 16, 2026 at 06:14:08PM +0200, Andi Shyti wrote:
> > isn't devm_pm_runtime_set_active_enabled() calling
> > pm_runtime_disable() + pm_runtime_set_suspended() +
> > pm_runtime_dont_use_autosuspend() at teardown?
> 
> It does call all three, but the ordering defeats it, in two places:
> 
> 1. Within the helper's own release, pm_runtime_disable_action() calls
>    pm_runtime_dont_use_autosuspend() *before* pm_runtime_disable() --
>    i.e. while runtime PM is still enabled.
> 
> 2. devres is LIFO, and devm_clk_get_enabled() is registered before
>    devm_pm_runtime_set_active_enabled() in probe(), so the clock's
>    clk_disable_unprepare() release runs *after* the runtime-PM releases.
> 
> pm_runtime_put_sync() in remove() leaves the device RPM_ACTIVE with the
> autosuspend timer armed: rpm_idle() falls through to
> rpm_suspend(RPM_AUTO), the delay hasn't expired, so it just re-arms the
> timer -- runtime_status stays ACTIVE and the clock stays enabled.
> 
> Then the devres teardown runs. pm_runtime_dont_use_autosuspend() clears
> use_autosuspend; update_autosuspend() takes the else branch and calls
> rpm_idle(RPM_AUTO), but now pm_runtime_autosuspend_expiration() returns
> 0, so rpm_suspend() no longer defers and suspends immediately --
> xiic_i2c_runtime_suspend() clk_disable()s the clock, all while runtime
> PM is still enabled. A moment later, further down the LIFO chain,
> devm_clk_get_enabled()'s release does clk_disable_unprepare() on the
> already-disabled clock and clk_core_disable() WARNs, once per device.
> 
> Calling pm_runtime_disable() in remove(), before any devres release
> runs, closes that window: with runtime PM disabled the helper's
> dont_use_autosuspend() can no longer trigger a suspend, so the clock
> stays enabled and the clk release balances it cleanly.
> 
> You're right that set_suspended() and dont_use_autosuspend() are then
> redundant with the helper -- pm_runtime_disable() is the only call that
> has to happen early. So for v3 I'll drop those two and keep just
> pm_runtime_disable() (with a short comment, and the full reasoning in
> the commit log). Does that work for you?

I understand the logic, but this still leaves runtime PM
unbalanced. The explicit pm_runtime_disable() is followed by the
managed cleanup calling pm_runtime_disable() again.

A solution would be to drop the managed runtime-PM helper and
restore the non managed runtime PM setup and teardown. Otherwise,
this ordering issue needs to be addressed in the runtime-PM/clock
framework.

Does that work?

Andi
