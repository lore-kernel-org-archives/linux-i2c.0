Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008494;
	b=DRBYgFJK0ofIK7P7C93D+UPquJhCtn7+jeAXCPlhjxLNrzL+OOIAxRHJcAkkz4pvLxrx
	 /ENOyr7If6jHO0SQw5ueTVgbdLCHiuy54E7kq+P23jrI60LLI9wGiJ5NvgO2P/rn9ZTmv
	 L2kgxHz9qBvUZKIOnZP5+t6tbDc+DvtYIALf/DLtJBFbtZAVIulPYoffonyt8qHQ/YRwC
	 b2KZJHd/pD7A90VuGxjvm3PUQJi4bWdqOfx+ncrwaa031hr9dyHe0o3rkwhL4kjqsZR2n
	 fDFjvPsi7hPmSm8RPjXwz2RVawAvVU78BTsKCp7uKAH3qicMqeEz1XDINDnIwuGuXQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008494;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bq3zPEguHOLASpI8QxkTmM4iRLkFLnGxgfe/hzF7Y3g=;
	b=P5hhJZfsMebaaX3iYY3JKyzRDDRH0ojyETtdWXXqkB6HdyTJ6jGrYRzRanSMzxetQAW7
	 62jTNJKh+2Zgg+VvkcUmv461f5lDQGYvMxjEUFYPVpFTSPeYg6XlEnLHl1IMwP21oDmQO
	 +XtWpGemIKCnUXToIATe69CnfW48i3nQU/HbT5yirN/fNBhi60Rw6tIB/uolROEabGj4i
	 zUrNZZ6x6NoLNW81zpYrV1kiOKgoaoVAuldxtIWT+z+o85f7reS9kEZ/KnqckyaUMurvA
	 UGFl7mfo/TogvjdaesJtkQLWLJT+IqF35+RmolBes+x5GtXsLKZ449Fz2UE0mWewGng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFqs9IXa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69303606A31F;
	Mon, 26 Oct 2026 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFqs9IXa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A121F01825;
	Mon, 26 Oct 2026 09:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008494;
	bh=bq3zPEguHOLASpI8QxkTmM4iRLkFLnGxgfe/hzF7Y3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DFqs9IXayJ5aG4W9CHaQ8mjAbVOvOVkjN4A/N3DZ5baFydkrqmMqo03MQG5Aah7U6
	 phmJ5jctUvRg04ogP+cRXXRjUPdxMMkEslDsUAPHk9uMyZ5w8+dYjzpCyrDElxVSLk
	 Ox0RAVeHUG7k5vWIedhPDkjoVN8DM4deEAQhiesHFCCHUwGAdoowS/a4Zk0Qn8kFhA
	 Ndz7M98RVOcBbzP4yp+JqcPEEV/5p7u8yMG288b9Ay/C+PlH2/hnVsx9n0rYTy5gh5
	 ReY94MnjKefOrfReYrDIyQxm0zMpQINSMatScJiJBziIqDdAFAoWMKZYqYY0YddGUb
	 bAY431dsHprdg==
Date: Mon, 26 Oct 2026 10:54:49 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Olivier Louvignes <olivier@mgcrea.io>, 
	Paul Cercueil <paul@crapouillou.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"H . Nikolaus Schaller" <hns@goldelico.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: i2c: ingenic,i2c: Add the X1600
Message-ID: <at8jCGfp9dKjieoo@zenone.zhora.eu>
References: <20261024212520.91401-1-olivier@mgcrea.io>
 <20261024212520.91401-3-olivier@mgcrea.io>
 <33b5ee36-e293-4356-9906-54e99ba3557e@kernel.org>
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
In-Reply-To: <33b5ee36-e293-4356-9906-54e99ba3557e@kernel.org>

Hi,

On Mon, Oct 26, 2026 at 09:06:43AM +0100, Krzysztof Kozlowski wrote:
> On 24/10/2026 23:25, Olivier Louvignes wrote:
> > The X1600's I2C controller has the X1000's registers, so it falls back
> > to ingenic,x1000-i2c.
> > 
> > Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> 
> Why changing order of patches? Previous was correct one.
> 
> 
> Please organize the patch documenting the compatible (DT bindings)
> before the patch using that compatible.
> See also:
> https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

I can swap the patches before applying if they are OK. Next time,
please, follow Krzysztof's instructions.

I'll wait for Nikolaus ack/r-b for applying the patches.

Thanks,
Andi

> With this fixed:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Best regards,
> Krzysztof
