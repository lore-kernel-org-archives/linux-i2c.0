Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DAB1F936
	for <linux-i2c@vger.kernel.org>; Sun, 16 Aug 2026 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786911107; cv=none; b=Ij16B9gyHDqplj3x2GywHsSNu0nFxG8GntN+MDYGHuMZJcUWbGerLfGygQz9wMC+S5GV3I0+/Ty5dkCLBdqpD7ouOYTrrTgqHz3FrgFKdh10j93Iv1QOoS2ka80+SYFjHEBC0DTvHnJ7Q+Tl7Ah8w3mfVueUgictiW2ju68yEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786911107; c=relaxed/simple;
	bh=Sg53nkH4q7cToCkpJfYDTNUjE7Aztp+QBfGvkbAm+ME=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=sv/uJ7tjt5tnkr2AL9rB6roMnkKozwPV6qZ+1SGS/ruFL7tcf7RMFBncT8rUP7MVYYTZt0d26/ZIl39pnLckTqvTWzRbyDn0/vk7u3/C4Rcr0VMjhOVyWT7PSoRNFXL8RwzulXLwbgaSQelYypZ/OlV/3yox+KwSzNwPGSLs0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=Pp+iX3XX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="Pp+iX3XX"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf452def93so29217605ad.1
        for <linux-i2c@vger.kernel.org>; Sun, 16 Aug 2026 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1786911106; x=1787515906; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=59q2Ntm8hDDix7OEi6C849TzgoK31CLh4d49tbHdyzE=;
        b=Pp+iX3XXBmaupUMpe7h//UWidaiTxnnAJSp+w2+fvIUDyx+PLfOWlmBrEQy6g6eY4d
         2kRGryXO8UUS68RmfBKtTymvQcKCTftkgDdXPPPP1pZSLfp8yjIF/iiaIwEfhMYCerIP
         MUJb9dgoa/s2gchB1x+Agf/TDB0SCliooA+gX/uQOQgKTU1VuXAb/lS6Cd/trCk8ITsu
         MFWxFwe0d8os9HhlaRFqbPvr0mA3j04b87jRHSN9GKW4b34Y9o2MH8J/fzq3owLwLPWX
         US+Lg5swusgQQbn8GM0Pag1daXtKZgHRzB5TiUo2TeW9f+x1VOJH9NCtGi/WHDCbnuEK
         V9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786911106; x=1787515906;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59q2Ntm8hDDix7OEi6C849TzgoK31CLh4d49tbHdyzE=;
        b=nJuIXwNb3MguaWkyXPWKxGOQUUp6Rcx/nANV8dUSx7j7gSW6FFYeFBTYdufqf9E+3k
         9nVz0zKV24CErmwgySRJ4gG+HQAKbsdnGoPTAmxWG1+O0QaOzsUzGNLqmSXKyUYUOKs7
         HYb+92rk11K7Q2Zb4lr5PNHFCcy4l8Wkh7CxCDfb9v57f5frqE7GjudXLyX5JxWxZjkw
         LXVyDG6c9tVd/UNvSyu6gNINoRF1FFCGBn3AZKALxQY8h1jxZIPD4a0jwVhOOwn4/lTu
         3//86hfjnDLzpesWUMM0+tLYd0r3FEk/H7iriH19UDgYeG26O+I1ysnbO3LyWmnfj3Au
         USQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpq9L4Pvbuu2jpE6TrqVQ5hoT7Zqrqes/IpPqZlxpN3SU1rGQwrqfeGltV7WlL/GJy+7fbzcE1WTSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+eBUAC79IIwtv6TwzKmun/o2Qq3uZROHuOWFiRTSDN0q3BDX
	+Z0Rg3mTvLhUz+6uYlTRBxK+D3BwWeu3CSj8JBAGLY3YL02artuq/4MCDHLaO8OgbYk=
X-Gm-Gg: AR+sD12TVVxixkW7sN7ZFknP/AFtt1UfnJYtzYX+PPcwJq4BG+qegPyFRfzU7s3mpbV
	Bam7jgK1uvT36Ty6Bd/nYj/unoCyokJeGjVxljMS3iYpiRBVBf0kOi6f0Ip0ux0fJiIYsCq/OA3
	Ukr0i4eNDy3i6SOWKpQ5HP1tX4XziaoSHVR+eT0kqFiOcm6nlAzU76qbnlEsYAFX7dT/E9UcG58
	B46ONXVWa4nUVIfb104NDri554ZKmBBl8jdcw5PaF/jZ9JJHY0w8uKfSddeByWuNOm0/b4LAZnL
	WCjbuC8Jo3OpJoCYTu7EW/YyMd6YGqxYVTbMiJ8O0FEJgmTtifdnp3GJ5CV4/0ry2lW9gAqJydQ
	pTSfuJS61nzrT3EdGa90tj0gOd+9CBrxhBw7dw6JjGMWgYpVEUwQcUgaNqfD3rNntjQkUjC4gbc
	i7zxZv7My9lv2i88eITBKV/ZVpmz3sadbDAR5QcoORy0vB4xLWBzePgHLRWLWR
X-Received: by 2002:a17:902:ec83:b0:2d3:7122:833 with SMTP id d9443c01a7336-2d37f7c3e97mr280281825ad.15.1786911105661;
        Sun, 16 Aug 2026 13:11:45 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bd9679sm30354640eec.3.2026.08.16.13.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Aug 2026 13:11:44 -0700
Message-Id: <DKQN4CNOESWV.2XRL8DIC87HYA@nexthop.ai>
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andi Shyti" <andi.shyti@kernel.org>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] i2c: xiic: restore runtime PM teardown in remove to
 fix clk WARN flood
X-Mailer: aerc 0.21.0
References: <20260814-i2c-xiic-restore-runtime-pm-teardown-v2-1-7ae5d0c30ff2@nexthop.ai> <aoHf6UDxD68YxLYm@zenone.zhora.eu>
In-Reply-To: <aoHf6UDxD68YxLYm@zenone.zhora.eu>

On Sun Aug 16, 2026 at 9:14 AM PDT, Andi Shyti wrote:
> Hi Abdurrahman,
>

Hi Andi,

On Sun, Aug 16, 2026 at 06:14:08PM +0200, Andi Shyti wrote:
> isn't devm_pm_runtime_set_active_enabled() calling
> pm_runtime_disable() + pm_runtime_set_suspended() +
> pm_runtime_dont_use_autosuspend() at teardown?

It does call all three, but the ordering defeats it, in two places:

1. Within the helper's own release, pm_runtime_disable_action() calls
   pm_runtime_dont_use_autosuspend() *before* pm_runtime_disable() --
   i.e. while runtime PM is still enabled.

2. devres is LIFO, and devm_clk_get_enabled() is registered before
   devm_pm_runtime_set_active_enabled() in probe(), so the clock's
   clk_disable_unprepare() release runs *after* the runtime-PM releases.

pm_runtime_put_sync() in remove() leaves the device RPM_ACTIVE with the
autosuspend timer armed: rpm_idle() falls through to
rpm_suspend(RPM_AUTO), the delay hasn't expired, so it just re-arms the
timer -- runtime_status stays ACTIVE and the clock stays enabled.

Then the devres teardown runs. pm_runtime_dont_use_autosuspend() clears
use_autosuspend; update_autosuspend() takes the else branch and calls
rpm_idle(RPM_AUTO), but now pm_runtime_autosuspend_expiration() returns
0, so rpm_suspend() no longer defers and suspends immediately --
xiic_i2c_runtime_suspend() clk_disable()s the clock, all while runtime
PM is still enabled. A moment later, further down the LIFO chain,
devm_clk_get_enabled()'s release does clk_disable_unprepare() on the
already-disabled clock and clk_core_disable() WARNs, once per device.

Calling pm_runtime_disable() in remove(), before any devres release
runs, closes that window: with runtime PM disabled the helper's
dont_use_autosuspend() can no longer trigger a suspend, so the clock
stays enabled and the clk release balances it cleanly.

You're right that set_suspended() and dont_use_autosuspend() are then
redundant with the helper -- pm_runtime_disable() is the only call that
has to happen early. So for v3 I'll drop those two and keep just
pm_runtime_disable() (with a short comment, and the full reasoning in
the commit log). Does that work for you?

Thanks,
Abdurrahman
