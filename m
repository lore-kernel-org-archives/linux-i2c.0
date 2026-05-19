Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437327FD44
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225361; cv=none; b=FHXrnSsdsPISBiwbmk3R87kjiOEIY/ExLPfh+bqPz4QmobsyAqTic2p9VHYoxaDsnpCgvN+jkz8FyDatc9nK0Qzgys2dEMsG7N86yk+f2LS3+97ooy5S3cB8KgZrqnIOHHx5YCoJ+mNUrHnVMcUO9QKqNvSfkNSNZtS1UC0p2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225361; c=relaxed/simple;
	bh=5vGBjzZa97irnb3mkdJstsJslTkHUowsDzVwyzuX2oE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ghKapzdsXc2P87HMogcVhNFml9zG9mnExJpzsbthl4vsIM/XhitznCAp+r4Pd9uHoWjmE31/fxo0qHBnnJhmxDiz8/uRPPy8G2zaSu4SEq3jAuqVWy4qQaj2QZ/MQ/BfGr7PCvdUZG61Mth+jIgfdVJzHhGfM44Fy6tUk5sgRQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=NcuklapK; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="NcuklapK"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3025d725a05so10961347eec.1
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 14:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779225360; x=1779830160; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/ZeOv3d1KS4Ph57poREN8FJkgP4PJjf4SNC4OI1sp8=;
        b=NcuklapKk0VKdhGbBc6Wu32jvcx94cf8cpP6ZazJelkGdbssKYSaQLlnKlyeSUEsh+
         C2vvUmVKBKUCseJmsuESLpKD9eWxLPT9Y17EQXJWtzX0gD8OS3RB8/B7ecnQkWoA1S+i
         w7njGwKqpF6wMTzl3FvFKC1JR3Oug4i+NTrTIVZw/xO5neZpdnU7xGabZ8ohQs90N0x3
         gYuw0mTDrDOyOYQHdxk5Ed6rR0UBDLl9bBEjhXfAM6I6dtygtUSnwe4rMN5nHHlTWL8A
         IM6AnbOp1ZAK4YF890Knqbf3+tx5XuweV6p5kILaKo4vANZTPdJoLOzsTwI+UwNkpgTT
         af3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225360; x=1779830160;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/ZeOv3d1KS4Ph57poREN8FJkgP4PJjf4SNC4OI1sp8=;
        b=dSTaAAKb/3IDvVxxYOUm45ny3XsK84bzf0/J9RItWAlWweMgnhcnXYltEBDzSo/ItS
         nD/vXIiVFNPTdOgEMg34/TMuwhyBtPzrHnq1LyI/8hxe8rTlC8reZ3ZI5PksYbixAyW4
         Ipag0dKZZRxNYDg5upc0rrqRde5UPkoW8PXFOeSv6lhHYOZJHNQjddem6vH59FhxcZy8
         rJl0LUhMs+luskNbcmj0huKAsoBWVglbGYEn9BdDgU8omcKHr0bmfiXNbKAxv6skaTog
         0MqoT+HlMMGohxrYiF1DyHI1crLTcogQgoQRKfb4dTxCrL2sXytrV2uFTZP5A9l8Gui3
         /uSA==
X-Gm-Message-State: AOJu0YwlDfJRfWICGlq3FlQjcfxLNo8eIq9ZnkHIv9EjwGz6XfXhXb0O
	zoGp8N6Dbmutsl/cA3AQhBxxpEOOpV5Fg1pwZ9apf0BjdHZ6QPhGXQnGgzHwqnmhABo=
X-Gm-Gg: Acq92OG7cZVof+5uY3RUKpbIZBq4Xl49vkXxY9TJxb3u+HAOclzhjrID3xP6ZOZvPQp
	veF9lvizEFnDaUxbcISHH9P3nBq73Pf0lDfuoWFT36DueCX350SeXw1rzdRve+OGk3ZeofCorAk
	Pho0mHX+8XhhS+HzjO6a2zhfyZQAbEigO4qejU/OZs1a3tX5ZDOB+5VRY4Y+v5yHtbr5mDASlGe
	yIbTSmDVY3CRjcW/57ROTmoJ3mL7snM7rHgUBaeBnrkXjFaH2/mT4zgN+ir2tpy3r3efmMVVY9e
	d82AOUp1TxZCzHpfaZ+xyzkv8ttewH8l65Jy8bs06OVYUqcBwAbVvGBzUK+HY7uAHPQ5HzDIlnM
	2wHhaxQ2qPn/zDc6GPhBi2KlbfRngGBWqFLHFCH/RD21Q2vwTs6eVfUQYrk+FwHfixA7O8Zb+tc
	D+etAto8JiqhJmDDBm46jBvBjTvOtVM+bdKQ==
X-Received: by 2002:a05:7300:3709:b0:2ed:e17:d50c with SMTP id 5a478bee46e88-30398685c5bmr11280161eec.31.1779225359514;
        Tue, 19 May 2026 14:15:59 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294500a97sm19900482eec.9.2026.05.19.14.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 14:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 14:15:58 -0700
Message-Id: <DIMYR1TGMJTH.RXQJ3IEB4309@nexthop.ai>
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Peter Rosin" <peda@lysator.liu.se>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
Cc: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] i2c: mux: reg: use device property accessors
X-Mailer: aerc 0.21.0
References: <20260519-i2c-mux-reg-v5-1-7af068f255cd@nexthop.ai>
 <69960d6a-2ca2-4633-91cd-9dad27f6de12@lysator.liu.se>
In-Reply-To: <69960d6a-2ca2-4633-91cd-9dad27f6de12@lysator.liu.se>

On Tue May 19, 2026 at 1:39 PM PDT, Peter Rosin wrote:
>
> Hi!
>
> Thanks for your patience in seeing this through!
>
> Acked-by: Peter Rosin <peda@lysator.liu.se>
>
> Wolfram, can you please pick this one? Perhaps after waiting a bit
> for extra tags, see below.
>

Thank you for taking the time, and all the feedback!

>> ---
>> - Discriminate ACPI children with is_acpi_device_node() instead of
>>    is_acpi_node().  v4 routed every is_acpi_node() child to
>>    acpi_get_local_address(), which is wrong for ACPI data nodes
>>    (the _DSD hierarchical-property children PRP0001-style firmware
>>    uses): data nodes have no ACPI handle, so ACPI_HANDLE_FWNODE()
>>    returns NULL, acpi_get_local_address() falls back to evaluating
>>    _ADR against the root namespace, and the probe fails with
>>    -ENODATA.  is_acpi_device_node() narrows the match to ACPI
>>    device nodes (which do carry an _ADR), and the else-branch now
>>    resolves "reg" via fwnode_property_read_u32() for OF, swnode,
>>    and ACPI data nodes alike.  Flagged by Sashiko on v4.
>
> According to Documentation/process/coding-assistants.rst, you should
> perhaps credit the tool with an Assisted-by tag? Given your mail
> address I suspect you might have used other AI tools as well? Just
> add tags for whatever is appropriate.
>
> Cheers,
> Peter

I used claude-opus-4-7, mostly for helping with the wording of commit
messages, and sashiko (gemini-3.1-pro-preview) helped catch the
is_acpi_node()/is_acpi_device_node() distinction.

Will add the tags and send v6 shortly.

Best regards,
Abdurrahman

