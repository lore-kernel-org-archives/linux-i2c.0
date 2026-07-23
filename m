Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37066431E4A;
	Thu, 23 Jul 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804801; cv=none; b=LJFxHJUQCPk8pD97pa8tVFcOZTL9ly49lKmF0dyyIMJ16B0cvgm9ROX04rA7qVrMteRZTYGkwRdhODcGlPm2mupgPFWcK4dVEIqvoqEh1oGVB35rwe72f6Cjx2330/ZGJAqprqRNbFUnsxy9lFFRZE9MhWsjIu0Vta1mcdgJNj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804801; c=relaxed/simple;
	bh=iB+itzYWCHNZZ3o5cei/xxMrlYhVWL5HBHuf2Di68qk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LokTew33Ulp9K3yqVKFFmrAZU5Koa8o15SvLr10IqzVrXYsXJijJaD2+EgS4/nnDZhVpHqPAQWIKdS2Ftv4OwoqK42e/ifhFrJARzkZIdjlPFHX46+w7IZvXHA34pkgK10k+i48n0Eo2+oEw+jJaztqRbX582DrOyZPJMJmpKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=DJibEIxM; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=DJibEIxM; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=tL+WPGkB; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="DJibEIxM";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="DJibEIxM";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="tL+WPGkB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804798;
	bh=iB+itzYWCHNZZ3o5cei/xxMrlYhVWL5HBHuf2Di68qk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=DJibEIxM3NLhMSZ/1pt6kikTEFq2d/paZlfFdh4INtIZzkms820ju21cHFJzEElGR
	 k606MD1my6f71U4rXGHCn4VuwuyYkfN/VMfkXKufIT0C8T8rzz+gfN1znOprVvlWWE
	 HW7fgjZInzvsBfp69QespTfK71ol1rxe9USNq1AJTMQF+gnDiSaxXghdWhc1G76RuH
	 wsCFbfllSjBmQpSMsGyjl2U72piA+D9Z+wq6gqsbMsum6v7R1THSkB3AY8gUjDwU7c
	 2TmKewOTmSCZsmwP2gDSE73DbVl9Fiq9ZfztIKfm1YWK/LCSynFoVHr1FHb5Hj8Whn
	 LgSlmohCu7l4g==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 5E4B21B97B;
	Thu, 23 Jul 2026 13:06:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804798;
	bh=iB+itzYWCHNZZ3o5cei/xxMrlYhVWL5HBHuf2Di68qk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=DJibEIxM3NLhMSZ/1pt6kikTEFq2d/paZlfFdh4INtIZzkms820ju21cHFJzEElGR
	 k606MD1my6f71U4rXGHCn4VuwuyYkfN/VMfkXKufIT0C8T8rzz+gfN1znOprVvlWWE
	 HW7fgjZInzvsBfp69QespTfK71ol1rxe9USNq1AJTMQF+gnDiSaxXghdWhc1G76RuH
	 wsCFbfllSjBmQpSMsGyjl2U72piA+D9Z+wq6gqsbMsum6v7R1THSkB3AY8gUjDwU7c
	 2TmKewOTmSCZsmwP2gDSE73DbVl9Fiq9ZfztIKfm1YWK/LCSynFoVHr1FHb5Hj8Whn
	 LgSlmohCu7l4g==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 43C131B97A; Thu, 23 Jul 2026 13:06:38 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804792;
	bh=iB+itzYWCHNZZ3o5cei/xxMrlYhVWL5HBHuf2Di68qk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=tL+WPGkBoq1qI5lFkvqLgDrdcBwy+Lr4ZmQpnsOSuzB1Q91fNGVAId+qZBFT9tNK2
	 CSMcgSmC1CtMrkOqFHTLNRLk3iAQmRDEf7aJ3u0ThRlPj+tN+B6voddpasZ1E8tq+q
	 0x5yEnpMzYr0rvbVeK5udzn3yuIjr98Tq2aOOuEEB441uhfTay5BT99jqve2MDsG8x
	 KTxBOXdTuseUteyqB1YYAmoMUso12+ZYk0v19NfTXEDLGf10s4uLtUgAe1Yx3Qmmtz
	 cM4zIkOm3f5Eeolu4zQgxv86Hq5UUQijKTxAXFmqMKV58NGmdJcVAiw5UqVadBLo3A
	 MAOIvC1tdijUA==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id A31751BA45;
	Thu, 23 Jul 2026 13:06:32 +0200 (CEST)
Message-ID: <e0b9cafb-1aae-4ea9-ae9c-ccbcdcf08ff1@lysator.liu.se>
Date: Thu, 23 Jul 2026 13:06:32 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH v12 7/7] docs: i2c: i2c-topology: add section about bus
 speed
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
 <20260719-i2c-mux-v12-7-a5010d623a57@gmail.com>
Content-Language: en-US, sv-SE
In-Reply-To: <20260719-i2c-mux-v12-7-a5010d623a57@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi!

On 2026-07-19 16:59, Marcus Folkesson wrote:
> Describe what needs to be consideraed and taken into account

considered

> when using different bus speeds for different mux channels.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>   Documentation/i2c/i2c-topology.rst | 178 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 178 insertions(+)
> 
> diff --git a/Documentation/i2c/i2c-topology.rst b/Documentation/i2c/i2c-topology.rst
> index 48fce0f7491b..1ee0de6dbcb4 100644
> --- a/Documentation/i2c/i2c-topology.rst
> +++ b/Documentation/i2c/i2c-topology.rst
> @@ -367,6 +367,184 @@ When D1 or D2 are accessed, accesses to D3 and D4 are locked out while
>   accesses to D5 may interleave. When D3 or D4 are accessed, accesses to
>   all other devices are locked out.
>   
> +Bus Speed and I2C Multiplexers
> +================================

Too many equal signs.

> +
> +I2C bus multiplexers allow multiple downstream channels to be exposed
> +as separate I2C adapters which also could set their own bus speed.
> +
> +The multiplexer itself cannot change the bus speed as it uses the upstream
> +clock and data lines to communicate with the downstream devices. The speed
> +is therefore changed in the root adapter resulting in that the whole bus is
> +affected.
> +
> +This increases the complexity of the topology and some considerations must
> +be taken into account.
> +
> +Bus speed
> +----------

Too many dashes.

> +
> +Downstream channels of an I2C multiplexer can only operate at the same or
> +lower bus speed as the upstream bus. This is because the upstream bus may
> +have devices that cannot operate at higher speeds and those will be affected
> +by the speed change.
> +
> +The example below illustrates the problem.
> +The root adapter is operating at 100kHz. D2 can only operate with 100kHz,
> +but D1 can operate at 400kHz. When D1 is selected, the bus speed of the
> +root adapter would have to be set to 400kHz, a speed that D2 may not support.

would have been set

> +
> +This topology is therefore not allowed: ::
> +
> +                          .----------. 400kHz .--------.
> +        .--------. 100kHz |   mux-   |--------| dev D1 |
> +        |  root  |--+-----|  locked  |        '--------'
> +        '--------'  |     |  mux M1  |
> +                    |     '----------'
> +                    |  .--------.
> +                    '--| dev D2 |
> +                       '--------'
> +
> +
> +This topology is allowed: ::
> +
> +                          .----------. 100kHz .--------.
> +        .--------. 400kHz |   mux-   |--------| dev D2 |
> +        |  root  |--+-----|  locked  |        '--------'
> +        '--------'        |  mux M1  |--. 400kHz .--------.
> +                          '----------'  '--------| dev D1 |
> +                                                 '--------'
> +
> +Preferred topology
> +-------------------

Too many dashes.

> +
> +The preferred topology when using different bus speeds is to have the multiplexer

There are many over-long lines in this patch.

> +connected directly to the root adapter without any devices as siblings.
> +By this arrangement, the bus speed can be changed without affecting any other devices
> +and many of the caveats are avoided.
> +
> +Other multiplexers in parallel are still okay as those are locked out during transfers.
> +
> +This is the preferred topology: ::
> +
> +                          .----------. 100kHz .--------.
> +        .--------. 400kHz |   mux-   |--------| dev D2 |
> +        |  root  |--+-----|  locked  |        '--------'
> +        '--------'        |  mux M1  |--. 400kHz .--------.
> +                          '----------'  '--------| dev D1 |
> +                                                 '--------'
> +
> +Locking
> +--------

Too many dashes.

> +
> +If the multiplexer is mux-locked, transfers to D3 may interleave between the
> +select-transfer-deselect to D1 or D2.
> +This results in a situation where the bus speed to D3 may be lower than it
> +is supposed to be. This is usually not a problem.
> +
> +This topology is allowed but some transfers to D3 may be at 100kHz: ::
> +
> +                          .----------. 100kHz .--------.
> +        .--------. 400kHz |   mux-   |--------| dev D1 |
> +        |  root  |--+-----|  locked  |        '--------'
> +        '--------'  |     |  mux M1  |--. 400kHz .--------.
> +                    |     '----------'  '--------| dev D2 |
> +                    |  .--------.                '--------'
> +                    '--| dev D3 |
> +                       '--------'
> +
> +Multiple muxes in series
> +--------------------------

Too many dashes.

> +
> +When multiple muxes are used in series the same rules apply.
> +
> +Transfers to D3 may interleave between select-transfer-deselect to D1, which
> +results in that the bus speed to D2 or D3 will be at 100KHz.
> +
> +Transfers to D2 may interleave between select-transfer-deselect to D1, which
> +results in that the bus speed to D1 may be at 400kHz as the transfer to D2
> +will set the bus speed to before the transfer to D1 starts.

There is a missing word or something? I suggest this:

Transfers to D2 may interleave between select-transfer-deselect to D1,
which may result in a bus speed to D1 at 400kHz as the transfer to D2 may
clobber the bus speed before the transfer to D1 starts.

> +
> +This is probably a bad topology ::
> +
> +                     .----------. 400kHz .----------. 100kHz .--------.
> +    .--------.400kHz |   mux-   |--------|   mux-   |--------| dev D1 |
> +    |  root  |--+----|  locked  | 400kHz |  locked  |        '--------'
> +    '--------'  |    |  mux M1  |--.     |  mux M2  |
> +                |    '----------'  |     '----------'
> +                |  .--------.      |  .--------.
> +                '--| dev D3 |      '--| dev D2 |
> +                   '--------'         '--------'
> +
> +Multiple muxes in parallel
> +----------------------------

Too many dashes.

> +
> +When multiple muxes are used in parallel all access to other muxes are locked out
> +so this is not a problem.
> +
> +If the muxes are mux-locked, access to D3 may still interleave though.
> +
> +In the example below, D3 may not interleave between select-transfer-deselect for D1
> +or D2 as both muxes are parent-locked: ::
> +
> +
> +                   .----------. 100kHz   .--------.
> +                   |  parent- |----------| dev D1 |
> +                .--|  locked  |          '--------'
> +                |  |  mux M1  |
> +                |  '----------'
> +                |      .----------. 400KHz  .--------.
> +    .--------. 400kHz  |  parent- |---------| dev D2 |
> +    |  root  |--+------|  locked  |         '--------'
> +    '--------'  |      |  mux M2  |
> +                |      '----------'
> +                |  .--------.
> +                '--| dev D3 |
> +                   '--------'
> +
> +Idle state
> +-----------

Too many dashes.

> +
> +Muxes have an idle state, which is the state the channels are put into when no channel
> +is active. The state is typically one of the following:
> +
> +- All channels are disconnected
> +- The last selected channel is left as-is
> +- A predefined channel is selected
> +
> +Muxes that support an idle state where all channels are disconnected are preferred when using
> +different bus speeds. Otherwise high bus speeds may "leak" through to devices that
> +may not support that higher speed.
> +
> +Consider the following example: ::
> +
> +                          .----------. 100kHz .--------.
> +        .--------. 400kHz |   mux-   |--------| dev D1 |
> +        |  root  |--+-----|  locked  |        '--------'
> +        '--------'  |     |  mux M1  |--. 400kHz .--------.
> +                    |     '----------'  '--------| dev D2 |
> +                    |  .--------.                '--------'
> +                    '--| dev D3 |
> +                       '--------'
> +
> +If the idle state of M1 is:
> +
> +- All channels disconnected: No problem, D1 and D2 are not affected by communication
> +  to D3.
> +- Last selected channel: Problem if D1 was the last selected channel. High speed
> +  communication to D3 will be "leaked" to D1.
> +- Predefined channel: Problem if the predefined channel is D1. Set predefined channel
> +  to D2 as D2 may handle 400kHz.
> +
> +Supported controllers
> +-----------------------

Too many dashes.

Cheers,
Peter

> +
> +Not all I2C controllers support setting the bus speed dynamically.
> +At the time of writing, the following controllers have support:
> +
> +============================   =============================================
> +i2c-davinci                    Supports dynamic bus speed
> +============================   =============================================
>   
>   Mux type of existing device drivers
>   ===================================
> 

