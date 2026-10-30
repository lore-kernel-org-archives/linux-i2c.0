Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382506;
	b=BExO3mOA0UJmUDNvTNjJVanfjDpjH+x+u+WrdfEg7p/3UwuczuaDSM/81oq5nyqxUyfW
	 FeMIe5a4uu4Kl6tSo7o72WbEmadFQAWNaJW9dQ4OuEwZik5Sm0D1fzDtZlgjTTYWzfW8W
	 IibMWq9zXAKcg/JdrclbIrwJdcoxT1mowOYSkUM5ILPLa5rNdVFrPYeEt1IO3v9m4U3lI
	 48hhuqxL4zA5EJF6YbYONmx+qWgLJhJgVhOhoSLWvYvYFjITRbl23u7Q9akkpOr+SIsnN
	 wOCZPw6BwcyrRW0Mqn3p1PnRSzCkxbXRG32xFCoY0irQgVuvV9c8BWhL92q6e0lwcCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382506;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Zl1IRjRLWMErm1qZ07L6W5fUo7xnuuzmCdvod1fuQgI=;
	b=E+oDmASXu3CIJ+sMECOtjTCIIbqEZuIjcnpatUn5HPjnPg614vKYvFRg9RVj5Caz0Zfy
	 s6g5lPufAOYnsTYgnchPl4IEVhyJrgVY5ojsNNVnI7ZJqY7wyPIYgZrGw2jiTOxnY+/yQ
	 eF3LMcOQ5VGo7FGTRke46iNTIM/eAGTkRUsiD+15cwCa++TNd2f8NDYwQflmiSC5yD8yR
	 f0vJZXdKwSUfsxdVw6NZBb9wd+q6/diOClvMqgQgrYOX3vcXWPPWIsGAapCfPhOkpJChZ
	 hkkkt+6tMkudf/xhtC0Ykp+p7VJQ7U104qQLaQP5FYXrY4vWHJRXirT4sPJ0aulgm+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6Oq7PXi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D44606A31D;
	Fri, 30 Oct 2026 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6Oq7PXi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59FB1F000C1;
	Fri, 30 Oct 2026 17:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382505;
	bh=Zl1IRjRLWMErm1qZ07L6W5fUo7xnuuzmCdvod1fuQgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P6Oq7PXiLfxOFbmD5oTxgtKm/SJkfLFINc4c7ogtZuPZpbMWyRXDlmFUd7YwX7Bme
	 BVxXCcw6WzkVVDAreCMbAcZfOj/NpbG8vCiXy50jZv0snOY32UKxLuga85Rf6ZewO8
	 HQ5dgUr+biOJy0dyVzXVKIujtH88LIp21rLdVUSEuIz1d/emDO6JLChmWCMgWfqORN
	 w5SUvxd6Lz7bS4cBBWYDUM608k4WnwQS1pedCV9n4DnCEV54BJVe1VTQ357QPzwNMa
	 3nNvjJ8+o8prPnylsyZSBw8qwN2jVinCXfkKtOH7t4ULIOIi96EHMkLTQRKyife7Sn
	 X3urShtaV27Pw==
Date: Fri, 30 Oct 2026 12:48:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Stefan Roese <sr@denx.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: i2c: mt7621: Document an7581 compatible
Message-ID: <179338250249.996557.12430447077139072221.robh@kernel.org>
References: <20261021153953.285222-1-ansuelsmth@gmail.com>
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
In-Reply-To: <20261021153953.285222-1-ansuelsmth@gmail.com>


On Wed, 21 Oct 2026 17:39:51 +0200, Christian Marangi wrote:
> Airoha SoC implement the same Mediatek logic for I2C bus with the only
> difference of not having SCL_STRETCH bit.
> 
> Add a dedicated compatible for the Airoha AN7581 SoC to abbount for this
> minor bit variant.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

