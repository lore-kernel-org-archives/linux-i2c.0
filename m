Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977722D785;
	Sat, 30 May 2026 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780124437; cv=none; b=ey8DYUZleYKlmjV0a/XIL2PzM/I6B7swZutO+Tma/qhaxLObSszfwQ64mYz7dSLrKS2QZA3K+60XhQX3JSiPvQ3smWrsy4DeOfzin6oukRwTDeg2c8KSZdgy9Dx5phja51rqGB+fkK6uCXkVXbnsXRd7WkAEhDlU0mguARa7+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780124437; c=relaxed/simple;
	bh=VZFuFh7AcIhBfBW691fSrA8ioZDjxFI473ZYQP5DxLA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KFwSPyRk/F378kvLBJ/dF/Hp90/3pBtJOhIPULNCAN3Tl3UKvpKHNHlB+7KoaIJ801jLBvDxUw2An7pS6XR9iEzxONnD9eEuuptId0aUhaBtZgAF/LVEYTHh6UhvjrYq7bo0m2wLvC2x+M8BLKK+o4WfdsgPv4LYWTY60aFQ5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=dhT739AG; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=dhT739AG; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=AGzQV5J5; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="dhT739AG";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="dhT739AG";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="AGzQV5J5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1780124101;
	bh=VZFuFh7AcIhBfBW691fSrA8ioZDjxFI473ZYQP5DxLA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=dhT739AGVKPV1f2GK/cxDI6palyQe9bOr1BOTVs0Pxal4af8rHkVcqZFAk7BaxN4d
	 QE/QOwb/XbPMa882oub6GW6VLipun7oFIHTR7nkNwQ9OPEYeEV+HOwd9ppaG3C3ykQ
	 QeFLhP+FrLKo7uraazNsysITd1e4VeD+3zjS2GtNHpM8UZc2cjU7rp/WYeCcmUv+rp
	 XUOfQ5OVrYA+8xz6Tzo29o//OKvLUVuaPIfMpczFv45A3Aw4OB96NAHazwt4rC1qB5
	 kFnGKSB0+EJ9sqzeC9JQ/YNlzXY6yYWL/yNvLHFJK2PrLr6WtqeImFd8emWwEvq0Ah
	 32ay+XJPpB6sQ==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 52306E395;
	Sat, 30 May 2026 08:55:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1780124101;
	bh=VZFuFh7AcIhBfBW691fSrA8ioZDjxFI473ZYQP5DxLA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=dhT739AGVKPV1f2GK/cxDI6palyQe9bOr1BOTVs0Pxal4af8rHkVcqZFAk7BaxN4d
	 QE/QOwb/XbPMa882oub6GW6VLipun7oFIHTR7nkNwQ9OPEYeEV+HOwd9ppaG3C3ykQ
	 QeFLhP+FrLKo7uraazNsysITd1e4VeD+3zjS2GtNHpM8UZc2cjU7rp/WYeCcmUv+rp
	 XUOfQ5OVrYA+8xz6Tzo29o//OKvLUVuaPIfMpczFv45A3Aw4OB96NAHazwt4rC1qB5
	 kFnGKSB0+EJ9sqzeC9JQ/YNlzXY6yYWL/yNvLHFJK2PrLr6WtqeImFd8emWwEvq0Ah
	 32ay+XJPpB6sQ==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 22165E329; Sat, 30 May 2026 08:55:01 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1780124093;
	bh=VZFuFh7AcIhBfBW691fSrA8ioZDjxFI473ZYQP5DxLA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=AGzQV5J5yV2XTtNXt05MMVmqAE5jfejNZMi4PYyCillCvaj/A6ehca3Eu4zSwexPq
	 UgHD0Jo5l3KBD/mhqn1oFyiPmabe6Ai9g0zJxwn+QFVQzv+CtjN45IMUFW8Kg5dXZz
	 RBkcI/E3ODxuUagVVJATMc47ysPj2XwTiIOYBpHhsuWN6S4dMA2wuDHrpdtFqoplVY
	 Vr4eHjG5V3lyn0sq3krh5IV18ZEmZQfYvVWYPH1AxUzF5+UN/vw98bGscX+0QH7w3w
	 YOGz3dkEOfvbm1pmEm+Zi3IEU9Vq+r2OwMMQCjTWQeM9xYiyHTRmX2RTuXthDJU9Fr
	 /OhJc0LcwQ/EA==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 83030E268;
	Sat, 30 May 2026 08:54:52 +0200 (CEST)
Message-ID: <776cefab-fa6c-4092-8b95-236a3eaac729@lysator.liu.se>
Date: Sat, 30 May 2026 08:54:51 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH v9 5/5] docs: i2c: i2c-topology: add section about bus
 speed
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
 <20260324-i2c-mux-v9-5-5292b0608243@gmail.com> <ahX4_WaqodYt3PmD@shikoro>
Content-Language: en-US, sv-SE
In-Reply-To: <ahX4_WaqodYt3PmD@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi all,

First off, sorry for being so incredibly slow in getting to this
series.

On 2026-05-26 21:48, Wolfram Sang wrote:
> 
>> +Multiple muxes in series
>> +--------------------------
>> +
>> +When multiple muxes are used in series the same rules applies.
>> +
>> +Transfers to D3 may interleave between select-transfer-deselect to D1, which
>> +results that the bus speed to D2 or D3 will be at 100KHz.
>> +
>> +Transfers to D2 may interleave between select-transfer-deselect to D1, which
>> +results in that the bus speed to D1 may be at 400kHz as the transfer to D2
>> +will set the bus speed to before the transfer to D1 starts.
>> +
>> +This is probably a bad topology ::
> 
> In documentation, we probably shouldn't say "probably" ;)

What makes the topology bad is D2. Without that device, it should
be OK. So, the question is which is more important?
1. protect ignorant system designers from creating a topology
    that includes problematic devices like D2
2. allow multi-level mux-locked muxes with variable bus-speed at all

Checking the rules at run-time feels complicated to me, as devices
may come and go. Also, naming people "ignorant" over a mistake such
as the above in 1 is perhaps not all that fair. But, it feels sad
to disallow things that in fact do work.

>> +
>> +                     .----------. 400kHz .----------. 100kHz .--------.
>> +    .--------.400kHz |   mux-   |--------|   mux-   |--------| dev D1 |
>> +    |  root  |--+----|  locked  | 400kHz |  locked  |        '--------'
>> +    '--------'  |    |  mux M1  |--.     |  mux M2  |
>> +                |    '----------'  |     '----------'
>> +                |  .--------.      |  .--------.
>> +                '--| dev D3 |      '--| dev D2 |
>> +                   '--------'         '--------'
> 
> 400kHz leaking to a 100kHz device is bad. I guess we cannot do much
> about it here because the bus speed is a board specific parameter...
> 
>> +Idle state
>> +-----------
>> +
>> +Muxes have an idle state, which is the state the channels are put into when no channel
>> +is active. The state is typically one of the following:
>> +
>> +- All channels are disconnected
>> +- The last selected channel is left as-is
>> +- A predefined channel is selected
>> +
>> +Muxes that support an idle state where all channels are disconnected are preferred when using
>> +different bus speeds. Otherwise high bus speeds may "leak" through to devices that
>> +may not support that higher speed.
>> +
>> +Consider the following example: ::
>> +
>> +                          .----------. 100kHz .--------.
>> +        .--------. 400kHz |   mux-   |--------| dev D1 |
>> +        |  root  |--+-----|  locked  |        '--------'
>> +        '--------'  |     |  mux M1  |--. 400kHz .--------.
>> +                    |     '----------'  '--------| dev D2 |
>> +                    |  .--------.                '--------'
>> +                    '--| dev D3 |
>> +                       '--------'
>> +
>> +If the idle state of M1 is:
>> +
>> +- All channels disconnected: No problem, D1 and D2 are not affected by communication
>> +  to D3.
>> +- Last selected channel: Problem if D1 was the last selected channel. High speed
>> +  communication to D3 will be "leaked" to D1.
>> +- Predefined channel: Problem if the predefined channel D1. Set predefined channel
>> +  to D2 as D2 may handle 400kHz.
> 
> ... unlike here. We have MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT defined
> already. And I'd think we should only allow bus speed switching for
> MUX_IDLE_DISCONNECT to avoid out-of-spec scenarios. Opinions?

It is probably not unwise to disallow MUX_IDLE_AS_IS in this context,
at least until someone actually needs it. Which does not seem all that
likely?

However, it seems like it should be fairly OK to allow a predefined
idle channel, as long as that channel is not lowering the bus speed
compared to the parent. But maybe supporting that can also wait for
an actual user?

>> +Supported controllers
>> +-----------------------
>> +
>> +Not all I2C controllers support setting the bus speed dynamically.
>> +At the time of writing, the following controllers have support:
>> +
>> +============================   =============================================
>> +i2c-davinci                    Supports dynamic bus speed
>> +============================   =============================================
> 
> This paragaph is easy to get outdated. We can document that only
> controller drivers with the callback function implemented will work.
> People then can find out if that applies for their driver...

There are other such hard-to-maintain lists elsewhere in the text.
Not saying that this makes neither those nor this list a good idea,
but it is an explanation for adding one more.

Cheers,
Peter

> There are some grammar correction in the Sashiko-review[1]. Most of them
> look correct to me. Can you have a look at these, too, please?
> 
> [1] https://sashiko.dev/#/patchset/20260324-i2c-mux-v9-0-5292b0608243%40gmail.com

