Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58162701CB;
	Thu,  7 May 2026 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182247; cv=none; b=Qv1KbFp4ZLJ5qP0eGUKHJzQhbiIci+D7wca4EPzkedFtQLvoRpK4TXZxI5025C793CfzOYM/u8ziubV25GGwYg7p6+3TNBNaUSL8kZa+IsCaDpyFJAqdYdHLG2WoFQNrgMSqX3xxnsTRFXJWV7VP973Hcl306kfAlWzBi5ueVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182247; c=relaxed/simple;
	bh=ARFq5MAgm/fsf8IiwdXBCXBcmnW6CmVt3aHQgiewnfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZETjF9Hco7Xv51V4TwtAHINDTkd/MbmRwlFClbuLTtUN/ZMobSCn2+EmtMsF7IwFiY6DQrsPKMmlURqnPflm75ZzD/lg5pFUGKFCpcQU/vodY78XCVCSy4Sjhtv+ftfqQxX7wvj3cFPsKTX0IDjD5kcFHmQc/4IaII3IHQ+YlCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VckxlBOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VckxlBOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27381C2BCB2;
	Thu,  7 May 2026 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778182247;
	bh=ARFq5MAgm/fsf8IiwdXBCXBcmnW6CmVt3aHQgiewnfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VckxlBOJIHKrIvRdDu5LFrBB0cdgMf7iHwkQvw1dVwrKLH7ZXNAlC7Com3RqGm6mJ
	 HELfduBLjP/RBHnuFvN1b9Z87BThfkmSvCt3n3gh2cUt1oYOb0h/kVRZATfmhaWu2S
	 CIYN/KorVOP/H0235v9chRcgy02D4I4BTSMFj33GBRxhLmojZhUEQpxz6yxjZRFl6a
	 Ypo6FM6HPhu7Nl2ib4isV8uOpNJoi6RLjZJ9IlrbcyBZIY7gSIAbolUY0XB4Xa6IOp
	 id/MEO4T49T02O3MSW8e/1MmLY8JtyQgGskmj78dAgoK7aYWDSXj796PjjCwsSo/16
	 wnqcnMHZYIQow==
Date: Thu, 7 May 2026 14:30:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: wsa@kernel.org, andi.shyti@kernel.org, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: convert davinci i2c to dt-schema
Message-ID: <177818224453.2459148.14580332876436885602.robh@kernel.org>
References: <20260505102626.5726-1-chaitanya.msabnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505102626.5726-1-chaitanya.msabnis@gmail.com>


On Tue, 05 May 2026 15:56:26 +0530, Chaitanya Sabnis wrote:
> Convert the Texas Instruments DaVinci and Keystone I2C controller
> bindings from legacy text format to modern dt-schema (YAML).
> 
> During the conversion, the `interrupts` property was made required
> to match the strict requirement in the driver probe function. The
> custom `ti,has-pfunc` and `power-domains` properties were also
> properly defined to match SoC-specific hardware features.
> 
> Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
> ---
>  .../devicetree/bindings/i2c/i2c-davinci.txt   | 43 -------------
>  .../bindings/i2c/ti,davinci-i2c.yaml          | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-davinci.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/ti,davinci-i2c.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

