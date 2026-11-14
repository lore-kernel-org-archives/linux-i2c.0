Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679884;
	b=MaZdk6AZek+bBCrB+SyPcw29A5cEd0/VIRlN8FmXwvGFsmA6zIZDoss6GquEW8Gqs1Lh
	 4e8PrDOV2jpt/Cz5MpqWwDUgZI/Xm+lEwfaaR4MXOD3qT325q718I4SZ3NRmNr5P68dPz
	 Cz2ziMagZDaoYife+AzxkI8KGf3EChGS2wta60j8++LzC8JbFaTVjBSI5GpJ8ph5+EUzj
	 OeKrf47cxMVK/WcAehDVwrEHJJRoN9ytV521EkpUR6Ym8ZT+1HpQjB+4XfRAWyGiBuJ2f
	 PTfM90SGJja3kAFlcPrryWO68Rw2hih7EnwK9xp1soyEahEk5667K/fpG5K2QH4Yynw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679884;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FCSaGjlxnw7pPlTl1Q+P/jOPDWEDl0aHm7WiAcU9bFQ=;
	b=pujhxzQGqtXShlM3lYS4UCGZvQBBPPJL8JlirgSt1Serjhz401Z/CoSW8IqA8FtR8txi
	 9QXYImSl7RGh1wtU2Wj/bJSN3lhClEeZ+FbsSr4A4I5NWOl4qpEgpMCYIt78MiATjySe3
	 yZb6qlrMd7poWTDeLBGA+OcneVNnWVC23sB8A5shwJWzM+lFpZZElJjdlHOeSg+F/eabf
	 vh6Q7dz4LRGTjn+nNjdArNY5ZJ8GuqIqlmIxSoS4EAgZo1lVJ6hsE2LvB1ISzSOFuylQR
	 NK2rdoIEEBkQLscm+RVvyhhP/nLQ0cIUanD95aD1oaCjVPS3RQ8rAVywl77CgNcuydQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OG5tRoyl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00064606A323;
	Sat, 14 Nov 2026 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OG5tRoyl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9659F1F000C4;
	Sat, 14 Nov 2026 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794679883;
	bh=FCSaGjlxnw7pPlTl1Q+P/jOPDWEDl0aHm7WiAcU9bFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OG5tRoylNjjrkMobibtdiUu8maLArQwAV74V85XHxh+yOoR3Kb1D5AqdQkBays/Hm
	 eCD7n2uu7QW2yNYMQTEeCCLlbSZLszHKW/2/bxzbe6vqVn7dvNJONWiWsc2nk34WAd
	 b82VWH6cSysj+/DUGP1PEV6LIzEVUsTRoF0Rs0gX+vfB2435QSMjLqs2cdkUSqH1zV
	 OP/C8AtfG39eanJum79+d9KR4wAP4CNJSUnCTitVUeq+t5ovRrI5Hd7Su0kIkfjiNx
	 uIhouxPxQUUKReYS+UrZ+b4v74OxsB/f8fYGr0w8Euz7F5V2Sz8rhK+gUtianlYX8K
	 0ToWIJ2eFJ7tw==
Date: Sat, 14 Nov 2026 19:11:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>, linux-phy@lists.infradead.org, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v7 01/23] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add
 SM8750 CSI2 PHY
Message-ID: <20261114-voracious-capable-guan-99cacf@quoll>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-1-8ff2a11835f6@oss.qualcomm.com>
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
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-1-8ff2a11835f6@oss.qualcomm.com>

On Sat, Nov 14, 2026 at 07:29:18PM +0800, Wenmeng Liu wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> The SM8750 camera subsystem has six CSI2 D-PHY blocks. Describe them
> with a standalone "qcom,sm8750-csi2-phy" compatible, so the CAMSS
> binding can instantiate the CSIPHY nodes as separate phy devices.
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)

Does not apply, so should be squashed with dependency. Why having it
separate?

Best regards,
Krzysztof

