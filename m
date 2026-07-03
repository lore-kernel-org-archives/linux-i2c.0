Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0326A1AC;
	Fri,  3 Jul 2026 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071953; cv=none; b=M/Z7BD2ZNcHtdRHVebi2SW5+66dKAhaOxr9JtkxcyCCGZR0kvP3FWxZYHxz7ivnwsPSqD4NzpZDCkjmUMC2akXx1ZqFp7pVc8k43EhgigzHtpgnxUHZUcKVO3jNjiLpk1c2y1CzIjpyGFaxPWyEWSoBwSGFkfRoWXsQP2IvzXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071953; c=relaxed/simple;
	bh=Gt/wi8KhGEZG/QsbB1hynmjPS+OMGzs8UdYI/IqTE9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OideXaY7+uk4kEjBXUeNw6h04A0t+PqyN3rt7p5kASwiIgWu6sDD5oj1PNgIUvEVDkMpwUkAws9CHBymmei+fDWiVZWwuOzl1PZ/qy9neCtY+NgiI2/V6Wb/zS3XMcIqBAcHVYJ55L0PHXwiiWISa2saKQZG0xNBq4cwYdyHUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRRxajaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRRxajaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F33B1F000E9;
	Fri,  3 Jul 2026 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783071951;
	bh=i6zmU7ZKtBC31Kx8Urv3gOtWVbDemf5J8VgeEodIfes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lRRxajaW/N9xo8z/TgeWg+MkVrOmeKy87xbU4jRRJSpySHlk062gk/RNmmZyrNH7S
	 AcqQtKAip/VSKE/gH/5sOATowliCJdLrEGHGvitPvUNIlv1mSq5DdGhtjG7RKKNXqM
	 etG2LduR9lP/mlnb9WQwntseqdbedM0bfPGepb3dTZufoHtpeJqUX4wd1Ig3CFL70P
	 O3yU5dId5kmkHRUPGxcLAms3BzzamYr4JxgoDHjLwr6BowqasOGy+3sde0K06vJp59
	 WklKXfOO62X7zbkaz1nPW3YTwzPfunToLlUn+n5PknjJ3S198ZWLgQXBKpFlRTV6G1
	 8IE4ooG5d50/A==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jan Kandziora <jjj@gmx.de>, Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260629121043.199487-1-maoyixie.tju@gmail.com>
References: <20260629121043.199487-1-maoyixie.tju@gmail.com>
Subject: Re: [PATCH] w1: ds28e17: reject an oversize length on an I2C block
 read
Message-Id: <178307194894.60311.427647800864172952.b4-ty@b4>
Date: Fri, 03 Jul 2026 11:45:48 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 29 Jun 2026 20:10:43 +0800, Maoyi Xie wrote:
> w1_f19_i2c_master_transfer() is the master_xfer for the DS28E17 1-Wire
> to I2C bridge. On an I2C_M_RECV_LEN read, it takes the length from the
> device. The downstream slave puts a length byte in buf[0]. The driver
> then reads that many bytes into buf[1] with w1_f19_i2c_read().
> 
> buf[0] is controlled by the device and can be 0 to 255.
> w1_f19_i2c_read() only rejects a zero count. The caller buffer is
> I2C_SMBUS_BLOCK_MAX + 2, so 34 bytes. A length above 32 makes the read
> run past it, up to about 222 bytes out of bounds.
> 
> [...]

Applied, thanks!

[1/1] w1: ds28e17: reject an oversize length on an I2C block read
      https://git.kernel.org/krzk/linux-w1/c/487eca6535cab91944ade06a155e9d789591a1e5

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

