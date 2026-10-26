Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055586;
	b=C38lwlJomfIgfhub113vmaQmpBM1bpgnkZOZEWj0KJG+55UvLK5jfzygEV/AfyjyrOI3
	 9uDncFJt9ZVAcAa5BuDnk6Uhb1FM2kPwM5UHKLYL+lr3wAxaa1UruV8ZVRJni4b8pvfP0
	 /1EbHyahtqZwTw6vxkMSC7Ugp4Pa8dmOJQ4ThgSkxglmuvXYZX9s6MXjiSrajYJRDyiN9
	 MtuFOWoiHibPpZIub6xQnxu3U6JcnXvppDjItnrUbp1P0wWwcd5+smM+YwMYLRN4czoHK
	 L/nu+5kE+8k735SFLDYJN+3BcAaHr5OBqBLv98SjUi0U0lcMVIzfN1n3Vbq/7z7pfOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055586;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=s9p+TTuB98cpCv66LHI8ISbEfUazSzfu2cAiTRe53q8=;
	b=ecPUAmsAHZw7D+ojuyazZIv3UR4JVy/uvCFa3D3/vXzKPyKt+Po+997m2aS51b8mPC1d
	 3BHoa0bBq1kLsptQw8BlGP3yV93EkZmqv/bDh3LqHxKPoDArnXBqevseIj9cZcQU8z1FO
	 z6FdbgXzpMffF5lJoTaY3odCqWpk6NUq4lFvJdxVIc9fEGj+RwsckD3rzGqUZAxLsvmxg
	 q2QgC0cQbIjDRtCjWbNdc0yAk++qNbFH1+dD3aRkrghUt/SsfkO/l/3lC0wOpyRxiaRGz
	 gumZoTRgJLhL5OgkudHjnZuuzWcLYkr1kTC9ngy+/6tONMPKzYgk9O8pnfF746III4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQp+1u+v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC4606A31A;
	Mon, 26 Oct 2026 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQp+1u+v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D05D1F01825;
	Mon, 26 Oct 2026 22:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055585;
	bh=s9p+TTuB98cpCv66LHI8ISbEfUazSzfu2cAiTRe53q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IQp+1u+vd1nEIU58izgoZPn9/pDj2DLKKIhfV6V1HaS1E78n5njPLDmcBqSmkWVO2
	 ydhkklW2o5KvmBjGMVGGuw5+QmmjSy2lIJIxZYBa68plR+r9lfJZXSbyf26zXkCuuy
	 gptVFVH+6yc7OP79SUBAQgMbQi9t5kJeAtXXuHlXJe7zbEjClndNUo34A/bZm0sU4n
	 UPyn2p1wmjDdDYOvze48IcYsPeAXuKLaLtjwLr24NVghtbPpXExNhvZt5xe8nzlsyz
	 mWKy5z+a8uq+8/WzsqKDGUS/XmYYY3jGqi0qzfG5YPMoDBLkBgFGv1F+kTbtwS8Cho
	 EThmjC8xE4HDQ==
Date: Mon, 26 Oct 2026 23:59:43 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Stefan Roese <sr@denx.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RESEND] i2c: mt7621: fix copying uninitialized kernel
 stack with reduced page_len
Message-ID: <at_arsis_PFKDFxb@zenone.zhora.eu>
References: <20261022193853.670625-1-ansuelsmth@gmail.com>
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
In-Reply-To: <20261022193853.670625-1-ansuelsmth@gmail.com>

On Thu, Oct 22, 2026 at 09:38:51PM +0200, Christian Marangi wrote:
> When a page_len is less than 5 bytes in mtk_i2c_xfer, uninitialized kernel
> stack data is copied and written to REG_SM0D1_REG. Equally on the read
> part, an unnecessary read is done.
> 
> Guard these extra copy/write and read for the page_len to fix leaking
> uninitialized stack memory.
> 
> Fixes: d04913ec5f89 ("i2c: mt7621: Add MediaTek MT7621/7628/7688 I2C driver")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

BTW, this is not a RESEND, this is a V2 because the patch is
completely different from the supposed first send.

Next time, please version it properly and add the changelog.

Andi
