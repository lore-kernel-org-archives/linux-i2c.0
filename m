Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530401;
	b=Mk5V/MBHPCjZiUbY6W8dgMEkFyx91zPJlM86lUyI/ATzJA3oJUHCdJFHB2vIPJ7hvn/G
	 DSHy8Ho8lZDzIaaWrWNw4kgWyXDTlBfohiD2zkpb82JxnZtbXHJOil2M6OQkKCNJJJp8p
	 +npO0FKqsA/Sbp8J48Cn1q2Msblla1H3RPCqx14tCcSlI52/zC1CFifTe1/Oo4XkzplCT
	 PiGLYHzJLm2OonztfpnMblp36TSiGPTa2/t0rbNYJpayPdO0g6ScFWb8vHZQtEqw36giy
	 ZyHVjDdAEXSHc/fMjIQBtOuHmYHkPfrBi2nbW4D6uCQ/u0r2R5h+vBntK7W77a1S+OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530401;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eudeHbG6Q+7oXe06t43nAu8K28jSi/HhXLZbGMSKzy4=;
	b=h+FEn/GTepa+b5QRLIWqJU0eBHaT2m5UY9gTwXfhc6hM4TRk6Truzf4KV2dAZMYuzQLI
	 2kQmd3meTtum7G2YnbtRrIO1RhsTlkrydaYzZPLBiE30qvnMC+1VOHgd18NuLvBcenNHk
	 eF7nm3ilW7TL99/FoR7iNVCxJohZ69b3wi4IRLB5qUWcDGwzDwZYN+weOAalAslpWm6of
	 BCW0FS+oarTXyPtCShRdDdacaszmCWXznm9oM2+jd1aiOmlXUU0lGDkTYou2NyUQzzMPt
	 9pegd3ke5Sw2kfBX0tOMBmWhJdnZmBUd5I5UV90fHPm/TRWRkEaOdnf1ioYaweOeUYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzmzboAS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D051606A31A;
	Tue, 20 Oct 2026 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzmzboAS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19281F000C9;
	Tue, 20 Oct 2026 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530401;
	bh=eudeHbG6Q+7oXe06t43nAu8K28jSi/HhXLZbGMSKzy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PzmzboAS6hDP/7l5weoAm5lQEKQyO4t5TwvgWCLKsV13M+PmyHaPj96IQo+QmyTVH
	 rqeRQ+wBalo6BcOc10zvMCbYJN+1zqLiut/Xy+hgzHNGBlWqaoRbBlbznw0hs6QNXN
	 Kt+deUpQqtlWqBflW4vuXhZN2WghfP6Yw2K1D8amGa/iMfyFYFZqen3asmckyCPLqI
	 3rcLNOik2mcp1zfgCsFU6k09JWKWhXCMaZT0XFpquZ517wUOswwaOBRuGV4JfgUwrJ
	 2RbBglPmQc1PaqZ9pyP09b8PiC8q9PrZf/ddbsHhkR8nu3NziZerEIsT12N1hx/Mb1
	 KYnLuzqDgqotQ==
Date: Tue, 20 Oct 2026 23:06:38 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: size the RX FIFO threshold to the
 queued transfer
Message-ID: <atfW-paFf_iyBhRE@zenone.zhora.eu>
References: <20261007191911.502428-1-navonjohnlukose@gmail.com>
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
In-Reply-To: <20261007191911.502428-1-navonjohnlukose@gmail.com>

Hi Navon,

please, don't forget to Cc the linux-i2c mailing list.

On Thu, Oct 08, 2026 at 03:52:31AM +0530, Navon John Lukose wrote:
> i2c_dw_xfer_msg() leaves DW_IC_RX_TL at the 0 that i2c_dw_configure_mode()
> writes, so the controller raises RX_FULL once per received byte. Program
> RX_TL from the reads already queued, capped at half the FIFO until the last
> message is queued, so there is room for the rest.
> 
> On an Arrow Lake-H LPSS core with rx_fifo_depth 32, a 22-byte HID input
> report costs 2.00 interrupts instead of 21.43, and a 452-byte descriptor
> 0.14 interrupts per byte instead of 1.64. Polling the touchpad with
> HIDIOCGINPUT at 142 Hz draws 1.58 W less platform power (psys, 32 paired
> runs).
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Assisted-by: LLM
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

pushed to i2c/i2c-2.

Thanks,
Andi
