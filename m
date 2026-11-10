Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302899;
	b=xEG6KddKjCewvUyQbtJ5xuCLWEF7ZMxFmzcv0lF4qDgSUuigZHYjy/el28j8JD82Go7r
	 iYmalu5ZF9RLN2fO4dEO6vrSrtTlRY0ZIubSKbhcyNZs+X1rt2U7IASxJCX1Ywb0qFlFR
	 LTDKxrXXsf5NEOrPmmL8wyiFtC/Wht1mrjyk/dMrOXv+nq7MAOirGTyldL5TDMgOrrQaX
	 DoI6/IBl/T4T6eV2Wj/erotNgX/7ddkDoDEzvNAraj8ugr320K56v5FAp5jz0+l0BT1DR
	 rH+O5FpvSFv6/LG3YRWoflT6De2H1kWPST/cUF//plkvc20I9lP0AM8BLk3glnbsY4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302899;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=avaoukR8O4DvWXprhfWe7DumS7ND5hwn7PH19Gy9dCM=;
	b=HYE59+pMKEdTSrbmtTW5/hAqorJR9jMiXdnh13rx8ohOvNPLYgJprVe2gN/bexHsno+M
	 KNneRkmV+3282i8evd/lXjUJMPyNGmFEfDgJ9cDtJyJ2F061thJ/fe9XCWrRsvvUtP3rO
	 XsPW1vhbWOtt9+BAz2Q+cnU+VOJefZsewh0dWXCbvAG+BVuJa24vVWGRxYwvYPqszngT1
	 7Pn+RzPY4fPdC++V7eoLZ+IR+plgcjGywfzU2cc3C7H+PT7e1Nocy39k34EqsbfoYoniw
	 5ZPe1wuXJVSIgGdN6qkQDj8f1V3O20A4CqNyoVnsSCg3Dpc2Mbe+IVdksT2bPqSw2ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRkObjOW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF5606B177;
	Tue, 10 Nov 2026 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRkObjOW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871E61F0089F;
	Tue, 10 Nov 2026 09:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302898;
	bh=avaoukR8O4DvWXprhfWe7DumS7ND5hwn7PH19Gy9dCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NRkObjOWkxf5/L4h8og8ODcEp7Ne31cT2Cc7Bu80WByDlLnzqLfABSFFlVOTWh3Gj
	 6laLuxgVQj0mIOQy7cu5wOyO/oV5PlinsYB21JYsBJJQezE8SvqL1AVwpAcI5sVDIQ
	 Sg6OofOiKWsPM6DZ67ZL9FwBkkzlOpnksfhjbxnfQ4fDzCaTybJaXMSIWi7hd4Y6he
	 KlDKVSqXIb1wGZtmP7mi3D0g/a27d4NZjQdbxdjPbSimISfMAcjQv3PQfG0JtlX65o
	 hBFDLxLS3gvQId2wi0ohWOKdFYzxiZ2VqW8gJSTwGA/TSlrcKDduX88EOgukDYHy8h
	 PTTGjm1MUohrQ==
Date: Tue, 10 Nov 2026 10:28:14 +0100
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
Subject: Re: [PATCH v4 3/6] dt-bindings: media: Add CAMSS device for Hawi and
 Maili
Message-ID: <20261110-mindful-snail-of-business-fa211e@quoll>
References: <20261106-hawi-maili-camss-v4-0-d528c7a797b4@oss.qualcomm.com>
 <20261106-hawi-maili-camss-v4-3-d528c7a797b4@oss.qualcomm.com>
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
In-Reply-To: <20261106-hawi-maili-camss-v4-3-d528c7a797b4@oss.qualcomm.com>

On Fri, Nov 06, 2026 at 12:20:44PM +0530, Nihal Kumar Gupta wrote:
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

Amount of dependencies here makes it not possible to apply and b4 diff.
I don't even understand why PHY patches are dependencies for media ones,
but if that's the case, then this must wait.

Best regards,
Krzysztof

