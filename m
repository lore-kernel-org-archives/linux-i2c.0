Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19E2FD7B1
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 00:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112126; cv=none; b=W5Wbw70QtlaRX/rmdKp6/hq8dz89BNECotBMCJBcIDus2WJ3CUIJTQ7/Vmjcdq3R4K3ayeKzqY+I8dsBnyndMJfcethlXLLjv+LgQKBXixF0buyAywE80KJj1e0z4hWhxgnYKpmNc7TF2wZjlHN7LrcPRNCEtXhW7GGVYQvO25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112126; c=relaxed/simple;
	bh=hh8xym4JQgXHNzgZxH22Nfrp1ofGYWiJboNIC3qrWEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/vQPZtdPvohrX/oV+UG/+CWOMufmdSPY1k5s2aikcwRB8ZwYIYm/gmTtBEbBcNoQPk93araSOKhcktG3paRgwFzQjcf3v9z3jWT6Hr+VApjicqj52HJS1kyI4BM0yAcZ4tYceyYpZgTzah3bo8mr150p0FU0OM8LKfZVPvlKnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffr9yJa4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffr9yJa4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-89edb9bc666so682762b3a.2
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 17:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792112124; x=1792716924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyHDwGXyjmNBTugltzNjIAs8HpIjTxQ9m7AkCFTAf3o=;
        b=ffr9yJa4Ylyc5r1jcrxJTU8I3u1E/Mt4QU9l3pMIVXMIkrcXG+aPiERrOutIXp/+wB
         21TAs/yestfK88VmOm01QZk8prwgTo9yZbFpWpTs2VbLyjqgFh008C6yV/YLnGjiALzC
         nhPnAX34291O3WL8L+/5x5vsjDb2cyrZWmUZ4b6YRk2ulNp8GzdyU1PbRIGdsFZg2jmE
         B4Ge9qxO+igLHzXM57gb1L75aJCPUUllcpZfCMrnetO4wpzLzc6LWtetkqzFMpOR/Yhh
         5Sb+MnldKquKkLN3WjC1Z2he85WasGZjD1wk8z7xxf5iF86dxB5ToM6JGP2I7IRX+a2t
         CA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792112124; x=1792716924;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UyHDwGXyjmNBTugltzNjIAs8HpIjTxQ9m7AkCFTAf3o=;
        b=iz1lr5EXKOmuOjulTkxm+OjQbFYIbrSLi50/DWhR7z6JUP4DLVch6puezlr5qChGnq
         HpY9uw+RCclWGTnYM3usjM5r2GJBtjtJsskW+oNx39IfGl6JzX1+b4uLZjHfaXUXDLpJ
         1dibi9hyRz4kZOn9iuw6EB/WzMaUhUwM6W5pMdLiewykVrOiCfOUPGN6S2BXa52qI9Re
         x+YJEyTHnbLD7Ssa/r9UhtVHHmtEqqTK0anQNIk7HGoaHUTLldcw37Yt178ypWVuZHVk
         d7E/8kZBFj6YmVYKOqNjZXQ4ZD5mHqYug7YaTMY83kyy1i46hu8GrHLicHA2BoJJMi7+
         6aIg==
X-Gm-Message-State: AFq9FYLcDAU11rcWVRQPTKXCL7llHka5amTMkuZRBU0cxPirvwrUMSmZ
	zZ17odBF8KG0ZMMy171VhwOxYJkiYX6GMOv6qvPn6jDt9Fn8M4q4Fdfj
X-Gm-Gg: AYBFou2A2hNEC0VoeaEL4crp5C7GY5OIFq7v8fdBaxMSZsXIZME1GtrrgRNNa6vlL+k
	P5TN35RbX4W1ysy0p8Hdjftiwr7+JEpwTgKd6DFP9OYeVquTdU2v3ZLOIhEt/IvA9vcntk3pjrL
	5XRmzLZ9QXSOIH6iq4Z5zjPM9sA/lGEEEM9U52rtY3nnH0r1uMi0/AfXRh/VQXYTyy9RySDcTLb
	HqJboY/FGICYu6j8NUQEWja9geppPP7sewY+8pDmMAo83r2ChX34PbfDps2NyJ0sBZN5R9IPqk8
	LWQzLJF6GH8GvaatR3BIt5KHgnkD50iIgLc6NhkLi+3tUSoZWG1hkoPRPwPv6QF7XU4Ru57I31G
	r+l/bwBunX68cLbFTTVsIND46EFiijrcvf4vWWdOyfHxEZCbqWJURQ/oxYOeEX3xVPDKnP2Lw+C
	byxmNNZi3Vtn5WgwQOdNMjUKrUOxAmo3DIbvWr8667I7Tlzf69Fmn76UNkx+EDWg4ssst6E6PNo
	AD23tSPrrSr/trPxb8OwVVfNoAfie3aty2pE78z3PFTkg==
X-Received: by 2002:a05:6a00:f04:b0:892:a8f1:c53d with SMTP id d2e1a72fcca58-897c76e25a4mr19506420b3a.22.1792112124477;
        Thu, 15 Oct 2026 17:55:24 -0700 (PDT)
Received: from [172.19.1.48] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f58416a5fsm311339b3a.60.2026.10.15.17.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 17:55:22 -0700 (PDT)
Message-ID: <b30445d5-c5be-485d-a935-8b574a7aedea@gmail.com>
Date: Fri, 16 Oct 2026 08:55:16 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] i2c: ma35d1: Add Nuvoton MA35D1 I2C driver
 support
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
References: <20261001075101.489660-1-zychennvt@gmail.com>
 <20261001075101.489660-3-zychennvt@gmail.com>
 <as9ZVx9TV5NpW1cK@zenone.zhora.eu>
Content-Language: en-US
From: zychen <zychennvt@gmail.com>
In-Reply-To: <as9ZVx9TV5NpW1cK@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andi,

Thanks for your review.

I reviewed the Sashiko AI report and will address two findings in v12:
- Disable the dedicated IRQ during transfer state initialization to
prevent the IRQ handler from accessing partially initialized state.
- Clear the wake-up control register if `enable_irq_wake()` fails.

For the other findings, I have provided the relevant hardware and
driver design rationale in my inline replies.

I will send v12 with these changes.

Thanks,
Zi-Yu

Andi Shyti 於 2026/10/14 下午 06:29 寫道:
> Hi Zi-Yi,
> 
> On Thu, Oct 01, 2026 at 03:51:00PM +0800, Zi-Yu Chen wrote:
>> Add I2C support for Nuvoton MA35D1 SoC.
>> The controller supports standard, fast and fast-plus modes,
>> and provides controller/target functionality.
>>
>> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
> 
> to me the patch is fine. Sashiko has pointed out a few things
> that require device knowledge. Are those concerns valid?
> 
> Thanks,
> Andi

