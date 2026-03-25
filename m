Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01B355F30;
	Wed, 25 Mar 2026 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437390; cv=none; b=GvUy8Ksg/lV8W604gdW1aTJk47c1MLGAupX9W5lu5nXI5+OG9uhS2yTfyE5xY4OjsvB2Zmx8SdIUdXCxvlytSfzbZb88fMFEETDAcNk7JalfwKJ/oxEs8suRAY+jSYaqfM8dwRTBSq7FRoSCUyty67WDIFZ5mgvweKOeUP0Umd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437390; c=relaxed/simple;
	bh=ACb4GGFjTrdVvF2Oke1q4PEwSt/ZiYyj9QQXBzZRsVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISkX9HAFdFHmFo9gll/F19nOG6BffcDeSNlCF0rGdoL+4+Iv3KNC3iykxgm2ebc80ysGcL1u4Z+LS3Eir78AG5cs6j6fzXvHydfG0dVM4Q4qV9Qq9viRoFZLOfOj0fqdweBtbc8X3OGmMilbHaj0jvFZbE6l6K791jdUyg3UO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAGwA7J9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAGwA7J9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4B2C4CEF7;
	Wed, 25 Mar 2026 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774437389;
	bh=ACb4GGFjTrdVvF2Oke1q4PEwSt/ZiYyj9QQXBzZRsVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAGwA7J93JgTqleQAKxVNRgJTmXJVtGmwRgF6Fow99Djzk5G45z8PY53GEyfKoimf
	 1GH1q7ke+rzh+n1uQcjnEF4dXa3foUCe5NwGcq/PnKpPdQYB9xnkc5ZpDJOngqYd0X
	 PkK6ioVir39Q6hbKoyNNXKWWzBrItY8snidEMsXF8C6ZYCtuvORCo9Q7r7++vWX1tD
	 ur9TKX2b4N8pVbglzuM5+8rQsCjkD5dz/Pac33gtj4XnDMkSOKhvpAK/zWC117t/bU
	 UrFm7q1PSYevuaOaDGZDwrIuKSiqgixBCTfK4h5x4hDwO3ervhyekstB3q/XKGINH4
	 FjwcFJhXydUrA==
Date: Wed, 25 Mar 2026 12:16:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andi.shyti@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, 
	m-chawdhry@ti.com
Subject: Re: [PATCH] dt-bindings: i2c: intel,ixp4xx-i2c: Convert to Dt schema
Message-ID: <20260325-bulky-mushroom-of-science-8c95c4@quoll>
References: <20260324135010.17730-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324135010.17730-1-i.shihao.999@gmail.com>

On Tue, Mar 24, 2026 at 07:20:10PM +0530, Shi Hao wrote:
> Convert IOP3xx and IXP4xx XScale bindings to DT schema.
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

> ---
> Note:
> * This patch is part of the GSoC2026 application process for device tree bindings conversions
> * https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> ---

...

> diff --git a/Documentation/devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml b/Documentation/devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml
> new file mode 100644
> index 000000000000..13ba2a0e336e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml
> @@ -0,0 +1,41 @@
> +# SPDX License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/intel,ixp4xx-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2c Controller on XScale platforms such as IOP3xx and IXP4xx
> +
> +maintainers:
> +  - Andi Shyti <andi.shyti@kernel.org>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,ixp4xx-i2c
> +      - intel,iop3xx-i2c

Alphabetical order. Dunno why you reversed it from original binding.


> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

This wasn't in the original binding.

What does my guideline/expectations for GSoC say? Did you read it?

Best regards,
Krzysztof

