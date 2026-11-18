Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008143;
	b=a2K6+jhCBBAOyvAV5k8U60BWs39lSpG6SviOSvYdfnRb8GGODh3eyae2yo4D15bpuQGj
	 oTFOQ20hT4QkMIH2gDz5wJAewvW217g0SjdhxWqTmCPGd2GiSab8MuOifVYQ7Dqh+qzvH
	 IMbfAJVmTX79od5xS0zgXek/Dvmn1A9dZ6bLQZxwbcGNPhRi8KEHLiz6AzoS8xIhUWSbw
	 5EL1xTETcF48lIk0b+r481Kq07KOpJPtXxocJ535gYqHWdXSnkiNdRVBKP6HQZ0dTrULm
	 MlbyyqttePZ7otwpEdgVZBQmTUfsZCmlMZtIUHp5KLQvQptAyB3+2TyCEHoLnB/tVSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008143;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TqxF3+Nzkhor0rRV99EpRxde5TNqiKQhUCDZraKCV58=;
	b=aLY3zp9/MzOh4D2jprVXTTPBvZ3ZWDgCptfHCz64MPPScMzdviQqsKZHLeUtopommmq5
	 +ckh5RW0GVe/FhP9KuIN7XbFJSBtX4G3AxtESUDV+r1m4sXSO60cZnEYymHVdVW48fwE1
	 ds+H7GJTsPeUvSCNhi49NRNdJFZ2lXECJe2p+mCxm3BgzmYsyrM5McZ2K1xJqDfJZFbwq
	 IO2JiBKeLPWgvLGvNTllV8KrdbhdMhJusERuctY6xqXY2y8GdqcO9qvMqY8HIbXtvRxY4
	 nn6jmzA+4GDRtlMKCpQy5AV0uInguAwJW3Mi7aLQ9GFH7zs34TyTOFCh6kAMiIRTFYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DO7hJg5G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E16606A31C;
	Wed, 18 Nov 2026 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DO7hJg5G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1625A1F000C4;
	Wed, 18 Nov 2026 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795008142;
	bh=TqxF3+Nzkhor0rRV99EpRxde5TNqiKQhUCDZraKCV58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DO7hJg5G8BIHWFi6/7b2uzjMxE/9ta8tSvSUfg7HxZBnJnNGeXtuVAoZPQbli8kol
	 PCPm2gbN4W3FUcxJ+W2rGlxce+s47yRimr3CBF1e6V4RhmZCJIkBlQ1vWqb3gTLBeJ
	 3hkaHnXcIhNUqORVq8LcNQvO+JQZMr7OmmebQKThtyASTXujFzAlskwxF5mbIBbRK9
	 NHglysLUV7zJmslzzbPQAbXFhq+CQ5f9K+G86qUIbMJ25RBTRlxOdLHFJ4O4S+6IMz
	 +ZlH2FPpa9gK8Qh25U3eVpvzxcd8H2W5Y3NXK+30x3mYqFzyaV+cO7H2sCY/aA25Ej
	 eVFrqmZD+bsRw==
Date: Wed, 18 Nov 2026 14:22:18 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Thilo Zirnstein <thi.zirnstein@gmail.com>
Cc: michal.simek@amd.com, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH v4 1/2] i2c: i2c-xiic: fix clearing of bnb irq
Message-ID: <av2jSyTFI1VoyGSU@zenone.zhora.eu>
References: <20261118101147.3350796-1-thi.zirnstein@gmail.com>
 <20261118101147.3350796-2-thi.zirnstein@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118101147.3350796-2-thi.zirnstein@gmail.com>

Hi Thilo,

...

> +static void xiic_clear_en_bnb(struct xiic_i2c *i2c)
> +{
> +	u8 sr = 0, isr = 0;
> +	int ret;
> +
> +	isr = xiic_getreg8(i2c, XIIC_IISR_OFFSET);
> +	if (!(isr & XIIC_INTR_BNB_MASK)) {
> +		xiic_irq_en(i2c, XIIC_INTR_BNB_MASK);
> +		return;
> +	}
> +
> +	ret = read_poll_timeout_atomic(xiic_getreg8, sr,
> +			sr & XIIC_SR_BUS_BUSY_MASK, 0, XIIC_BB_TIMEOUT_US, 0,
> +			i2c, XIIC_SR_REG_OFFSET);

this is a bit of an overkill: you are forcing tight loops for
1ms. If you consider that the minimum wait is 1ns, in 1ms you
will end up busy looping a lot of time. Please, don't set the
delay_us to '0', but calculate a proper waiting time between
reads.

Andi

> +	if (ret) {
> +		dev_err(i2c->dev, "Failed to clear bnb\n");
> +		return;
> +	}
> +
> +	xiic_setreg8(i2c, XIIC_IISR_OFFSET, XIIC_INTR_BNB_MASK);
> +	xiic_irq_en(i2c, XIIC_INTR_BNB_MASK);
> +}
