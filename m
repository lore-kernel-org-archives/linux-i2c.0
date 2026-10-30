Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382496;
	b=hLko1eD7u9d4Ymz5KkRu2Xn4lYiTaEgZdGbeJHVUmgN/x6efTubfJCYxwHrBGRYN/q/S
	 3t5vuxKXeG/Lt1BYslZkmo/v733n6Ym/OF6blCCxhv1FiZZmvsefFG0cmKCEy+PPT1QDh
	 fF7PUA7bsSYDB/AEqmrbOhAIKMEthS7p5UZaeSsGJnfr3ppOWe92VjpE8jbX/G38SgosM
	 TFaOOxzeXY9R+yGbmBQKfgxJvFqKRE7ekHhfhW6Kh9TnUbC1i1p7FwK4oBhjZLbsqsn5m
	 Xb+FFcFhMpGYeSW/OqNsCHEJRYaChVBFiV0+strahYcL4JKhOMNREAxd2UasGK67xtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382496;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O3d/n16SRIaChoquul/22MyjLciFyvW1PFCW6xdG56M=;
	b=dyzbyw7NU/KDq7OZpiR1y3NV3tmNgxRuxhyHZ5g6RYcbpdq4OdmGYjIJccQ2Tg0vUfw9
	 oPQonybVPaPz4rx78EO3VmzZqY38CB+HhjbFpnckPQ4fAmQ8XW2pckPACEjZEdxObguN/
	 RbgGW9a48C2kKhXSzpkwr9ObxAZuTU56t+COTePUGvwKkDDmfvSp+s61gvRlJuh3mO6rX
	 8BK9H2vXbiXPzHCpowbz8j+jmHLXxL8sSLr6uCoUIw89eIw+huOp/zNPGQRRXUYl5qn+B
	 LPwjTeedcmg7ldOcwBZ2WRgV+0Ffcg4bUXOdIaNK21UiplByL6QyXEExuCbjZh+espw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irjFoygH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC6606A320;
	Fri, 30 Oct 2026 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irjFoygH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3751F000C1;
	Fri, 30 Oct 2026 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382496;
	bh=O3d/n16SRIaChoquul/22MyjLciFyvW1PFCW6xdG56M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=irjFoygHPc/M/KH5DfQMRxGakSHaMvelsussg2LmGkfibkxqOCylGUH21ktk/XnO+
	 X7fALqcy9SIw1snW2Ix79NQSFiuoatfgUcgqvKrSe8rD3iCCIT+5iWWWFdOvyt1Z6U
	 eZ+ghZwRYBbGAFatwkqOYt2+LTU7IAwi7rm7JlKHnAfkoJ8hrn5HFUGwsj0M5wJ+mR
	 +xLIhFzCSsOY/O3AsVTeyVZ4++O6InBpPKhkKt9xYC6GO+ZROE764ZP/CjCiidmMGK
	 AqOjJ948YHkvfZVZMoVCiyELzhUYmi/EG4B3HmYiPGzPPsT57C/P7TpdTz6+C0FyNM
	 hjA2/Gu/bE8bA==
Date: Fri, 30 Oct 2026 12:48:12 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Stefan Roese <sr@denx.de>, Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] i2c: mt7621: limit SCL_STRETCH only to Mediatek SoC
Message-ID: <20261030174812.GA985982-robh@kernel.org>
References: <20261021153953.285222-1-ansuelsmth@gmail.com>
 <20261021153953.285222-2-ansuelsmth@gmail.com>
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
In-Reply-To: <20261021153953.285222-2-ansuelsmth@gmail.com>

On Wed, Oct 21, 2026 at 05:39:52PM +0200, Christian Marangi wrote:
> The same I2C driver is also used for Airoha SoC with the only difference
> that the i2c_reset should not enable SCL_STRETCH for Airoha SoC.
> 
> Introduce a new compatible for Airoha and limit the SCL_STRETCH only to
> Mediatek SoC.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/i2c/busses/i2c-mt7621.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
> index 0a288c998419..19dde7c4069e 100644
> --- a/drivers/i2c/busses/i2c-mt7621.c
> +++ b/drivers/i2c/busses/i2c-mt7621.c
> @@ -65,6 +65,7 @@ struct mtk_i2c {
>  	u32 clk_div;
>  	u32 flags;
>  	struct clk *clk;
> +	bool have_scl_stretch;
>  };
>  
>  static int mtk_i2c_wait_idle(struct mtk_i2c *i2c)
> @@ -83,6 +84,7 @@ static int mtk_i2c_wait_idle(struct mtk_i2c *i2c)
>  
>  static void mtk_i2c_reset(struct mtk_i2c *i2c)
>  {
> +	u32 reg;
>  	int ret;
>  
>  	ret = device_reset(i2c->adap.dev.parent);
> @@ -93,8 +95,11 @@ static void mtk_i2c_reset(struct mtk_i2c *i2c)
>  	 * Don't set SM0CTL0_ODRAIN as its bit meaning is inverted. To
>  	 * configure open-drain mode, this bit needs to be cleared.
>  	 */
> -	iowrite32(((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN |
> -		  SM0CTL0_SCL_STRETCH, i2c->base + REG_SM0CTL0_REG);
> +	reg = ((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN;
> +	if (i2c->have_scl_stretch)
> +		reg |= SM0CTL0_SCL_STRETCH;
> +
> +	iowrite32(reg, i2c->base + REG_SM0CTL0_REG);
>  	iowrite32(0, i2c->base + REG_SM0CFG2_REG);
>  }
>  
> @@ -249,6 +254,7 @@ static const struct i2c_algorithm mtk_i2c_algo = {
>  
>  static const struct of_device_id i2c_mtk_dt_ids[] = {
>  	{ .compatible = "mediatek,mt7621-i2c" },
> +	{ .compatible = "airoha,an7581-i2c" },
>  	{ /* sentinel */ }
>  };
>  
> @@ -296,6 +302,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	/* Set SCL_STRETCH only for Mediatek SoC */
> +	if (device_is_compatible(i2c->dev, "mediatek,mt7621-i2c"))
> +		i2c->have_scl_stretch = true;

Add match data for this. Calling device_is_compatible() doesn't scale.

Rob
