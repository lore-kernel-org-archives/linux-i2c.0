Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FC63AE188;
	Mon,  8 Jun 2026 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943270; cv=none; b=uMOQHuCWkaZoU+lZkYKGaRQcT6URmyQP8nhNpx009I8rXiWPhOjCnVfXyCE6TFq/8tmoUgRldzyeQLRIajncM9bmL/6H6DJwaVVS9G96ekljTqO6WUq+Mxvdx9kKo5vzqXKHEN6wC3nRRjkB+s+9oEcOdo3G8aGVCRlMZCg+oRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943270; c=relaxed/simple;
	bh=MepHw0Qn7K6BWHhBdAiV2HJPxaAloUNb+rIcStwZILc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn64GAgZBOpQKGk9CGzHmXMfHhXw+CA6B66+aQmm9EkV6vELY5Oc9uHCRW23rW49IBAfz0Cd1DmSadxGbfVYDnoprygII1O8p/t1OmWIZlNp8L74EDtdiWdtJToSwbAqWOFCAR2GcKaqYLrBulJ9S8PdRsLEICZzMME8GnT5GBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH0B0Usv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH0B0Usv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D931F00893;
	Mon,  8 Jun 2026 18:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780943269;
	bh=vv7cu92kT3EkQWt1MwDwvI+WPcoEimPtartjkzaIjvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GH0B0Usv2O9RNKcibpuQKE0FRIIdkXX5LrtIy9hWwY4fUZzmJTuHa4TTW+IEN5dbo
	 cOd3kwRdzCruY+Iw8tKdVApAXwftecEf5p61znQUqNKkIr7MfxvP6z9yqlwHdhEqPR
	 tNjdbgSPN1L2Z91VnEL/6ULEa3CrDQYc9NHbyTkxmvEF2GYlQxm6fsple817pNUdEU
	 dRbuzJwerNQUEsRstquEiQWpqT71r1W/FUK+OHMSzX+DNfKXH2z1GktyRovuKYLUwt
	 8t9Y8FsnqhljjeJogaWtnoiLHHXOIH2phr/Sij4coTbBZrD45hVoPNu6OFWKP1QDBt
	 sSsSBHpTpQHxQ==
Date: Mon, 8 Jun 2026 20:27:46 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Guillermo =?utf-8?Q?Rodr=C3=ADguez?= <guille.rodriguez@gmail.com>
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: stm32f7: fix timing computation ignoring
 i2c-analog-filter
Message-ID: <aicJig0ySoUV5pw1@zenone.zhora.eu>
References: <20260526091210.20383-1-guille.rodriguez@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526091210.20383-1-guille.rodriguez@gmail.com>

Hi Guillermo,

On Tue, May 26, 2026 at 11:12:09AM +0200, Guillermo Rodríguez wrote:
> stm32f7_i2c_compute_timing() uses i2c_dev->analog_filter to pick
> the analog filter delay, but i2c_dev->analog_filter is parsed from
> the "i2c-analog-filter" DT property only after the compute_timing
> loop in stm32f7_i2c_setup_timing(), so in practice the timing
> calculations always ignore the analog filter. On an STM32MP1 board
> with clock-frequency = <400000> and i2c-analog-filter set, measured
> SCL frequency was ~382 kHz.
> 
> This also affects (widens) the computed SDADEL range. At high bus
> clock speeds, this can select an SDADEL value that violates tVD;DAT
> (data valid time).
> 
> Fix by parsing "i2c-analog-filter" before the compute_timing loop.
> 
> Fixes: 83c3408f7b9c ("i2c: stm32f7: support DT binding i2c-analog-filter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guillermo Rodríguez <guille.rodriguez@gmail.com>

merged to i2c/i2c-host-fixes.

Thanks,
Andi
