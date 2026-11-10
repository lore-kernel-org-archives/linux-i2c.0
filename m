Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302568;
	b=Mj4BXcQ6Aet6q/URnnWOUkYhYxxB6TWezvq8AjFjUK6se88supXSpg6rKOYe/AwCaCX+
	 HoBMY9A5DbvX/4pnqSmxwO+qC/BoqhfDfCfRnGgH8VGZ3d0nnM5jPDBtI7nUkgnK9k7EE
	 uoZS6qOPIq09Bn7V0EHcjc1VWV6TFm8XX1G0XFpyr7Fg3MxJr8oAe/scClF6sjaxqYpe7
	 NxUviYfYGGjL+5hH8GTpz4Bv3yHerbIdP1Rwgtc9tLtWTMF7H7j2J00V6pBjLuGaU4f4V
	 iPeGJLi7Sl/tNaQlwopmn9L1MP9/XI8gO3nufG82tENLQximksvFVz3BncqAswlVfwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302568;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=T/00q7GdXxYhOSi56pmqRGTBfomrbHHL5rHo9nrPOFY=;
	b=KkdAx62x1ziSXtEcemre7MNFAG3qIZwsjSHcnkfU8odBS7KYfvNYF9x+DK7NIvOM1ch/
	 /gUGfI/EFyGvNdKKx80oGCzb/36U8RtNpWFri+9iZ7qbL0/Jj911LvdUWqKC3AR7AJ4Ua
	 k3Lnae0d9sS3MyQeM3hRdSj6TKr2OH3fv7d0T7CkW/MxQKKDxl8EYMeHNZzXIlJAU8Gmj
	 JZmu23T3zawWVGxE7u4EFc6e2ry1RqRWgXwHXs8qROSAq4j5frjPfj0HaEJxIWojItZmF
	 0LRGCiLDyLCbAPCMcNujoG8WyK20wmf8oC6YOIND526oyFjl9vi8utGONbkbJB3+T2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=To4KO2RE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C1606A904;
	Tue, 10 Nov 2026 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=To4KO2RE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783711F008A3;
	Tue, 10 Nov 2026 09:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302568;
	bh=T/00q7GdXxYhOSi56pmqRGTBfomrbHHL5rHo9nrPOFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=To4KO2RE5ArLiLQdHwpN0YGmIrAUshdpjNAcFC8N55W+7Cl21i6FQdzHNYkTiHvF9
	 w2xx1Oi6muL1FIpjd9/8C9xnVFaxS3Uz8dkzONJq4kwQx52lzTkDs3qJrES5rvTw/H
	 6cj9UeZVauM9fk3abfcKyDFvRg7Lzu8hTe0g3nU8sIc/K4DzJg6XjPb2wCJaNlPbZW
	 CxxjAPCBMtWgKHwcRwD1Vi+NBHNW6SG8sXTrzAnZJTcgzFGS4Wyo/EOTExribpuygA
	 80StOXQeaGJgNwWcCHP69f9os5wT5HKzj1rbkLV3w0NQLPATTLv1J3QM2xwY+V78KZ
	 iMa7u2MwHqA6A==
Date: Tue, 10 Nov 2026 10:22:45 +0100
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
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-media@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add
 Hawi and Maili compatibles
Message-ID: <20261110-cordial-gecko-of-trust-c864dd@quoll>
References: <20261106-hawi-maili-camss-v4-0-d528c7a797b4@oss.qualcomm.com>
 <20261106-hawi-maili-camss-v4-2-d528c7a797b4@oss.qualcomm.com>
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
In-Reply-To: <20261106-hawi-maili-camss-v4-2-d528c7a797b4@oss.qualcomm.com>

On Fri, Nov 06, 2026 at 12:20:43PM +0530, Nihal Kumar Gupta wrote:
> Hawi and Maili integrate the same CSIPHY IP as Kaanapali with an
> identical register interface. Add qcom,hawi-csi2-phy and
> qcom,maili-csi2-phy falling back to qcom,hawi-csi2-phy.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

How my tags could appear before this signed off by:

> Co-developed-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

? Are you sure you used b4 to collect the tags?

> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Best regards,
Krzysztof

