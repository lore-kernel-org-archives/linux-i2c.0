Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302636;
	b=mOZgPNIuZ7Dcl7QHtgNrlR2Utc4UG33ksgZvq7iJUseMbuluuvXxRvo9YwNia9etBYoy
	 R0eY09Qkrz2V/S4KUjDEFygGZOou0ZHd7OwWwT3G9D7P2K0C6jb1QKwTEw6xOsxND60Jz
	 jNFnjjCdLUYdCSO434RGAjtG//ckuZFsfhHgooZI5NOlUvwvVQzpW4dGDXR/m54Jvq9+K
	 X3I5ngYQ0hm+byz4NRkGZuUmziYiPm6sayXuCK49mIOKIYETHkNrlBxSd1ofhaDaY0TqT
	 pFhf9k1ZzbQpAumuYz3NCLFEHTgsvgTirLaZXnv4cHWJ06RbHBRKSIkzdGhOCoGLulg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302636;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Bld72ze3MCWiaLBGA3XPtCKyhfXQPBGjgO3Es6jtm0o=;
	b=0AAwhTq4ecDZZORO6P6VciTgiMk4MGQsdUrKThc7pnky0/l65F8+RSJ/YmUjaKTtMv60
	 Xmm+kGw5VUMvw6HKccpkPMirRSuwrJuC6dfe7kycL/h7bXnDNgoNrclo5omWjuh19pXUn
	 nHFuydj//nItvU2+efc1Y2zZU88z6tqRpXUwC8tCWmXcw6rMewz1Jt9taA6+LpGWDz9R+
	 Z6bJUhHRFnliNTgkAas3Es1rQp0RYLO/hZYLUU9XE5peYHpk5Lg0WNwOdE2JfgqlbDMK8
	 Ve200u84sBTyNrbdUWruZw2kkNnMW07tEVORjfv297PRFYUlcGclE/avh65OcKezp0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8WqXunE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFBE606A335;
	Tue, 10 Nov 2026 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8WqXunE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67381F0089F;
	Tue, 10 Nov 2026 09:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302635;
	bh=Bld72ze3MCWiaLBGA3XPtCKyhfXQPBGjgO3Es6jtm0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X8WqXunE/TvBHbIZTYLmqLtMciaQDDJhhDVwJoYkQvcjyE2pVMhVhXPxGtRfI7WS8
	 CmaLxf2EOuNcVCXftUD11ImJs0lFmU95NaKcGgB3GDUine0NEbUWh86YpQ5X0irJKD
	 g010juDmaF/0x0RsELQq2aqnkYFVplIaeQnfJw87pL89DDY1mbKjPaYeHvXhg0N68J
	 e3QoVFakJ6i5kb3ZC6J/qqSkCTZ9kLSmJxlVW9mytVV5Q7a8iJiyRniMCkBzLMiTqS
	 6R82lCRciBEnRgyO+HSGtUUzHAdwSAMdgf/RHn+E0isNCjOdFRuuWP4KlhC+Y7Lm8I
	 5pztixN+Xu/VA==
Date: Tue, 10 Nov 2026 10:23:52 +0100
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
Subject: Re: [PATCH v4 1/6] dt-bindings: i2c: qcom,i2c-cci: Add Hawi
 compatible
Message-ID: <20261110-friendly-chipmunk-of-variation-eef4cd@quoll>
References: <20261106-hawi-maili-camss-v4-0-d528c7a797b4@oss.qualcomm.com>
 <20261106-hawi-maili-camss-v4-1-d528c7a797b4@oss.qualcomm.com>
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
In-Reply-To: <20261106-hawi-maili-camss-v4-1-d528c7a797b4@oss.qualcomm.com>

On Fri, Nov 06, 2026 at 12:20:42PM +0530, Nihal Kumar Gupta wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Document the Camera Control Interface (CCI) compatible for the Qualcomm
> Hawi platform. Like other recent platforms it requires two clocks, so
> add it to the corresponding clocks constraint as well.
> 
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

How could my tag go back in time?

> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Who received the tag and what was happening with this patchset in
between?

Best regards,
Krzysztof

