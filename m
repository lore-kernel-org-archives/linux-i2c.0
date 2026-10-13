Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7B494801;
	Tue, 13 Oct 2026 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871878; cv=none; b=FLYG3xbeKRpFUVZxfmtAv5nIl+9In0JzdmtZM33d3LybqsJ1/245WhDsKMexTl3WSj12GQ0t/PVgE6pZ0U/pFsYihjicZdDQDwvF6zOR2BguFC389OaGE1pG1CdKgs691xa9lC8krog4x3Tdhe7mcrJ/uqhJjeipcUu5YPQs7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871878; c=relaxed/simple;
	bh=6P/KMeGkNJRqtPOx3PtlRJJ0A6uRzmT744jflR6cPIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIhJUISgnoyoapp6E5t5Jnh4M6fd0qOYP8Od3pzN0Krj9TP/VMAFdcZCbYu9Y+NveFBj3pMPs7RJIA68slsz8uXsShncBgwX2rw3m8epdVI8qFBCU9E8C+LUrOWIOoC/8aR0aVOHAI4TfOR/ilgYOl/VDCH6um5vqt2VBoCPmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAvkk0Lf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAvkk0Lf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6341F000FF;
	Tue, 13 Oct 2026 06:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791871875;
	bh=YgKgrdCbYrKNqKmmilqEA/C7pkoF4WC+apj6WJz3DtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GAvkk0LfD+4vBLjJ9DyaVv/bBbS9L6KW4OQ9qrhzXQXbEUWZvChCzurFrJg3F99x6
	 7zhaQvZRNLGURdhd9UyJAMGicZ+78WALgeA5f6IpvGOJqCo2VGRBibvmIUoSbuJJAD
	 p4UPaAl6t86Y1CJUOZcsiMC7TaFDmRU0z8H6qi6nyRcNct3qqlE54EJ5Mn/Oz2r/Me
	 djkER95TAbZpa7lv+5CXysAk2Ir4kSKYlipi+h2nqtbW5MeJqNfwk3mGuvySjEOcgE
	 n4VjmeUXfqtH/TfJk0tVBkGX7P9qeWFeoCTyvQJ9+8opDIHi38/zfinbgRwT7p90ue
	 uP9c9+THGjNdA==
Message-ID: <58cbdffa-7574-4daa-851b-dbb50012f158@kernel.org>
Date: Tue, 13 Oct 2026 08:11:09 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] dt-bindings: i2c: Add NVIDIA LSTP I2C
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Donald Shannon <donalds@nvidia.com>, linux-usb@vger.kernel.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
 <20261012-lstp-usb-adapter-v1-2-aambrozewicz@nvidia.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261012-lstp-usb-adapter-v1-2-aambrozewicz@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/2026 19:36, Adrian Ambrozewicz wrote:
> Add the binding for an I2C controller channel of an NVIDIA LSTP USB
> adapter. Peripherals on the bus are child nodes, as for any I2C
> controller. The device sets the bus speed and the protocol cannot
> change it, so clock-frequency is not supported.
> 
> nvidia,retries sets how many times the host re-issues a transfer that
> failed on arbitration loss or a busy bus (default 3). The generic I2C
> controller schema has no property for this. A device that reports its
> own arbitration retries handles both cases itself, and the property is
> ignored for it.
> 
> Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
> ---
>  .../bindings/i2c/nvidia,lstp-i2c.yaml         | 71 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/nvidia,lstp-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/nvidia,lstp-i2c.yaml b/Documentation/devicetree/bindings/i2c/nvidia,lstp-i2c.yaml
> new file mode 100644
> index 000000000000..eacabed52cd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/nvidia,lstp-i2c.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.

We do not use that tag. Drop it everywhere.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/nvidia,lstp-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA LSTP I2C Channel
> +
> +maintainers:
> +  - Adrian Ambrozewicz <aambrozewicz@nvidia.com>
> +  - Donald Shannon <donalds@nvidia.com>
> +
> +description: |
> +  I2C controller channel on an NVIDIA LSTP USB device.

Say something useful.

> +
> +  Peripherals on the bus are described as child nodes.  An i2c alias
> +  gives the bus a fixed number.

What are you describing here?

> +
> +  The bus speed is set by the device.  The LSTP protocol has no way to
> +  change it, so clock-frequency is not supported and is ignored.
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: nvidia,lstp-i2c
> +
> +  reg:
> +    description: Channel ID reported by the device firmware.
> +    maxItems: 1
> +
> +  nvidia,retries:

You described the desired Linux feature or behavior, not the actual
hardware. The bindings are about the latter, so instead you need to
rephrase the property and its description to match actual hardware
capabilities/features/configuration etc.

> +    description: |
> +      Number of times the host re-issues a transfer that fails on
> +      arbitration loss or a busy bus before giving up.
> +
> +      Ignored when the channel config reports non-zero bus arbitration
> +      retries.  Such a device is expected to retry both arbitration loss and
> +      a busy bus itself before reporting failure, so the host adds no
> +      attempts on top.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 255
> +    default: 3
> +
> +required:
> +  - compatible
> +  - reg

Incomplete, where are any resources? If you do not have any, then this
should be folded into the parent node.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    interface {
> +        #address-cells = <1>;
> +        #size-cells = <0>;

Why do you need that wrapping node and what is "interface"?

> +
Best regards,
Krzysztof
