Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52735E1B8;
	Fri,  4 Sep 2026 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788565334; cv=none; b=ORNyV11hySzv7+0kzixqwaCR9aZFPlbDJGTkjnKZwKWzXwKI0KvfW44jbT3hVVBlgbowND1p7Bpdy1aSAHnjQFJbFF2cLE/q7Ubb3CheDHUdXvpZTBVYYvOXS6NJn3R/FgtVT1UMPahwd7IqNBval8CYzScrk4dMB9h77+STc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788565334; c=relaxed/simple;
	bh=fuSOeb+rmWuQjo88nHrx7Sv5rD++tmKD84lWiFlygoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxnMyE7HO0ilpHPbXYdFrufbjKkQyxCudwYknYH4x3eHrnOiBP+0Rcm2mUZl+rm36Krfe879gmVUAZhGmdte7h1pReFF3M+iOJMfhciHVqogMS7WkEKfa26d/IWgwqgSGkW+Hnc4OK8HH3zqBim34PD42JbNHcbJpHVKm86r0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gdqt5SJX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gdqt5SJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3FC1F00A3D;
	Fri,  4 Sep 2026 23:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788565333;
	bh=QX/Fk9Tx6db3qemKOlBvpuCPR/MFN0GxUuQE1UCmKLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gdqt5SJXIY6rADw0cFuZkF88o7xGpLE5dTARUOG8k6vrtZbDKGYbEhM2zyZz3qPw7
	 LfMfmb28a2O+GcRdOlITDr0ctgUcbpq3Zw/scOhPo3dLYU1T30/ZupBN2lKhMlq/jt
	 R52bWRnD/fvql07Y5CZEGiZsrneXZtLryjFaM1rEJEIOwx3jJ35tPMr7nSiAHTFBbd
	 9jQSXhhTGIAbZOWFw77ejB3FcPnO4re9MocBTcnfjEIND/vrXvkeuyBp+oUhwcV1Gp
	 aXzu16AmFu5JSz+qCgn2lWHypGRkyckcDcIfj5g3EBhMYTPtVD9ZsgaVbYuBGn43Di
	 zsNevJYUD6LUw==
Date: Fri, 4 Sep 2026 18:42:11 -0500
From: Rob Herring <robh@kernel.org>
To: nina_kuo@novatek.com.tw
Cc: andi.shyti@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, shihpei_hsu@novatek.com.tw,
	toby_chui@novatek.com.tw, Ben Huang <Ben_Huang@novatek.com.tw>
Subject: Re: [PATCH v8 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C
 controller
Message-ID: <20260904134834.GA3514178-robh@kernel.org>
References: <20260903160434.GA3629759-robh@kernel.org>
 <20260904054024.35245-1-nina_kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904054024.35245-1-nina_kuo@novatek.com.tw>

On Fri, Sep 04, 2026 at 01:40:25PM +0800, nina_kuo@novatek.com.tw wrote:
> From: Ben Huang <Ben_Huang@novatek.com.tw>
> 
> Hi,
> 
> Thanks for the review.
> 
> On Friday, September 4, 2026 12:05 AM, Rob Herring <robh@kernel.org> wrote:
> >> +description:
> >> +  Novatek NT72676 SoC provides two I2C controller variants, generic I2C and
> >> +  STBC I2C.
> >
> > blank line between paragraphs and you need a '>' modifier on 
> > 'description'.
> 
> I will change the top-level description to use the folded block style and
> add blank lines between paragraphs.
> 
> >> +  The generic I2C controllers are accessible only by the host CPU and driven
> >> +  by a 96 MHz AHB clock.
> >> +  On the other hand, the STBC I2C controllers can be controlled by either the
> >> +  host CPU or STBC (Standby Controller, an 8051-based microcontroller) and
> >> +  driven by a 12 MHz STBC clock. Authentication with STBC is required before
> >> +  the host CPU can access the STBC I2C controller registers.
> >
> > Is the programming model of the I2C controller different? If not, the 
> > compatible should be the same.
> 
> The register layout and transfer programming model are the same, but these
> are separate physical IP blocks with different hardware integration. They
> have different interrupt sources and input clocks, and the STBC instance
> requires an authentication and ownership-switch sequence before its
> registers can be accessed by the host CPU. These differences are fixed
> properties of the two IP blocks, so separate compatible strings are used.

Different interrupts and clocks is every IP block. That's why we have 
'interrupts' and 'clocks' properties.

For ownership switch, that can be based on having the 
novatek,stbc-syscon property or not.

> 
> >> +  novatek,stbc-syscon:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle
> >> +    description:
> >> +      Phandle to the STBC system controller registers used to authenticate
> >> +      host access and switch ownership of the STBC I2C controller.
> >
> > Sounds like this could be modelled as a hwlock? That's other platforms 
> > mediate access to shared h/w. We really only want to have these syscon 
> > phandles as a last resort.
> 
> The ownership mechanism is a one-time switch rather than a hardware lock.
> The presence of the STBC I2C node in the Device Tree means that the
> controller is assigned to the host CPU. The driver authenticates and switches
> ownership during initialization, after which the controller remains under
> host CPU control. The STBC does not access the controller concurrently, and
> there is no runtime acquire/release or lock arbitration. Therefore, the
> generic hwlock binding does not match this hardware mechanism.

Okay.

Rob
