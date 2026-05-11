Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED84508FC;
	Mon, 11 May 2026 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521021; cv=none; b=XBrDqdlQ0rY1lKYg2hS9AfA2c7OZnamx7Z/y3FaMqXcYZhkEbrw9BTV7QxXDkxpYhGPIwWBEzOK67xbzVsrUillF5fkYXHYB6FXi235Oj34Lr5UNxyQqhHnIUMpYdO7G285IPUqIolFsdn8ga6rajdaMzvK6XnVi8IyIa5jVscU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521021; c=relaxed/simple;
	bh=VcOf6WSKT8uto3OOizIhoS3aC3hlK7uxX+e86+wrvSE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qgFjzt2ZAlo7lIeOZwuX4AC8bA0uThw//6V/cap60KDdvN7fYpTI5yeI4aI5R3Yls2NymHoGS/Eo9UpnGmtKqzW+VebDI09lCpmTeNyXGj0IcB9fsIdMUtiBCOJx5mIGfzk1U8bCIOMO+YRKuHudYwgxDqU4BtT3tngHUqkHtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PClwj9Bh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PClwj9Bh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0CCC2BCC9;
	Mon, 11 May 2026 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521020;
	bh=VcOf6WSKT8uto3OOizIhoS3aC3hlK7uxX+e86+wrvSE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=PClwj9Bhr9Vf5+gIq3+a4D4N2jn5F4TQ4eE3UuVK5BuHVwySeD6qmG7OGaH2DeUda
	 hIJuw9JGJNXfNT+VWPinruIHiLpFghtWCUk+RTSf4CwmsIhIMSmtzAxVlfC6uJ7w/4
	 QZDU/tQY50mFqlMsryyrfWXpEAFDHYSU7KRvCm5NB3jEis8xPi52YY8dFlnC2egz2U
	 db4F2kwPZZR1s1LWXGKs0v4L50P+3lkZJFZ/UotAwlqEiZuhcV3mslkH8zpJJZzLGR
	 kEg9EUVv4YaIzBm2uW+PO/nmtboHy7JrTG6Xy/1T5zwBzwiKPuYi69QfKdLL0kChZs
	 8WGF8/5qXIPmw==
Date: Mon, 11 May 2026 12:36:58 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-i2c@vger.kernel.org, brgl@kernel.org, devicetree@vger.kernel.org, 
 krzk+dt@kernel.org, wsa+renesas@sang-engineering.com, andi.shyti@kernel.org, 
 conor+dt@kernel.org
To: Markus Stockhausen <markus.stockhausen@gmx.de>
In-Reply-To: <20260511162528.84508-2-markus.stockhausen@gmx.de>
References: <20260511162528.84508-1-markus.stockhausen@gmx.de>
 <20260511162528.84508-2-markus.stockhausen@gmx.de>
Message-Id: <177852101859.2925549.3640378519742547152.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c: Add i2c-shared-gpio


On Mon, 11 May 2026 18:25:27 +0200, Markus Stockhausen wrote:
> Document the driver for bitbanged gpio I2C busses
> with shared SCL lines.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
>  .../bindings/i2c/i2c-gpio-shared.yaml         | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio-shared.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-gpio-shared.example.dtb: i2c (i2c-gpio-shared): sda-gpios: [[4294967295, 6, 6], [4294967295, 7, 6]] is too long
	from schema $id: http://devicetree.org/schemas/i2c/i2c-controller.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260511162528.84508-2-markus.stockhausen@gmx.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

