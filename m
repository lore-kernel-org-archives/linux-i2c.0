Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8753397692;
	Wed, 13 May 2026 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709726; cv=none; b=h3916eR+0Ym5CnYJG3iSRe6orTpn8xV37cYzX3a1SieFrs+WzpnDHU5yVKZJCeBila/GvqZJ9VdD0iG0XjxwDqBSATlFf1ei9KW+xphL4Pt+bMkyk04/ISivGgyHYiFFa3lBdRbakLUJA8+0da0ZDyMVqiBy5WI+7MG//Ue9eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709726; c=relaxed/simple;
	bh=/gJKXcfLpffrosVi62SdDLKP271qgTVAvxV27fCg7NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jynX4y8Zhw3ESA7r1r0v9dlNmKPQ3/xgGgqAQ2ZMr6X0G/jfrXtLBYAnk6MESJNztxp2QzSD783wyxo5MoJ//4G50fHrzm4bV3R/WoG2On14FU+/pIBr8Mg1CcQ58Vi/eq6v1MtSzq3iHdylAJxfPLtPcmlqMZqbFgRqdK7qM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4nyM2h/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4nyM2h/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C189DC19425;
	Wed, 13 May 2026 22:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778709725;
	bh=/gJKXcfLpffrosVi62SdDLKP271qgTVAvxV27fCg7NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4nyM2h/Axw+JFALNF1A5fN/+YSUOUtit/xhwczDhyMJIWOKizSHqQLB67heCkcX9
	 vcvp53DAE0tslSBqx7B3qNyE4PlskBZoRT4TBzs4QT422btlzKRLYG8MRO+mPdebjA
	 UbMEQXLXxbQFOFeMTAOGh6/83NI+823W/GVmGQaaSxHTtV0YzqeX+TmpAXjeU6rpND
	 y5ualPNMtFSkvyiaFE7+59UIviDwhMKInFb4bKzWM5W64uukWE/rUlsxNo11l2OYNO
	 oczODsdeUh7fR1N9UBdhiwNNJ67wUFonuvLwNHi2wpFhNdu8miY9HUFAhh7mV6pGsu
	 p1CdA+zwOCaog==
Date: Thu, 14 May 2026 00:02:00 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	brgl@kernel.org, bartosz.golaszewski@oss.qualcomm.com, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] dt-bindings: i2c: convert davinci i2c to dt-schema
Message-ID: <agT0xYb-Do2rcob5@zenone.zhora.eu>
References: <20260513123758.4955-1-chaitanya.msabnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513123758.4955-1-chaitanya.msabnis@gmail.com>

Hi Chaitanya,

On Wed, May 13, 2026 at 06:07:57PM +0530, Chaitanya Sabnis wrote:
> Convert the Texas Instruments DaVinci and Keystone I2C controller
> bindings from legacy text format to modern dt-schema (YAML).
> 
> During the conversion, the `interrupts` property was made required
> to match the strict requirement in the driver probe function. The
> custom `ti,has-pfunc` and `power-domains` properties were also
> properly defined to match SoC-specific hardware features.
> 
> Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

merged to i2c/i2c-host.

Thanks,
Andi
