Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D24BC00B;
	Thu, 23 Jul 2026 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815494; cv=none; b=fxF8lMzjNmUiF9oazzE1bfBf2ch7GDc5tfAZb/gRU+2GRpRRFUQ6EvO1WG8yczJc8dCUedwkqulQaUFX2iCZl47D4Vr2He15JHTo4y+S4v4QHlLrcIOolYZalppbUFkpahOHBBbiGQPDJ42swrA1vEAsKfbmxplcIdBn6tFAT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815494; c=relaxed/simple;
	bh=lwpQgSr5i107bmp5QM0W4QnHp/84z/4JyZveaHiwaKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7Trl5uQiarDZJF1/pJokv8MdmOk47T6CtGvwUw69tXq12RVj8TRb3s8rv0Dc4hMubHQzrNfhSCDwwWS88GpBEPBgGAOMC25/QaSxTAOtn/rZloPk6lVJZ6e5Os+Zwk/AtR3BtSAnyZlBnNUOvfe+OQq3ft+g/ZiQcvXftiM9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=lO24t3jD; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=ROQOgbRv; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=od53DPNg; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="lO24t3jD";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="ROQOgbRv";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="od53DPNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784815481;
	bh=lwpQgSr5i107bmp5QM0W4QnHp/84z/4JyZveaHiwaKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lO24t3jDJpON5vTV94+JWgJurcrlWmgFOkqcp2kV90E9JthYaBQATpmHE/OhzE+JO
	 Ytr7SbOqD1ji/ZUSn3QEvu9D/Af6ol9FWdnbRslnHoz/FyAfMQrCS3oifX7vJUoyo+
	 OT/4cHAel1EERQPrq9nUHaBeOq5qNKPcktPLdCgg661cnlYcpczh30n4HTFkaLAcW2
	 fO/HISmSk8+RQX2qp+so4fLyyWKKIxvLiFuJlZaErUjbm2QTnPD3Fvv2Qe6DedpAns
	 VvVQA3taXTM3yiirHZ85+9Hdjndx3OQ/40G32RzsjVwcHCK3pck8BgFSHJJ4ZwWHOv
	 2I/An3VmZJHqA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 271141C346;
	Thu, 23 Jul 2026 16:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784815480;
	bh=lwpQgSr5i107bmp5QM0W4QnHp/84z/4JyZveaHiwaKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ROQOgbRvAXYqrcTtV1TkTemMJQ0q1Uqv+CTRXSMDQ9+E/OnNvyYQtn5MCVH2B5Mqm
	 kvYQPYe/EqfjYF8IwZMtxEDWV1IvBYvoaAcaaKdoaxaW/qnP9+oF1+UJgHqF8CfLMJ
	 OiPT3+jX1MKq2r+yv3j7zWW3FWA1yQ4J4Z5cGzRsSCOa5KVIt5N/NYYqazDgXrvyoY
	 twYeIcbw5igiWnEbxeuiiV6lvmRR3mlw7loFvUVLEdF9ElFn0iCg8/kXL0FnSIM/HC
	 CaPiJBpuZqooOeaLxf2IsWL/rtzpfeFdZvCL8vCT8dz7zxh4zbc2F8emORQvyQZHun
	 G1cp+yHxD5+Yg==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id EDBDE1C40E; Thu, 23 Jul 2026 16:04:40 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784815476;
	bh=lwpQgSr5i107bmp5QM0W4QnHp/84z/4JyZveaHiwaKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=od53DPNggVoiafmfJczBj/crzaxdLcD5ZM8fIJDk5NmmYp4nYEkkwWyvsMoGtJVv6
	 E6YjJSPaDcAPQMTcV+Xnd7459ovUYnAhmeTZXpNm0UqaImlb1FLCoa0z077+rNhmEE
	 xmREHdtT37hjCa/2a1NFrJKfwIF5D+gXxMqTg7xzaKVe8hd8LSpvcdFyBIaMIx1zga
	 Nd0MDlU3lXMtI/5izSc5ORyfUzsIrYWM2DJazgVTYL6jzvoDTeaEx/57JlqYPDbn9u
	 pFqr+GyvN+ecMJUNbwG2v0zP3G72hiBUZ9Jh7FMrcetR9oX7dmgpWz8c3LqtLe+58O
	 APGP9maR20Kgg==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id EB28B1C2F4;
	Thu, 23 Jul 2026 16:04:35 +0200 (CEST)
Message-ID: <924c6d04-c05e-4ddf-8229-574d891e6d83@lysator.liu.se>
Date: Thu, 23 Jul 2026 16:04:35 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/7] i2c: core: add callback to change bus frequency
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
 <20260719-i2c-mux-v12-1-a5010d623a57@gmail.com>
 <19dbf4be-5f17-46b3-924d-eb24ae41fdd9@lysator.liu.se>
 <amH8vX-M6lAWajQ_@gmail.com>
Content-Language: en-US, sv-SE
From: Peter Rosin <peda@lysator.liu.se>
In-Reply-To: <amH8vX-M6lAWajQ_@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi!

On 2026-07-23 13:36, Marcus Folkesson wrote:
> Hi Peter!
> 
> On Thu, Jul 23, 2026 at 01:03:53PM +0200, Peter Rosin wrote:
>>> + *
>>> + * @set_clk_freq: Set clock frequency for the adapter. Returns the actual set frequency.
>>> + *      This function is optional.
>>>    */
>>>   struct i2c_adapter {
>>>   	struct module *owner;
>>> @@ -742,6 +745,8 @@ struct i2c_adapter {
>>>   	struct rt_mutex mux_lock;
>>>   
>>>   	int timeout;			/* in jiffies */
>>> +	u32 clock_Hz;			/* bus clock speed */
>>> +	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_Hz); /* Optional */
>>
>> To expand on the comment from v9 by Wolfram [1], I too think it
>> would be good if this function pointer did not live directly in
>> i2c_adapter but instead in some other struct so that the actual
>> pointer could live in read-only memory. I.e. if i2c_algorithm
>> does not fit for some reason, a new function pointer struct might
>> be called for?
> 
> My objection to move it to i2c_algorithm, was mostly based on that the
> algorithm should not be aware of the current clock frequency. When I
> reread the comment from Wolfram (and you), I realize that we are only
> talking about the function pointer, which is fine to put into the
> i2c_algorithm struct.
> 
> Sorry for the misinterpretation, I will move the pointer to
> i2c_algorithm and keep clock_Hz in i2c_adapter.

Please note that the main point of moving the function pointer
into a struct is to enable instances of that struct to live in
const memory. Thus, if you add a random function pointer to some
unrelated struct, users of that struct will likely need to set
up their own instance with the needed mix of hooks. That works
poorly with the generic algos in drivers/i2c/algos that export
i2c_algorithm instances. If you need to manipulate .set_clk_freq
in one of those generic instances, then they can't be const.

Hence, it might be wise to put this new .set_clk_freq hook in
some other struct with function pointers where it fits better. If
no such struct exists, a new one might be needed?

Cheers,
Peter

