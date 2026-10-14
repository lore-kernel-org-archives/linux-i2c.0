Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4534BF949;
	Wed, 14 Oct 2026 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976725; cv=none; b=Cq6ExM3flOiRfvqt0Uk+rhhln0wbKWW4KzvMGdRZDHo6/hoBWGdFJIzd3DajRQQvdeupsMeG8DTOoTR2MhMr6oy+vF1Y0y0/cXbZ8a0JTNkArioAHo0P/xu+rf154Q4W2X0gAVGZ/cfVYvWYlDFCoiQwkp6WlsJXJLJZvzzotpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976725; c=relaxed/simple;
	bh=Npw1DY01Uzp1+PRjHtJS+nGy9bWNU2adOVGxaiejamE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW68HW6kXPDy50KquaXDs8GsoUX02NeF7CekQ2Q2Ji8lTNWFcLxJ2sU4P/teZ8KhxA2AuCM6LNIj2OiEoLQ53FeVT/tRTdMvSQlccGOc2ubZhCwM66BPNLKW39HOKesQLmFqdjuyl2KBi8W+FyuzqpgpEsBcf6fmZ9v7MbTmtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEt0uCZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEt0uCZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4281F000FF;
	Wed, 14 Oct 2026 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791976724;
	bh=OKBnsnfCKN2fkgPqQiZ01j4m/ocO3oO730cJmnLZmLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZEt0uCZZCzFklz+3Iv/wUtjrvSv8fBfTd9psbtR0X6dSXTpfD84n7mH5F8Zv2qKpH
	 g1vv5IF1XpbQFkeZwBOp4ikZ/4asARNBxwlnkIwghmH/cXj2vB588dS9G+WBd6jdqd
	 +w1hclZjlO1Bd/KhFebLpCt3LhH3NY68jR59l8TFdKBNW+huvYhx/0hMLgqd6sPN0s
	 pcW2uCE+T4L+DaSmMT+Gzl9JeZYMVwdwk1GqxmKnR3y5S2QhQBuAq7uCgphQ1hEBQ/
	 UTuCs0nrpn8bUrI665g9LglexmRhIPJfzGwU7tqfFuI/oVB5pwD8gkeNehcOmFdqzy
	 j5sLoPWIVdjHg==
Date: Wed, 14 Oct 2026 13:18:41 +0200
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
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add
 Hawi and Maili compatibles
Message-ID: <20261014-satisfied-misty-scallop-a75fba@quoll>
References: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com>
 <20261013-hawi-maili-camss-v2-2-fc93222da89c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013-hawi-maili-camss-v2-2-fc93222da89c@oss.qualcomm.com>

On Tue, Oct 13, 2026 at 04:32:44PM +0530, Nihal Kumar Gupta wrote:
> Hawi and Maili integrate the same CSIPHY IP as Kaanapali with an
> identical register interface. Add qcom,hawi-csi2-phy and
> qcom,maili-csi2-phy falling back to qcom,hawi-csi2-phy.
> 
> Co-developed-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

