Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772393;
	b=hiTOugCzGMGlN2+GJrDA+g/uek8ZRx4eMiHoOAFFX32WFb7Jt+1pZI3HCpE7qM2D9oh3
	 8E6UkRw9s9vvdkb72jPXdGJukqhzzm7bsKFBquyn0rbEfy0I/CAVS5pWF/aareuHmg76n
	 jsW2taT+PRYFGQ7k7tBYcdDTIbdr22O1S5u8A2m0YwJ7+0r5wL5sQdLf8n6/eCzhXtKWq
	 EHyNGTVeCfdIR59aONIRY7NTilT5ZGLKBhedamIDOA4T89oVbekrpW9S0pGNlRiW4NdZl
	 9yaHUbLxGPEbt/AbIxzUUinHh84XGfhQVaBmEtlWWp4rdLru5giWCbgDtLCy6uD/1FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772393;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gaEKPTZSxoXAnYK1y13tSuJiEjwopeJd6eksrQwtbXU=;
	b=CjmxOJL20KatWvDNYo1uuFMmgtXR+OrHebzluzvvJ6Oow7qFv3k6C4IYr7s9J7U+sbBj
	 WOkp9rksSb+HzfR0w7Pm0QEsqV+bq1l9ARjEyoJaANJ6ZwFZRT4Y868Eb/JURdhqm5sxy
	 zKOLQoqJXYRdsaEuEz4RXUdluvP0aFfzaaLh3oX7SueJdGvewR3xpkS68EdJTtnHoclJb
	 HV3YG21QrnDEVzBtZRy1Ei2S/h7eyd/koVSZX5kCg+fa3dhRZ0Fdn3uvVcIpJTEydHjwQ
	 MVH2O1tjFdBN4cAX13lFb/ZpQQ8bQMMIiahFbaRgFS6+8wF8WQmE4SUBr+qnubK7huA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdbHZPAQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30EB606A31B;
	Fri, 23 Oct 2026 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdbHZPAQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CD01F01825;
	Fri, 23 Oct 2026 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792772392;
	bh=gaEKPTZSxoXAnYK1y13tSuJiEjwopeJd6eksrQwtbXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IdbHZPAQBZWH71S9hbs6ylhLMUtGY4vTZ93/sWmj+tMvqAGPq21YaAKvHD475TaCu
	 JZ1OAuVlRNxVrVVOT7gFuMiypSnpYlc16R2rD4x5xtY5/2wF5r0AhVxzqvvRRcPtYa
	 d0YQYouzVvqhyhvHP8gt5T0m/3S6pI1pIuF4K7fprd1PTeOHLDBWaRaIlUDiJWU4W/
	 eECNjRbCPXHGb7IqS9UeNwnNCqz81ruJjdFAfim6D3J94Lvpw2X8rXKVoXsOPIBLEB
	 5JmioOeabyTaXC7gFB5VaT412rAV1wFENFzPIJUOis8z1QrjqqNmU1OLL06Gq3CytC
	 wfMQNhw+p4cOg==
Date: Fri, 23 Oct 2026 18:19:41 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Stefan Roese <sr@denx.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RESEND] i2c: mt7621: fix copying uninitialized kernel
 stack with reduced page_len
Message-ID: <atuI-J9c7PXTqdCN@zenone.zhora.eu>
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

Hi Christian,

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

pushed to i2c/i2c.

Thanks,
Andi
