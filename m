Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139D3FCB39;
	Mon, 29 Jun 2026 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726587; cv=none; b=DudvlWMAjduu+Blf5zoLLd0kEVJTtaA1/2p3bCKSxfAbP4oF0oN2MpOc+lnlumpiaXL1XCBQReRkUvZoRxi71QhS4OFro2X+emFcbhMEVavYA5ylnHUHwa5khrpyNJF9teKrRMn8a74AbI7EFDzHjz0Zd+d87tetfOEkPdoBmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726587; c=relaxed/simple;
	bh=dzRbVYUSWwBBcsbVQahHfQdA8PMfom2rk3ld6Gp/bOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmK+PF7BlzLWNKn35KhLvsgL0KXmOfwb5Up1ZwqoWI2HZnpyJjzMPbCmbFSx/EF0WDmWjZL9cnt8oLurHK7NmMbgGjBP4T19Np14pUar5xnxy/PIOairzkZo36Vgk4YS5IiCcJ4zluH6KG0p9lRmlbyNFKUJnJB8w6RpCVfP77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/F+hdng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/F+hdng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463F31F000E9;
	Mon, 29 Jun 2026 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782726584;
	bh=sw4XLSoR7/V4T7rjEhACtMH+3SJRYOENl3sMiaCJDWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K/F+hdng089QWy5WR0+i1xzkKD4eKOS3/rX7bhUI0MFj2yCByUPUozFZSPVbqkPEa
	 vK9aw+Nn4HbTGl5eSYij3N2N9GzGmtF9mnF5xgAimfZjschwfYZ4ztSuA5jeqBwj6d
	 l9C2hhZWXIupOWULlxTXTkRGyc+I6QRWLCl0pdvW3S6LsbVvXer4OzluLWA+b9B2qT
	 +WX49WJqe81XK6jTJoUJAG5a6Br9+gL9v/ici+FR/jEamFfe4KlvOHKAe6N0sRwqC6
	 44clDF0sOdvWupdTmoRd+xKcskRWdLXjFPLCWdFYHx+dqWkFU6K3LitSt/5UQ0n0Yk
	 0V/3Bkk+adz5A==
Message-ID: <22e94aaa-0c11-45f4-8317-204ac4be66ec@kernel.org>
Date: Mon, 29 Jun 2026 11:49:38 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: w1: ds28e17: possible out of bounds write from a device length
 byte
To: Maoyi Xie <maoyixie.tju@gmail.com>, Jan Kandziora <jjj@gmx.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <178177668382.3462209.6459868495361731106@maoyixie.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <178177668382.3462209.6459868495361731106@maoyixie.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2026 11:58, Maoyi Xie wrote:
> Hi all,
> 
> I think w1_f19_i2c_master_transfer() in drivers/w1/slaves/w1_ds28e17.c can
> write past the SMBus buffer when an I2C device behind the DS28E17 bridge
> reports a large length. I would appreciate it if you could take a look.
> 
> On an I2C_M_RECV_LEN read the driver takes the length from the device.
> 
> 	if (msgs[i].flags & I2C_M_RECV_LEN) {
> 		result = w1_f19_i2c_read(sl, msgs[i].addr,
> 			&(msgs[i].buf[1]), msgs[i].buf[0]);
> 
> buf[0] is the length byte a previous read filled in from the device, so it
> can be anything from 0 to 255. w1_f19_i2c_read() only rejects a zero count
> and then writes that many bytes into buf[1].

That's exactly the bug AI tends to find... Easy to spot pattern and then
figuring out the logic leading to it. Maybe it is real, maybe not, but
the AI feels like too big threat of wasting my time (and you did not
even disclose it).

Reading based on length supplied by device is of course risky, but isn't
the rest of the master_xfer implementations doing the same? IOW, what is
different here? Or they do not do it, so you have the answer to your
question?

> 
> The buffer the SMBus core hands in is I2C_SMBUS_BLOCK_MAX + 2, so 34 bytes,
> with msg.len set to 1. A device that reports a length above 32 makes the
> read run past the 34 byte buffer, up to about 222 bytes out of bounds.
> 
> The SMBus emulation does check buf[0] against I2C_SMBUS_BLOCK_MAX, but that
> runs after the transfer returns, so it cannot stop the write that already
> happened. A compliant bit banging adapter rejects the over long length
> before copying, in i2c-algo-bit.
> 
> The attacker here is a malicious or faulty I2C device sitting behind a

Malicious DS28E17? Feels like AI convinced you that it is a thing...

> DS28E17 1-wire to I2C bridge. It controls the length byte it returns.
> 
> I reproduced it under KASAN on 7.1-rc7. With a length of 32 the write stays

How did you reproduce it? Do you have ds28e17?



> inside the buffer. With a length of 255 KASAN reports a slab out of bounds
> write past the 34 byte allocation.
> 
> The fix I tried rejects a length above I2C_SMBUS_BLOCK_MAX at the two
> I2C_M_RECV_LEN sites, before the second read.
> 
> Does this look like a real bug to you? If it does I am happy to send a

Did not investigate enough to judge. I am sorry but my expectation is
not to investigate AI-based reports. Expectation is rather to get a
human created and human validated patch, regardless whether human or AI
produced the report.

Best regards,
Krzysztof
