Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BE4F5DF1;
	Wed, 14 Oct 2026 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976698; cv=none; b=KV1aZZwFhO2Ac4tquTcr/444mwJ94YtZ8hh31ECVCc4+LeTdHUZK9eHHfM2iY7tfNsG4kYD/CqbwpohRRoShRZmIApFuMcI1uKXcciPZncmwZ7iGMIKOzRsDK62VHtlRgrGPb+rlnJyol4FPBLUQ46cA7T1N+zATpndHi18WIRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976698; c=relaxed/simple;
	bh=SDLE9eeX1Qzz3tj039jaJWj/cz7jxBXuDfdW2vGUbH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAGLv1b5RK3+Ou7eqUzKnCSl2Yz/lXAJ9zgIvs0KDAoQ/ujLvNc1nygjhRIzxeuyQixlZllucqgkwk9hd1knJfz22bprjYnsT+QPJYiOoO7+3m4uB6uknJvN6gbeu8GA8IVHLid32d6XjHEb1rEaa+PpTRZ5Fuke6UVmcNJwjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4ntfcoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4ntfcoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E641F000FF;
	Wed, 14 Oct 2026 11:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791976697;
	bh=drYfbpb2LBG+x4JXqrngXPqZPEzIHrYceGuJu9xpl2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b4ntfcoJij/rLepSzyVqisHtCegi9Ss/E1N6F6Z5YfyTVDsFuOIYm8NaFK4MsHkWC
	 oPPEyg3FaS8XDEsRfPnIxFR6BApAncNUK9YzEWdcBxH6PB+ZXqwFvqYIqAtiQW72a0
	 AQr9J3tZVyNhsO7Nct9xPfgyUvF1hUCFvDQbeA2WGE7ZnlNe+zu2FCD8ZEvGpkCiKY
	 ToUicVj+OO5n5X7EDTMD/4GpHTHZJI/FPZjYwMS19QPS+4bYmLaKtni2/591exI+qG
	 jZ9jfirhe3dM6UA2y8FPJQUme5H+WD+AqiFa9fMJ4P0iITnvNiY2IuGw+uaCykHuVj
	 Um4PvXAYAEqZw==
Date: Wed, 14 Oct 2026 13:18:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Suresh Vankadara <svankada@qti.qualcomm.com>, Vikram Sharma <vikram.sharma@oss.qualcomm.com>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 3/8] dt-bindings: media: Add CAMSS device for Hawi
Message-ID: <20261014-fast-swinging-dormouse-26b5bf@quoll>
References: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com>
 <20261013-hawi-maili-camss-v2-3-fc93222da89c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013-hawi-maili-camss-v2-3-fc93222da89c@oss.qualcomm.com>

On Tue, Oct 13, 2026 at 04:32:45PM +0530, Nihal Kumar Gupta wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Add bindings for Camera Subsystem (CAMSS) on the Qualcomm Hawi platform.
> 
> The Hawi platform provides:
> - 6 x CSIPHY (CSI Physical Layer)
> - 3 x TPG (Test Pattern Generator)
> - 3 x CSID (CSI Decoder)
> - 2 x CSID Lite
> - 3 x VFE (Video Front End), 5 RDI per VFE
> - 2 x VFE Lite, 4 RDI per VFE Lite
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Co-developed-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/media/qcom,hawi-camss.yaml | 305 +++++++++++++++++++++

... so here is the missing file from next patch, so just squash these
two.

Don't add new device piece by piece.

Best regards,
Krzysztof

