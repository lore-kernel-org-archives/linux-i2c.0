Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44934071C6;
	Sun,  7 Jun 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849957; cv=none; b=uh+PDjnlWCBJU3BDr6LIg1fnIllfLAzR692MWeX36OeiNJRRbiWY3IMTJGlpQeqxYXpYYsVtJM5E4dNEGtknBGftG73AFi5UoRSl1WZgQ2s7AgunmBcxoSrIXdgE9Y481vr3IwGHngNnMQt1dckeAK7UIqKhGyBBJCs03zBRA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849957; c=relaxed/simple;
	bh=Wl21rwR5rysT/J2e3+/8UakcB3jwIRYxksNwhJCaeAY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=BgMGi/2hC29QOb3abbhpSBCSTnoIY8jZ7zbc80TUj/JYLo+MBXR5rQTfru97J5OhS+o/Mzxo8dITbjvrHiWBqf7cXxhbP3bW3u/e9/P8B4ED/LuDBwgb9PhV0huSwtIKZahxOZki8SYOQ4kANA5Wo0WOXYTFZVayl60ydChbZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eglN1NcJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eglN1NcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A311F00893;
	Sun,  7 Jun 2026 16:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780849956;
	bh=lr2G63PyfwPQB4C0lsKLurLI5IeDz0SkDo6+XzreHFs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=eglN1NcJDa18cpyL4CAuhAOhgC4i1uCu22fMhFiq5i25d6Y1Mww5BOWnqzI8MZJ9Z
	 wtXLTVZ1ydMz/GzlTjdV7oo61whkfpkflqHCei2pA0dipXB056QMeVZbCXT2RR8+ob
	 Xo0GQQO995vPll2+6oK9lHloN1ABmn0jIMdqTqMqchhQDVSh9NOXwUOL3UdYbeHbEj
	 C3+yVWrYQfE4wdParHVnx8GZiziUpFM5vT5kZXJBHO0TEr7RImYS+ALofzyUHUWRWB
	 t7Pss/4kGeL53bP09TeVEAvAG8vFvX/+4vpvQGeab+jL3falVpQGL25UqgMBx/jcIx
	 jteSY0x6vgfeQ==
Date: Sun, 07 Jun 2026 11:32:35 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Peter Rosin <peda@lysator.liu.se>, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <20260607-i2c-mux-reg-base-bus-num-v1-1-f193b5a8fedc@nexthop.ai>
References: <20260607-i2c-mux-reg-base-bus-num-v1-0-f193b5a8fedc@nexthop.ai>
 <20260607-i2c-mux-reg-base-bus-num-v1-1-f193b5a8fedc@nexthop.ai>
Message-Id: <178084995520.4043722.11073475733919673696.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: convert i2c-mux-reg to DT schema


On Sun, 07 Jun 2026 01:20:55 -0700, Abdurrahman Hussain wrote:
> Convert Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt to
> the YAML schema so the i2c-mux-reg binding is validated by
> dt_binding_check.
> 
> Also document a new optional "base-bus-num" property: when
> present, child adapter N is registered as Linux i2c bus number
> (base-bus-num + reg), so static references such as sensors.conf
> stanzas remain stable across boots. The matching driver support is
> added in the following patch.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
>  .../devicetree/bindings/i2c/i2c-mux-reg.txt        |  74 --------------
>  .../devicetree/bindings/i2c/i2c-mux-reg.yaml       | 110 +++++++++++++++++++++
>  2 files changed, 110 insertions(+), 74 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/i2c/i2c-mux-reg.example.dtb: /example-0/i2c-mux@6028/i2c@0/clock-generator@70: failed to match any schema with compatible: ['silabs,si5338']
Documentation/devicetree/bindings/i2c/i2c-mux-reg.example.dtb: /example-0/i2c-mux@6028/i2c@1/clock-generator@70: failed to match any schema with compatible: ['silabs,si5338']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260607-i2c-mux-reg-base-bus-num-v1-1-f193b5a8fedc@nexthop.ai

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

