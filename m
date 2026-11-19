Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126020;
	b=XexqW6He+N8sIGEJRZKfXhwET1oxo8Eh2k3DCIi7b+dbaKADpsJ3ZPPpfLHfDacmFGKn
	 vwFtrAfCtjqvApG8+OOnzOwk67GFz2mzVD3YQV5H4Ev6g+DsL4SSNyybZ/aCJpQWPopfy
	 QsJHH8wjuv4miMEUUTms+rvIwUCU4GfvxqTxiSB8lxtgl5Y6asaOA3ztBHz2uF4Vn/LXN
	 9Sl/hoLY+k5GPf1p5MfBQRhcBVXyw1kkfVfz1XolQrAwEZoiWpXrIcR+f5tFJCzZq2Fyl
	 kNrXu5BWALdyEQS7O0/ztjyoDEEDTbCSEc3fFBuTm+UsIdWaJ7tmGphea8X8DX179XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126020;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ETZ7xeXM/79uniKVVrwhkskKouFWSJb1lviMqROj1wc=;
	b=YbopHXfzzxiU+fHxc/kUHPR0d2oBduogxvaBZjL2TvGpSh1xTRhK2FLeNJ3Pioi20vJR
	 XIO6Z4z2FE185UgymSOpBEc2h5IzKuiWmgdoF5ljoBVgf/az0619LyYUNGgR4bkedBw6S
	 Wgbx5PycpOp9bF0I1lzQym9kXZaXHWLY1q9w0mJwJagAVGS1On3w+gnN6TNSRrAsawr33
	 +QU25Rr6yIcFj5ngJv8h2k+88TwiypSFMcSv/O3VWy16H9UM8qM1pW5+SyoSnnnhByV84
	 drfiOGfAPTafjzV4j4DiKsep/aTl0SZo2D7UI2RrBcLmyCe43HRlAaSsWuptyAmPoKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxSx1JVc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB46606A320;
	Thu, 19 Nov 2026 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxSx1JVc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2B81F000C4;
	Thu, 19 Nov 2026 22:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795126019;
	bh=ETZ7xeXM/79uniKVVrwhkskKouFWSJb1lviMqROj1wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JxSx1JVcPjmlNDwyivyMLlAGLrZ9HFJD3jFfyrmEoyE2ci9Zfwq7bRsTcVa2tt2+6
	 bIum7g7PsFjUNna93J3xsm2WPkyA8N6FJ6EOj5uupIP6OTlAgEDnX9DRghLQQNk9lY
	 9mZeRyqLgvbl1tpK8rYpOO+nLKSEZtQr0tWTBGlCsLSPm6xTjnEL4GECS4j4mS/yOJ
	 RCf4wGLdWKKt0m6MmaqDJhU/EOP5N80ZoYZEblGy3c3+x4rqxzYUw3IhniiPXx17YR
	 3jzH+48nsVjfq1aicY+SwZzehd3LLqZzqFMZ3zfsgHJXdCNN4D3BbnRAsKp0/xxbCs
	 s14ToU8efo4BQ==
Date: Thu, 19 Nov 2026 16:06:57 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Zapolskiy <vz@kernel.org>
Cc: Robert Foss <rfoss@kernel.org>, linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
	linux-i2c@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: i2c: qcom-cci: Document SM8350
 compatible
Message-ID: <179512601692.866431.5877068767600191893.robh@kernel.org>
References: <20261104230529.3040285-1-vz@kernel.org>
 <20261104230529.3040285-2-vz@kernel.org>
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
In-Reply-To: <20261104230529.3040285-2-vz@kernel.org>


On Thu, 05 Nov 2026 01:05:27 +0200, Vladimir Zapolskiy wrote:
> Add Qualcomm SM8350 SoC compatible to the CCI device tree bindings,
> SM8350 CCI is compatible with CCI v2 found on MSM8996.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---
>  Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

