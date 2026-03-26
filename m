Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DF3246E8;
	Thu, 26 Mar 2026 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563787; cv=none; b=RbXPizQBO/ro2Krk5xsx72uPNGRdcI9wtht3fB5d2n56MttJWxEQp89oYrIWAT6KMkmVGD8+lEL1StMmj5gb+A9p8OTI+35a5n/Aua3c3wb5abpZr08+E1mRcrUPW/FPjB5MWXeArljib0BYaJmLvkZXLpJZHWkQRUgNjXLo6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563787; c=relaxed/simple;
	bh=ROCHNfrbiVNl5Zqs4yioqi28PWLJ543gNykCvWuEADI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3f48SGQpnxFcy82YhyMfpY6ui8QjCd5lp195iPPutj3J95IvrTN3DQS42I/4wZp7Z9qDNWcr66j3+1fWR17LI6tMrxC2KfA8Ls5d/QXV1YbdVo9HRsla2OZvMW6o8rtO6amTqfvDmi2TIVez+BYA0cM0Th//wJuwdaL+miWgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIWyTSD0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIWyTSD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B46C116C6;
	Thu, 26 Mar 2026 22:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774563786;
	bh=ROCHNfrbiVNl5Zqs4yioqi28PWLJ543gNykCvWuEADI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIWyTSD0T/3wABk4ooxkzUF574ktOvykn2aryCP3u7klsq9jEusnhLa6oukJffs0/
	 ILiyudB+C3dg9zvHm/DyzoqIdXN1TZbGXXnjFgWkNRa1Ekk88VeKZzNmpma+0mg2eZ
	 9UEF9QoUqsHNsCHi6V6MC2mQqGEKwhE64xAuIi9ZlcRGOvbg8mgS+SFxINzzxFOCMo
	 g72Rpt3Q9Zb5jb+Xeyotj65zN5W7RfKr0Mp4j52VOc0uVYzZV3pic6IWRrF0ntsLrQ
	 /1XHnnHfudzKwLr3MSK2LgOF0vWSqe/Qh3UDoOXNQTJmGBZjwqxpub8TFkHLheCtEC
	 A3d5LMj2AeKgQ==
Date: Thu, 26 Mar 2026 23:23:03 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dts: riscv: spacemit: k3: Add i2c nodes
Message-ID: <acWxqkR8Z0rwe4hI@zenone.zhora.eu>
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
 <20260325-02-k3-i2c-v1-2-78f29c83d9ac@kernel.org>
 <DHBSTI0A3SOW.PCIP544HUYP4@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHBSTI0A3SOW.PCIP544HUYP4@linux.spacemit.com>

Hi Yixun,

> > +		i2c2: i2c@d4012000 {
> > +			compatible = "spacemit,k3-i2c", "spacemit,k1-i2c";
> > +			reg = <0x0 0xd4012000 0x0 0x38>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&syscon_apbc CLK_APBC_TWSI2>,
> > +				 <&syscon_apbc CLK_APBC_TWSI2_BUS>;
> > +			clock-names = "func", "bus";
> > +			clock-frequency = <400000>;
> > +			resets = <&syscon_apbc RESET_APBC_TWSI2>;
> > +			status = "disabled";
> > +		};
> I think we should add a comment here to explain why there isn't i2c3.
> Otherwise, LGTM.

are you going to add a comment here?

> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
