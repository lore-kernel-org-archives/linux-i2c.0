Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716271;
	b=FzFS3ygexJZrFaW1je6CGWPBJE0VQERhYSv6b8BJ0hHugR/k/1YE6KQB7sGdTApjpAH2
	 SnhLm7xEBp1JpgSsV3PqNkLs0pBort9z1eifHSy5dobWz7FZWjc+ZmUToVh4Kvpa26Run
	 ArViGSf10x+Fk1ZSe3YqlxAwILvqYuF5KtAq+A3Bpg20ebqwc5gY//hFyyCrm52vebRYl
	 6jpeF27RTwc0SgsLqRrQSSRY1Q7DGhakt+TPIiKsFi5kNQSMgu/eKH7o0jrL60C1qnrxb
	 spbWriqqNKWTJj4yeQ2BD2ixBBqO0KdNCahCNK+jg0QdA8w4l58G6jHbladyS7bVHOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716271;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=1c5PCbIwwV6vQj5//fN+ktrM/G6dDkpUjrvlgV4uuqc=;
	b=cz0Op05ubAv0q7ASVPuyY1EOsb/a8oUPzqV1OZIPekyt/Q5vKXYJQNW6tvr1ZyYZ1YCX
	 aOjWoroKLVKgVhyQVlmJdYax94xgw75o+N98LwitxpXyMy16jg+ccdpxY7SiAzlE7cnEV
	 rlXgdravmHqcadjDPNgU5ZVP5EUJfdfd47+E1X0UyavkCKJ9CQ3hDtZTTEgbBk5FyIwjc
	 LBqCSdwHp2rgXkFexFjzluCBrvAxWIhIFtgxv9zTWZ+CRnigUxhqzGbO4Er75NEgGFAY0
	 je1oZ+t5YAib/NfbmKWStXLX7qsy9DaQEjzNfiLFrBbPi9S3WQQj3O9JA32PwkJFL3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="1yEXqF/A";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B09606A31E
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 18:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B09606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1yEXqF/A
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 630264E417AB
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 18:04:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2981860558;
	Thu, 26 Nov 2026 18:04:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED06F11E69016;
	Thu, 26 Nov 2026 19:04:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795716268; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1c5PCbIwwV6vQj5//fN+ktrM/G6dDkpUjrvlgV4uuqc=;
	b=1yEXqF/AvWVGxDC80ZsqgZJgPjMtRtg+ger1/TeF3eFPH/8UyuB8f8Iwv0O3KAOVg4S8Kz
	XdsUwf2RUkOy4OOTVrgJyCxjwPJQ/qBawTLHUupzmsi5YdlpTS5Qn6/MdCF4Aj4kgg1g5y
	6HIUJTHqIYXGSCIM/S19bBjs5p9ac/OKPvqUag0+HImxb6JkcncYWfhPWwNIQKo9jskPdv
	XTKnJDTESorub4cQtkPQcSOa58ZHZF0FgmpVcGkh2noaKSX9s6vgedl4W6EntEK2y0XjD5
	VHjqRzbkzJ9gWKm65mXutWoAcihLNbDi1ds3BJfCibZ7LZzWP0ksotHJi1e0NA==
Message-ID: <ef2953ba-1510-4bd8-85c1-81d4e45d2693@bootlin.com>
Date: Thu, 26 Nov 2026 19:04:26 +0100
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
Subject: Re: [PATCH] i2c: cgbc: Fetch the status of a write transfer
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Markus Haberlander <markus.haberlander@rosenberger.com>
References: <20261123-cgbc-i2c-write-status-v1-1-5b0fa0322b57@rosenberger.com>
 <179568834099.302193.16315749597111506309.b4-review@b4>
 <awgwO98qx3zX4MaY@zenone.zhora.eu> <awhxAlhwF4QF3V6a@zenone.zhora.eu>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <awhxAlhwF4QF3V6a@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/26/26 6:49 PM, Andi Shyti wrote:
> Hi Thomas,
> 
> ...
> 
>>> Yes it conflicts (compile issue) with the series [1]. The possibilies are:
>>> - I pick this patch in my series and send a v7.
>>> - [1] is applied, an immutable branch is created, you rebase your patch on
>>>   top of it, and patch is applied in I2C tree.
>>> - [1] is applied, you rebase on top of mfd-next, and your patch is applied
>>>   in MFD tree.
>>>
>>> Andi, Lee, what do you prefer?
>>
>> Let's wait your patches to get in first and then Markus can
>> rebase on top of them.
> 
> as you are going to resend your series, would you be so kind to
> include this, as well?
Yes no problem. Thanks for the review!

Best Regards,
Thomas
