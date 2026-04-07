Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A833D503;
	Tue,  7 Apr 2026 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580381; cv=none; b=O7L+7YYiCtHt3VtboRz3HNP6Z8eK0jJJEIEzl9PJn9u3clA0g+YIzInOpREz0rVwFtoundUMJvJVdz3QwwntFlPPvGT2qyaCCKk0bOaXQze7p4OKacrpzWhmdeqvE7AeEfFQbT0ZXZc+mhCzIQp7+Mxe+Ioj7Ub8GvOCPpI86LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580381; c=relaxed/simple;
	bh=jfLmHt1jktt0gZSNnRJIWqA9vOHoNxlluJSTbjHBDRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYd7iocOHF7y7YkUedGjh2+yTlhsiJb39qFshvzQy2XUrNEV+pLJKP5dusaTgz+3gad2gixA2955mA5/3qa8o0xk3cF4Fmtrs8SQ0xvpoPO3Y5EYPZu855kRjkjTAj/a0Ztx/Y1pnj0dC7H6qe4ohch7yKxcWnIWruchmjJKEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6wO7jZc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6wO7jZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DDEC2BC9E;
	Tue,  7 Apr 2026 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775580380;
	bh=jfLmHt1jktt0gZSNnRJIWqA9vOHoNxlluJSTbjHBDRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6wO7jZcg4aNPOQrWHOhNLdbekoQktYJqWUNQsp+GDUo4DidxnxTBevcZPrYNSkQm
	 b0Zpscj7pEN/dyg8at9pYhpnElDP/lZzfb2mFmuf7RLkc5s/FTa2+KyiXPU+0l2esV
	 zvT4Mrw1ilWm6WHArGNOhTZmg9pENuM14mNB2FPrM0xZ/lvE9P35K8HTm5iYeOHukE
	 vKyyuyd1roocRtmi5p4O/78y3ylnOwgc/GhhgHBJRw273s09JfxXU3CrWO/GIynztB
	 Ox6JmzGuOBpC6oiBWcnmwM8Y+x3IBJywAri1bRBJCst5Zrebbmes/Kb3uQ3Aq74j3H
	 r2PKXY2OSgY5A==
Date: Tue, 7 Apr 2026 11:46:18 -0500
From: Rob Herring <robh@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: krzk+dt@kernel.org, andi.shyti@kernel.org, conor+dt@kernel.org,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@nxp.com,
	simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH] dt-bindings: i2c: cnxt,cx92755-i2c: Convert to DT schema
Message-ID: <20260407164618.GA2903702-robh@kernel.org>
References: <20260323174236.147507-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323174236.147507-1-i.shihao.999@gmail.com>

On Mon, Mar 23, 2026 at 11:12:36PM +0530, Shi Hao wrote:
> Convert the Conexant Digicolor I2C bindings to DT schema.
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
> ---
> 
> Note:
> This patch is part of the GSoC2026 application process for device tree
> bindings conversions https://github.com/LinuxFoundationGSoC/ProjectIde
> as/wiki/GSoC-2026-Device-Tree-Bindings
> ---
>  .../bindings/i2c/cnxt,cx92755-i2c.yaml        | 51 +++++++++++++++++++
>  .../devicetree/bindings/i2c/i2c-digicolor.txt | 25 ---------
>  2 files changed, 51 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-digicolor.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml b/Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml
> new file mode 100644
> index 000000000000..669397bbc571
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/cnxt,cx92755-i2c.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/cnxt,cx92755-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Conexant Digicolor I2C controller
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +maintainers:
> +  - Baruch Siach <baruch@tkos.co.il>
> +
> +properties:
> +  compatible:
> +    const: cnxt,cx92755-i2c
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    default: 100000
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks

> +  - '#address-cells'
> +  - '#size-cells'

These 2 are required by i2c-controller.yaml already, so you can drop 
them. Otherwise, I don't know what issue Krzysztof sees either.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
