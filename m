Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386505;
	b=1MuBCdm4GCDr52Z1s4XORSNMQ3yZlwJZft9Nqu9F4D9TTUJPtc91VvcMm6qyMF6pu1TQ
	 nsnn8R8QUuIvRsnzmtyS0Zst2HnOhb3LdZMD4KhrlLtMjh3vk3oQiL4a8LLXYTGoE65K9
	 FZvbfi6gmZmP5yXZFBX0ZQuwVvD+TEqudbRw98noqDf4UzuhjIRRKQ2X7bCNq4BvqpjWX
	 2E24yQ9b7Ptq/JWmG/6a79rp3lAloFsEyEiJfISexxbgCF9tswvSmRNcj50MfuQJ1bP2W
	 TUy/GNyXANBKKF4qG+FJpOdHdI7oWQ3U8UUalL1tZQ5ucxfmox41XWNvgFatCbHGMCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386505;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9KQQ3MjJIgY9DKMpqHoAdZ9dgCXvyAkuy+xEhirgwpE=;
	b=zw0WXJjngJiv5HzDGkncqyX4KEqD8Dt/BC8wUTYbweRJoTqjEcImUnOEUlL/M4JADniT
	 QOduD5GqfiPIOwNSBoi0t8LZqVw+11bI7wRTCw4oTJ/yxWLkEg+YBokFUALfr0j18Hxqx
	 6Nqtp1Zm0NDBKBxN0ul9CDUF758VKF+YZkjjC1sWI1X8JjHbJ34VDZ0k/BRJk/vdtIyk+
	 3H9zAIYbUETjMP6GB73ADmHljRqA0BkFBpajXJm5Jlr5f6duZaEwdDti3y/XJmfBM9+Oz
	 IPI3tT8BYp6FHx4gAspk6009PmHIRZ3eIfRi3HpkCdMaUo++9IPrjgojtGm29LWqbwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUd0s6IX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5D606A32A;
	Wed, 11 Nov 2026 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUd0s6IX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326071F00A05;
	Wed, 11 Nov 2026 08:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794386505;
	bh=9KQQ3MjJIgY9DKMpqHoAdZ9dgCXvyAkuy+xEhirgwpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SUd0s6IXY1E1nvv2mVfy5r7Jh95iT2P+imXJg1yFfVxk1wPDIvimvrbLAU1oSLLed
	 3VE1PwPcbLNx09fEzKM4D4F+VHGgKHxSwGMQe1a9ctTfpngjSo1j2yHGb60PprkwNK
	 U6QVLa/67V0JRJm1W/uxnBjKRX2+vLHn2VFQDNHG+34bWSzoXVDKOc2hIMwZjetZbZ
	 33U2U8OV20pcJqHMsiqDJmAZNtirbPgyPCURiIo88us1hoX91nomYNwzgMb41RzCOr
	 DCcpO/EN/gSNtOBrBigAWfRYGFf9mVoAia0BWCDjHVaXl2rGbp+RVvLw/wG4IZU2O2
	 2PCx1OIHrezDg==
Date: Wed, 11 Nov 2026 09:41:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Aniket Limaye <a-limaye@ti.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lianfeng.ouyang@starfivetech.com, s-jain1@ti.com, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add Synopsys DWC_i2c controller
Message-ID: <20261111-smooth-meerkat-of-judgment-dbe8bc@quoll>
References: <20261111-tda54-upstream-i2c-v5-0-280a4a779b24@ti.com>
 <20261111-tda54-upstream-i2c-v5-1-280a4a779b24@ti.com>
 <fc1fe51e-952c-4c8f-8dc1-fb832b03943b@sirena.org.uk>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc1fe51e-952c-4c8f-8dc1-fb832b03943b@sirena.org.uk>

On Wed, Nov 11, 2026 at 12:05:15AM +0000, Mark Brown wrote:
> On Wed, Nov 11, 2026 at 02:05:48AM +0530, Aniket Limaye wrote:
> > Add documentation for the Synopsys Advanced I2C (DWC_i2c) controller, as
> > found on the TI TDA54 SoC.
> 
> > The block cannot work on its own and needs SoC integration, e.g. the
> > FIFO depths are not discoverable from the IP. Do not add a generic
> > compatible and only list SoC specific compatibles. The file is named
> > after the IP so that other SoCs integrating it can be added here.
> 
> I still think we should have a fallback compatible here, while we can't
> discover the FIFO depths all the uses have a programmed trigger and we
> know the minimum depth configurable in the IP so we can fall back to
> using that.  This would be useful for distro kernels, it's one less
> thing that forces using a kernel with specific SoC support.

If the driver does not match on such generic compatible - and that's my
impression from commit msg -  then it is pretty useless.

Best regards,
Krzysztof

