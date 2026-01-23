Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06F1E5B68
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198174; cv=pass; b=mN1cW6Yi+vczeGBhBVKO4TDSXypbqi4ZlWt5hRXk0sSaTrYHPchm/zUGkT1UKI8XL14N+NRUC/L6LGLm7vvfqkud4dcqd7J+ZvJNJsCl+51Zi7/9xvOkTLJ/DCcTxu9/iHZSHh6Wxut+OPMYOKbl4HEx1V4msjILH4feML+73nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198174; c=relaxed/simple;
	bh=seyb/K1bgHB46P/VrgbdVOVr5/NehptCOlCWfUug57A=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpGqFhnFr4W/d47Mvm3ip+fQ2qidx22InnFCuPQ1G7fIv6kCYvYK9Z9zTz4gZMEQEqgSUYFy+qZjO/F8wgzDybnJAQEFau0IesWKWYpAw4sJ7Hws8b46l6Dpgfo2kumPU/JiSWcNN53jWRO9wLV32ph0wCvkcTXeH0JwDTLrpMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=fV7twuvv; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="fV7twuvv"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7927b1620ddso39160357b3.0
        for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 11:56:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769198172; cv=none;
        d=google.com; s=arc-20240605;
        b=LjEy54zEwPdKRq5kHJWAlH/QwfReTjM3cpLZDGXN9kpzkn1m+kwibHtT2F8T++2S+A
         OwTxT/145xasL7LaE+BOAHe4AWzZeLNPBc21QHoUaq9dCNPCFSopcYAL/U5y3GJ4VboO
         BRkmw3PmweG4YXafyrbhow6j2OTgj010HeBLjuzWKe7C1KffB8yScHWmNNK3Bp4mpJZ2
         j4fSo0qQtzv0SoIEE3Bd6mNDEz/VZ/4hrFmlu2A+LvoAtBPKjFPP9Otn/yDXScqTsjhD
         c98zt9YBB9QQP7ikkYYZ93RLNVUQV9Gc0SOrwX6fnyY+sTiy9g5HclH6SkrG9c9bNBLI
         wo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:dkim-signature;
        bh=pRzQmM1lz2CLbIKhXyUz8czg2mNynwC1/VV/UsQgqnQ=;
        fh=ImJKn9Si1zN3uHGOEglXgOxJVCbXnXw5orjLvcGAYFg=;
        b=WGmZyb/aNlqcxSkqWHSkCH1LB0mazOMKikD4bBPS1eJy9hTrh+HJQ/SNx8jTyoEQsX
         5TrYu5KyIBkVCtjy8gl/GHbyZSf1PArobTyS/MIDD/P/NediC3JOZOYUxJHR5aq+/N5U
         phfT46lKxRN9ZynVKAea/Jx9pF/mrYc0nl7Ctb4A2e3JJMB2UMuAQTpTZnn4XXEoawWo
         snaBzYgxewrCfNmvLeagG7NBser9cPYTK4s+V0g3ak6deWyVtz5GILOmIozOaj1jhAu0
         /WVRIs7+NOkBkCmkCKwRflBJfCid1G45f7k2z2FFBPgWcfwum7SF/40iCci0ehRM0kfe
         X55Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1769198172; x=1769802972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pRzQmM1lz2CLbIKhXyUz8czg2mNynwC1/VV/UsQgqnQ=;
        b=fV7twuvv9wZ2h1DN+BKr4tPnnBfLL/kEvWctTXrKfgn1PoTSEeBl0YDBcch8eYjTCH
         3BEVjewnkxPWKyf7IJuRImaSHXH1ZgbLt1aQUrZNHmBIPdxkYXsuAVuJRnKhaIQy/h84
         ca8va4y+5E8PFbWILsBum24/zYLPGqXsyzh7yZO+D2RjFxyppT6LlNvtYIfEP7DRmyYe
         1RFYUf+OVSUBXJNDZhYFMvy5PrNxZPbWSCVzP5YAS3ul8Uqxg8hXa7U6TIv2J/FSiu0b
         Qpt5ysE6ebB/7Q+KTMJfWAzych6Pnlyh2SWjVahhDm127mriazIP4y13vR6P0Zkd7H6X
         qPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769198172; x=1769802972;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRzQmM1lz2CLbIKhXyUz8czg2mNynwC1/VV/UsQgqnQ=;
        b=Fgcrxr+zkZEW1CQKdeaweBX19WjRvJMIR85PVOfavz91jcEzryto1+HTuLKi8cWCRA
         D+Aj1SVpBPHSkvIVn41aRzaIVo6I+nrb9JkAgE+kvVxCAeKmRiVrUQ8Vp5Art0qej40p
         gT0KDjQqFEyzgXRBuhIVWs0GJsqIFsOjZXLCxVaJPFFLpTxh2VrtcCcgAJ7aiC+fRbrf
         /dfq1LGnd8RA5HKhaEiHuxvkkpBqMZb2M4NHjkVSaBrQPiLsDo5COFHvRPcpO+N2YKvN
         07oxTbDvxKu1O7qKnuKNYx5YVyGAKkcQXo678ha7R/ZhAseXeY7ZnNa+00U5CbhrmwA1
         wU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6JOKrpzc9BGQLTzQaXyPorTeOIenJu+0ikYRozdPUGR8X2OkGrjkgVupldzGviHHjrOExOi6JWAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31RyChyf/K5nSc3f5mr+Qx/7YZC4er6iwjqT3OMkbtGsC1gQY
	7mu0Dvn+Oolt2obzzxvrQjf7TnwTGFhlLXT9RoaHR8ryoN9BlNRgsqyqwmQCUGs/et7gVyFbkF6
	oF8pKYTn6V/EUq/85Q7wS2J6ASvhIdkwtlJtDwyabKA==
X-Gm-Gg: AZuq6aJ0p+ojEl19DMX8juU/AcIEgU1aEVHFHGu4807DusN+arjRpkQsKV0LHnWa5NT
	c66Zo/NyWKsWwVarhicQPOmcXd/TtLOskcn8ZDaZlnIscbq9FG0f35lzNun7+xwz6PcicHz/uw+
	wbmGY8Mf/3QU2rhUuCSd4ueAaKF0OGmZpZVDk/KOkpbXNnWLftnDeIq5kyxqyG2lB+ukMVAYocG
	LqmvMY5subyLff/Clofj2dQuQDEmoOo1RMxBRRGKWyBDVboNmxhiPnrDFz2vWMnwHPV/KPD
X-Received: by 2002:a05:690c:6c91:b0:787:badd:4f with SMTP id
 00721157ae682-7942a82216emr57835217b3.17.1769198171795; Fri, 23 Jan 2026
 11:56:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 11:56:10 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 11:56:10 -0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-1-eb7cd4254dfb@nexthop.ai> <df9e1a39-3928-491a-920f-fd45120d8024@lunn.ch>
In-Reply-To: <df9e1a39-3928-491a-920f-fd45120d8024@lunn.ch>
Date: Fri, 23 Jan 2026 11:56:10 -0800
X-Gm-Features: AZwV_QhUfRUwIxUyrcfux8-cCvxAaxEfux0jZWXnZ-3_tfujqzHxVqC7g82XeGk
Message-ID: <CAGYn4vw55SPn4vKuYwM1nTgpzdExtEuv1H3JNkx0XngBd6mjYg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] i2c: xiic: make the clock optional
To: Andrew Lunn <andrew@lunn.ch>, abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri Jan 23, 2026 at 7:20 PM UTC, Andrew Lunn wrote:
> On Fri, Jan 23, 2026 at 08:02:44AM +0000, Abdurrahman Hussain via B4 Relay wrote:
>> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>>
>> The xiic driver is designed to operate without explicit clock configuration
>> when clocks are not specified in the firmware. This functionality is
>> already implemented in xiic_setclk(), which performs an early return when
>> either i2c_clk or input_clk are zero:
>>
>> This condition is satisfied when clocks are missing, as clk_get_rate(NULL)
>> returns zero, allowing the driver to rely on hardware-configured timing.
>
> https://elixir.bootlin.com/linux/v6.18.6/source/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml#L42
>
> The binding indicates the clock is required. You need to update the
> binding to match the code.
>
> 	Andrew

Absolutely! Let me take care of it in v5. Will add the doc change before the
code changes.

Abdurrahman
