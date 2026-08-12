Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485A384CEC;
	Wed, 12 Aug 2026 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503365; cv=none; b=IP3KRh98ZAT71r4tJVPNmR4T0rNlYdC/0UMt5dYEoNpZ2SfeRCxJhFtTR5H2L5DO8ivx63rwYk6DYBSbYxca5yQnP/dxcGyB+WpWAbnWedm2MEu50AawIzMcqoIjgxu/KoHkPLOBo3v6V2YpGoCCgM/HVr+E5AZvP/0eF9O71HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503365; c=relaxed/simple;
	bh=Fl9dwupjRVsTufLFUNfCSw+H80KDBbSEtOlBtZLc5xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgYYsShaKMQu134OqKA+LdX6UCP3OiC4wsN8vfqhtt7fOgh/rJZb4l4IPxf/0Ystnh6XYmj1WH8nKvdVw7PVUI1RnB2EI/gAYA/FPTIm7/EFbqCxpcEFV1z3ciQp31fu5Ztd2ZpDtdJTzyj6/XzMsdwXkRtFY9Xa32neK+usCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjXzq2nC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjXzq2nC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1423B1F000E9;
	Wed, 12 Aug 2026 02:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786503363;
	bh=Kt/Gnj2b43EWiU5G4BOTMXgY7mqqkW+KfAi5AcqL9kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YjXzq2nCTd8I3ZQ6SvSwxEMzkA2jzNZ0sNTQP+9kjseN+91VKqd4RaatuZ5kH1+Ix
	 yCFkzj63Sf7lv4G8hEudXMhRBuRp+sxN6F/RYjNLNUBX9Fpc6URACXmerA4GBU/fly
	 dP+Dfev2Dz+makZybB04h2MnMtIraUikbKJlar9S1F/9J/dMbMw95FVrj3cw4gaVAM
	 Vuii1Ssnw4fGY/Zmt01KfnVaS939ik3M/1/ESE71k+mqKyO6W2mlXdFpjDxHtIAO07
	 8Y6m/SZpbN7hJfrm3DqTteNv1HANoUoOy2FUxYTrnc9qk3wYxDjj7ZCuz2h5T7Q9o2
	 SQRPPfGYJ6PJg==
Date: Tue, 11 Aug 2026 21:56:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Chris Brandt <chris.brandt@renesas.com>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	biju.das.jz@bp.renesas.com
Subject: Re: [PATCH v2] dt-bindings: i2c: renesas,riic: Drop clock-frequency
 from required
Message-ID: <178650336197.631765.122141109682113788.robh@kernel.org>
References: <20260806111018.782380-1-tommaso.merciai.xr@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806111018.782380-1-tommaso.merciai.xr@bp.renesas.com>


On Thu, 06 Aug 2026 13:10:13 +0200, Tommaso Merciai wrote:
> clock-frequency is described as optional, with 100 kHz assumed when
> absent, yet it is also listed as required.
> 
> The description is correct: i2c-riic calls i2c_parse_fw_timings() with
> use_defaults set, so the core falls back to I2C_MAX_STANDARD_MODE_FREQ
> when the property is absent.
> 
> The stale requirement only produces dtbs_check noise on boards relying
> on the default:
> 
>   i2c@14400800 (renesas,riic-r9a09g047): 'clock-frequency' is a
>   required property
> 
> Drop it.
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v1->v2:
>  - Dropped all v1 series, need a rework.
>  - Fixed dtbs_check failure by dropping clock-frequency from the required list,
>    instead of adding it to the dts, as the absence of this property
>    indicates the default frequency 100 kHz.
>    v1: https://lore.kernel.org/all/20260803132828.3249424-3-tommaso.merciai.xr@bp.renesas.com/
> 
>  Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

