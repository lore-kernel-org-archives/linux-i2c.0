Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228935674C;
	Thu,  2 Jul 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010346; cv=none; b=LLACSM78wlQOrotCS5Eztuf9AWAPnrPtyhzQxUreV/9v6oBKJpQWvy6I2V7LPG2RGE/loIJ+N0kwTLE8ZnQZgBfeyHElFXArVNCptPdV9s/IKp/rMKlTnV4GA2ob7snT9LSnMnkFr8ik2worttjBUaE1zRNi8h+IWXKQLpiIOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010346; c=relaxed/simple;
	bh=IYUKuXHaoh3PI1iOc/Kw9Dc5AE9GEC8U25iYkC643zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVor/fO4YrJ6my8SasQkyrKkeMvPGe1XLF4R8zqVWrZ0AcEAr5HYI5d3h+MWopf5NC+w/ejgzoF1PWZdTiTQr8go3BJDOtReOblIYZNXKQCNkMgK5ZMCbYLI6a64Bnc6KVqBnZdZbZMtwPxnHIfIZaiUF+viEkXJ3fkpiLY9KHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXYF48mM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXYF48mM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095EE1F00A3A;
	Thu,  2 Jul 2026 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010344;
	bh=mdpwjQPKM5Kk3G9HwUTQJiz0GDNSV1tKNPKFXXwBdNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IXYF48mMxXPme0oqjacJiXWTQxgKyzW2KrfWCI30Q/va9kgeN2tvUV+Kael4Wcnai
	 KXvqblC5JYYZTgV30D+Wq4Uqhqj1e6YrZtpVl9Ah7RbLF2PO+g08OW9VzAH51KIRt0
	 tebHPTW9UCl3E39Lt3GprB971Y6+K+K29c6ruhEar7Jus/phtg0CJat0MB6j2Ka/Jc
	 jfiDEjIp2WEP7AsIyEtruiKJilkbxWFXVYDJTVdLpJRJWX9H5rOzlQm4FAkz+eLFf8
	 iuDg1Jl3oPLjQM9iEqlXlxoPkUyQvO4R0fkRaQkaHwASBfpTSPc+lWHbUaBIo/x3lF
	 0l2NdQy9kdubQ==
Date: Thu, 2 Jul 2026 18:38:59 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jan Kandziora <jjj@gmx.de>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: ds28e17: reject an oversize length on an I2C block
 read
Message-ID: <akaMJVyqy2nXKHAI@zenone.zhora.eu>
References: <20260629121043.199487-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629121043.199487-1-maoyixie.tju@gmail.com>

Hi Maoyi,

On Mon, Jun 29, 2026 at 08:10:43PM +0800, Maoyi Xie wrote:
> w1_f19_i2c_master_transfer() is the master_xfer for the DS28E17 1-Wire
> to I2C bridge. On an I2C_M_RECV_LEN read, it takes the length from the
> device. The downstream slave puts a length byte in buf[0]. The driver
> then reads that many bytes into buf[1] with w1_f19_i2c_read().

yes, I2C_M_RECV_LEN is tied to the SMBUS so that it needs to be
capped to 32 bytes.

> buf[0] is controlled by the device and can be 0 to 255.
> w1_f19_i2c_read() only rejects a zero count. The caller buffer is
> I2C_SMBUS_BLOCK_MAX + 2, so 34 bytes. A length above 32 makes the read
> run past it, up to about 222 bytes out of bounds.
> 
> The SMBus core does check buf[0] against I2C_SMBUS_BLOCK_MAX. That
> check runs after master_xfer returns. By then the write is already
> done. i2c-algo-bit rejects an oversize length before it copies, and
> returns -EPROTO.
> 
> Reject a length above I2C_SMBUS_BLOCK_MAX at both RECV_LEN sites, the
> same way i2c-algo-bit does.
> 
> Fixes: ebc4768ac497 ("add w1_ds28e17 driver for the DS28E17 Onewire to I2C master bridge")
> Cc: stable@vger.kernel.org

Cc: <stable@vger.kernel.org> # v4.15+

> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

This should go through Krzysztof, I guess.

Thanks,
Andi
