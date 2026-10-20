Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.131.191.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792457342;
	b=HwPUHs2tTvvm8fBqQv6k+wI+bJvJsI5S8XJJyCHdtVmRjSU7WdTLTfnktOhbLmsCX4/k
	 uNlkvCRcJtq2Y+Ugi4IgYR64YAE2Sz8Yx7dkQ2Eio/G3ODq6pC/PIn+t2WYhjSVDcYt5O
	 6+T8++8vW/qu6Nz2tsnA7+LX0iB1Nc9FaUUcdyMiTeC/zO6qSFAxYIBWDsSXWAKpbhYdR
	 W1NMOvVNbOcicnI89U9VwjgtDs2bZnZNmDnNu4Zw9zjO8oyD/HbvKMFmsZcf1MaQA1ETo
	 YY6Q5LlII12AvhJaYDFXNuGCrsiuCYtYqHkO97YrypQzMrZ7ewEfVZJaFgIucisZvpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792457342;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=J05n6Gr0/sJKA2C8cqIM/17mIypCcK1yS1CYec+efVE=;
	b=HKWHq1hn+peOl9xU5nxZ+QkH5Sa0zcfNmSJYL46omAQKeeuWN7OeQa/W/zMO2uEWIgUT
	 fbSnbTDOCN0u1ZY7z9GJa6iwEmwmS4BYeFB8kqIH4aPzcI7f8Xjz2LQhNVWOFhqlllV0A
	 3/XldBVQn+iJYiLyJYjddyAilKNdfoWYttcPLlQVl1lEZAb0Fes9u+iioU6t+3BO2DIpQ
	 1ivn9jysx5pSVT4XHDwwth7W+TAL6XSZC1YEpZUyGhGB5wgsXFb5FZbvKMTeKCK4KSJ2m
	 s/ZYs8mdwMp86y9Q6GyMHrfPzYFJyiwX7eOSD60aj00GrFcI+aUFigejqrBDzw5sV9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=D8dVqAfw;
	arc=none smtp.remote-ip=103.131.191.72
Received: from mail-m10313119172.xmail.ntesmail.com (mail-m10313119172.xmail.ntesmail.com [103.131.191.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F602606A31E;
	Tue, 20 Oct 2026 00:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F602606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=D8dVqAfw
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 519de6bff;
	Tue, 20 Oct 2026 08:48:49 +0800 (GMT+08:00)
Message-ID: <9c18acc0-2b4b-4f19-9928-de1632718f15@rock-chips.com>
Date: Tue, 20 Oct 2026 08:48:49 +0800
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, "david.wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH] i2c: rk3x: Disable the controller between transfers
To: Alexey Charkov <alchark@flipper.net>
References: <20261015-i2c-rk3x-disable-v1-1-81625845c175@flipper.net>
 <bfe8baa4-e740-4908-9d2a-4defc5240a82@rock-chips.com>
 <CAKTNdwFYxPeaG6pZn3SYoR6cPAtON37ajo4nZpPE0Hm=y2c6Lg@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAKTNdwFYxPeaG6pZn3SYoR6cPAtON37ajo4nZpPE0Hm=y2c6Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa156c84b5003a4kunmb2638d4f8a0982
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUNJVkxIS09NHkodSB8eHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=D8dVqAfw85rr9XasLOyMPAcPscEwWj2/fg2RaOjDPvEXf4fqLm8uGD/ZSzQ3zTpiFFj6KLlNJjR7nsfvCu96NGj8uYakRg6Nhc4+/VPl5wLG1mJfafFfuPY+wU2b4w0nS0/DOiy+dgG5aWf3kp6hlKptsEYkOf4oE7i5lXDhPq8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=J05n6Gr0/sJKA2C8cqIM/17mIypCcK1yS1CYec+efVE=;
	h=date:mime-version:subject:message-id:from;

Hi

在 2026/10/20 星期二 0:50, Alexey Charkov 写道:
> Hi Shawn,
> 
> On Fri, Oct 16, 2026 at 4:33 AM Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Cc: + David
>>
>> 在 2026/10/15 星期四 22:00, Alexey Charkov 写道:
>>> The driver leaves the controller enabled once a transfer completes, and
>>> an enabled controller keeps tracking the bus. If the lines collapse under
>>> it while idle, as happens when a target's supply is switched off while
>>> its bus pull-ups stay powered, its state machine wedges driving SDA low.
>>> Every later transfer then times out, since the timeout path only requests
>>> a STOP and never disables the controller, and the stuck state even
>>> survives a kexec.
>>>
>>> Clear the enable bit once each transfer is done, successful or not, so
>>> that the controller does not watch an idle bus and starts every transfer
>>> from a clean state.
>>>
>>
>> I checked the vendor kernel tree and saw another case that you perhaps
>> need to fold something similar below into your patch, along with your
>> disabling controller?
>>
>>       In some case，log like this:
>>
>>       [   12.393926] rk3x-i2c ff150000.i2c: irq in STATE_IDLE, ipd = 0x51
>>       [   12.416592] rk3x-i2c ff150000.i2c: irq in STATE_IDLE, ipd = 0x51
>>
>>       The i2c clock is disabled, so the pending irq clean is not
>>       worked. Disable the interrupt after the i2c jobs were done,
>>       the error log would not happen.
>>
>>
>> /* Disable i2c all irqs */
>> #define IEN_ALL_DISABLE   0
>>
>> i2c_writel(i2c, IEN_ALL_DISABLE, REG_IEN);i2c_writel(i2c,
>> IEN_ALL_DISABLE, REG_IEN);
> 
> Thanks for looking into this! Do you happen to have a reproducer or
> any additional info on how this state gets triggered? I haven't run
> into it in my setups - did I just get lucky? :)
> 

Unfortunately, I don't. That came from what I found when checking
the vendor kernel commit to see how we handled your case.

So I have looped David who made the internal submision for the same case
as yours 8 years ago and hope him could have a comment here.

> I see the same write of 0 to REG_IEN just above my changed lines for
> the case if (time_left == 0), which makes sense because a
> too-long-running transfer might eventually complete and trigger the
> interrupt with the controller disabled, unless the interrupt is
> disabled too. For other cases I'd be interested to know what can raise
> the interrupt.
> 
> Best regards,
> Alexey
> 

