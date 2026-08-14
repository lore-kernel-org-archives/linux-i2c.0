Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FBB492525
	for <linux-i2c@vger.kernel.org>; Fri, 14 Aug 2026 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730233; cv=none; b=uqRsp5Nw82TuuzAP3eFo4mTXbrIBJo3+x43qpyndw34I7BjyUNRKKWAUpFOwCWjvxUJxha2hQSRryWhxIVhC+wE7hxt0uKg4QFgA4pVpiZDRV59TwwRNQ18P8rBaL56+U2pdjjCug2e9Bg25k5lZ8n+qK+XTLoMrSd0Yndti1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730233; c=relaxed/simple;
	bh=CCsfE2oeXgk17KlO6HGMktCK5aeGy+7VHisTD9GROeU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=o4AcefC7z7wYl5S1rcjzHz9yTjNHkB9nRguD9IMBRpbWTkBsw71JpCclwttZXyRb/anWkHsulNKT0Cb8orbqIdrzsekib9ccQrHedXGg2gum6FJunltCChW+l2F3tSUpTFLu7rTTwnMq5uw/6/I4cEujUucWKSqjeHB8XKWCmmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=OGnOanLr; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="OGnOanLr"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1463300a91.0
        for <linux-i2c@vger.kernel.org>; Fri, 14 Aug 2026 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1786730231; x=1787335031; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CCsfE2oeXgk17KlO6HGMktCK5aeGy+7VHisTD9GROeU=;
        b=OGnOanLrdRC/BUjMOgzkuGCJ38Dcv5or6o6a41dcMDPULxaW73vBUi0NwkUszCJVvz
         uAzsK96adSI5woV/rUrIAo6TnBIT+7OzQnlA7jAbYE7WzI0iUBwy1ii5/OKT51yN24e/
         4BPFBw6VEkLqiqS1pN/aqVZyIfFGOgb7WKCEyXRgxbz8Sri+IJQIHwjEDupLQPxqEmGK
         vg1DWH4+00bnekM/J5HVG7osP/KxvBrnFidpOf0QCck2MEDZof5d6lcFkWIUCPccVKit
         fJUDk8+muLyOhpWFQ2e++/y4yndVBGILtrF7Kg5nOP8w86DiSVgJZoNbJ3IUT2UiVHGa
         rQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730231; x=1787335031;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CCsfE2oeXgk17KlO6HGMktCK5aeGy+7VHisTD9GROeU=;
        b=DhUH/yxhwvzERHUaCYo/gFfEU82wFFDiXD/YzdhvE1ILmf9GARwj9jh6h89tQ04x99
         U2ZHPtlytv9WaLT48cW9jFRZ8m2zJdk6txgQ5cdB/kvlP1s2pgc5eOMwR1aXTkeJgQ5r
         xi3A6T23uoHd3Rij/WxEpIBR8Gv1APiQNMMem/vjxXqEDc8erJ2Pb1KMTpLQhUcC6t1V
         HU0Dnn8LPoaz+oj+DC44sqZ0zqAiOKQCAoGBMu47IuBoel+y6B/wUGm3GYI9s4QAOHO1
         pdhn4bNpcpjPmst+xvkqjVxVy7vKEaLGh2Q4eocOEqmfKhZp97HgnSUSLr7jPqd8ZE79
         2mRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFv6EbCbbPtuxX3uGsQLV2AWYdN5TTUKKjW1u5DsyiwVicAHOof6UIUIDVBmppoqQhVKeUweU+J+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCu9JWpDzQQi2BOLmzN6xM7riZ9owTsnGmgfpQmahAjlpK2WhI
	BNZB36Gb4XMHDt+YNtBbBdFbAoTVTygCdUJeeXJ4V5qT9XTvdMFtGaeaL2GtgnH9bu8=
X-Gm-Gg: AR+sD136AzNgrlHu87H9PLgJNO7Z2RpVWOKU9yjPqnnSWGsZssVlALRn/lZJ63Mm/HC
	3EpbSYqsxPdCOAdXAiPX6DR+z6c3M8gnT0QxpXxW0kzlaQnmLevK+FZPNaF1GPYMKqJyH+tPj3Y
	jQlQxEoSWSclFwvNOTZlrKOBkSs0B2DhzPkgOKByiuYGvOcwQuGR9r1BqTbZ37si75Zh6vbxcj3
	5hW6fyMDXrQjG8sSc7QxWP0plVbmPUlS9OS5yArBQW+eSg3zGU34ZpjoufHB9P03AipC8zWWYEa
	Wdw2+CfPgU3fSxQN4Cn9xvSFrx6ZkfEE4OyxjeEtQ8LNfOroPlIl4tKRyzdzwi8p4HGYswEEKZ5
	xeZNuyXTAcjn5HqVqoKmedSPS6T/WUHBcFWQZ79BUuYnr+3jVIMHmkXI2qB70jAGWlVV8SnJhcK
	Qj7fxVRpuK1uez83PQPwynAqP0hFn/krxmujUTaufOYXpVcLVIX9B0zO5coGz19J5CEF+0IQ8=
X-Received: by 2002:a17:90b:528f:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-3933e5d202amr8549727a91.10.1786730230603;
        Fri, 14 Aug 2026 10:57:10 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bdc5c4sm6924004eec.5.2026.08.14.10.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 10:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Aug 2026 10:57:08 -0700
Message-Id: <DKOV07N5ZCM9.1ZUFFUNICUUFG@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Andi Shyti"
 <andi.shyti@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: xiic: restore runtime PM teardown in remove to fix
 clk WARN flood
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260813-i2c-xiic-restore-runtime-pm-teardown-v1-1-0e7dfb206790@nexthop.ai> <an7gLYzltJgjIUNQ@ashevche-desk.local>
In-Reply-To: <an7gLYzltJgjIUNQ@ashevche-desk.local>

On Fri Aug 14, 2026 at 2:30 AM PDT, Andy Shevchenko wrote:
> On Thu, Aug 13, 2026 at 02:06:40PM -0700, Abdurrahman Hussain wrote:
>> The devres conversion dropped the remove-time runtime PM trailer
>> (pm_runtime_disable + pm_runtime_set_suspended +
>> pm_runtime_dont_use_autosuspend). devm_pm_runtime_enable's release
>> action then calls pm_runtime_dont_use_autosuspend() while runtime PM
>> is still enabled, triggering an immediate runtime suspend: the suspend
>> callback clk_disable()s the clock that the devm_clk_get_enabled()
>> release is about to clk_disable_unprepare(), and every device teardown
>> WARNs in clk_core_disable() ("clkN already disabled").
>>=20
>> Restore the trailer: with runtime PM disabled and the state forced to
>> suspended before devres runs, the suspend callback cannot fire and the
>> clock enable count stays balanced.
>>=20
>> Fixes: 50c63491ff26 ("i2c: xiic: switch to devres managed APIs")
>> ---
>
> ^^^ Something went wrong. The SoB must be part of the official commit mes=
sage.
> Putting it under the cutter '---' line makes it disappear.

My bad,

Let me fix it and send v2

Thanks,
Abdurrahman
