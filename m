Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8A1684A4;
	Wed, 25 Mar 2026 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403162; cv=none; b=oblWcGsfUq7HnZNIEQCjxdABWro5dUz7eBDc3foFBp/Op2obYUxpyuWi0LTDnGeFDT7gBIZg01oSTM96GDBTeC9XtQvYqoQlPeq2RSNCrtKBZsKqRoWq3i8Fm1i5PVyhgd/YypZ5jq368dgRs+AwEN+Lw/FtbPfOz8qmoNKLLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403162; c=relaxed/simple;
	bh=HvRVk/YPY3gKc9XAyt9raBZ1qgC/+JELgZiZx+SJ6N4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=aVKOCXT04uH1X5T7h2vRAZrVg2FWQJGFKP/qujTrUhM75yc5UHK1/aY2nJR4XAurC44EXUBCcuUjawZfjdNwl5w42YLnrbnV9u4mAFfjfL4khpMiR6rutzLmE3Wsf+ytPCd/zy4xI/L4Cp3GHCnyi6rcteu8aUe7dBsqB4emBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P44exNmx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P44exNmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82E9C19424;
	Wed, 25 Mar 2026 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774403161;
	bh=HvRVk/YPY3gKc9XAyt9raBZ1qgC/+JELgZiZx+SJ6N4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=P44exNmxQ70a5hsAAw7auqSfc7E3xhP6zmBLbY4VKOeDbOBlza3XzQg6kWsfAEFW4
	 cxI9ZsxnlQhX9NxVYWkUAdeng9+r8dhX1Mr0hig5YUDL/Yr8c5UPAjWhSxiW1CCZ1D
	 qKBJyAingduujPrMri2ea23aolKVEqeXU3CUIvZEVczw73geOtQ5rqVYe4vxQW1PM4
	 KjkJa4P0bYdQY4fC6Yk1YdbFO25qrm0jaz73De8BF3IAnl/pleeGI6tadvBh5ypnE5
	 K92aL6SnMpHQUMSE54vM7nGYX5crg96AMONStV7M3W1ZL1M/1hSbrRMMPsY238m1GR
	 q/XKQSgLSUtIg==
Date: Tue, 24 Mar 2026 20:46:00 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: jk@codeconstruct.com.au, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Rayn Chen <rayn_chen@aspeedtech.com>, linux-arm-kernel@lists.infradead.org, 
 linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
 andriy.shevchenko@linux.intel.com, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
 linux-aspeed@lists.ozlabs.org, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
References: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
 <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
Message-Id: <177440316087.2477729.6574194979133287654.robh@kernel.org>
Subject: Re: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties


On Tue, 24 Mar 2026 11:06:27 +0800, Ryan Chen wrote:
> The AST2600 I2C controller supports three transfer modes (byte, buffer,
> DMA). Add "aspeed,transfer-mode" so DT can select the preferred transfer
> method per controller instance. Also add the "aspeed,global-regs"
> phandle to reference the AST2600 global registers syscon/regmap used by
> the controller.
> 
> These properties apply only to the AST2600 binding and are not part of
> the legacy binding, which uses a mixed controller/target register layout
> and does not have the split register blocks or these new configuration
> registers. Legacy DTs remain unchanged.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v27:
> - change aspeed,transfer-mode to aspeed,enable-dma.
> ---
>  .../devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.example.dtb: i2c@80 (aspeed,ast2600-i2c-bus): Unevaluated properties are not allowed ('aspeed,transfer-mode' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/aspeed,ast2600-i2c.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

