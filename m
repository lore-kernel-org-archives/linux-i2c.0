Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8911371893
	for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041839; cv=none; b=BbItWkBXAGq1GKmErRaBwlkbAqi3r5UuIMDJubt5o2rsxPK176secTvhH4Rr6PqFIrkbYUiHlaouf3+k0cj1PNEzg1YeiEMVfxX6lT50/dJ0h/lprf+rAPnepZNA/6cBW4p8vib14+esthTBVVkF0kbg9PiLv4UWZGNwHCYxSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041839; c=relaxed/simple;
	bh=uTaN04j6+cb6/7R2Oaa7TFsdeuAss2ZJO+KB7exIZv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxzwg2HMV0oPJvfvWyh09ENr9D0PQPb8gZQjORSs3/6rzrhR7f9SxnTLjdiFeaIKzwZMaOuPAa4190e4x171ZQyvqPZ7fQKwS0RBG9/DTJ4IXvaP/qt8OHGlZx5bdG4sgKj2VB0QM0mEUBpF7f/+S2a0EikrgH4XuajcI/I0ejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=L8Fp4irv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="L8Fp4irv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=jAQD
	Q2Ijn2JafmoVVhu9OwhIlf/ITjKAIPoy10A798Y=; b=L8Fp4irv4LycvmIlOZ3f
	WUViDiZxJrvz9m7VzpNUdk3cGXX0Aeo61n8EJTCw0K9+d4I/PGRtkPig7GSaosp7
	bgCmcWipGxQUCT61C2BVKByrJpsvoyQJybJFDLrHrFcLUNYrBeldQUxr7vS4E8Io
	ZMjTN6EKxsAC2rIo4e1LljfH8CFRnthH8/r0fy6OTvUxV0PYxA3dNYXY+mRTrCrD
	P47+wuBlLfRS7EjA7UzMZJvbX1rs/j5hoFr8G0GP51EuX/irog4Dh5BtP6aW2HR2
	WZ62n6T/enlZrq/cuxNwPlea9aiK2HPz3Cengtv1RPKmWK1wN4xsWoZ5kH7ybTLN
	Ag==
Received: (qmail 1700375 invoked from network); 20 Mar 2026 22:23:53 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Mar 2026 22:23:53 +0100
X-UD-Smtp-Session: l3s3148p1@2XBHTXtNHLEujnsL
Date: Fri, 20 Mar 2026 22:23:52 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: i2c: qcom-cci: Document sm6150
 compatible
Message-ID: <ab266KF-8ll2TKxm@shikoro>
References: <20260305-sm6150_evk-v6-0-38ce4360d5e0@oss.qualcomm.com>
 <20260305-sm6150_evk-v6-1-38ce4360d5e0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-sm6150_evk-v6-1-38ce4360d5e0@oss.qualcomm.com>

On Thu, Mar 05, 2026 at 05:48:12PM +0800, Wenmeng Liu wrote:
> Add the sm6150 CCI device string compatible.
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Acked-by: Andi Shyti <andi.shyti@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

Applied to for-next, thanks!

