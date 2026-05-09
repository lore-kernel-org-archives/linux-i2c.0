Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D8375F82;
	Sat,  9 May 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778351980; cv=none; b=MAnt8v3Vwe1oGChEkLl1Roxqe1ITz7RdMAVB1mdoVFshULNy/TvVW6yXjKDeRN1En1f361dbZ1h/+5V4gCiZNnDJKlLE3rpr6n7ETWNAhYzatXeCQekvAsKqwciIxhCW55b4lWJiRVn2jHvg62/Y4Y46tVEdD8A8Q5qvJv5h/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778351980; c=relaxed/simple;
	bh=wOJLEzf+rx/GJNnZw66wIn7rzt4vSZIvEbRfirdKAmQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FXQiNDrTGgaHzSDeikLORt9pI56lUKEJ3oRCywIhKcy/hw+FzBW/FrgSbP/m1Ee2TWPYd0Hx0zOjXHy91I/C4VQLTk5bxGcQEUFnSDh6Xnu4n16TaEbuIUAq9BHkCt5B4IYxlF56MjeaQXSz9g84C3tCWRDNgK5p3Wd2w4/GENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBZftAhM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBZftAhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DDEC2BCB2;
	Sat,  9 May 2026 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778351980;
	bh=wOJLEzf+rx/GJNnZw66wIn7rzt4vSZIvEbRfirdKAmQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZBZftAhMwz9pgIm5LUEyQSQtoT0ZJIPiNcN+gaB/kEaQVaQ7IcU64bzRjQGQlYSq6
	 a88pQVthkOj20eZM9FV3Ukv89gqA0mdD6cLxpmqdvqa7UKB4XlM0VTftyBYmSQvaGO
	 TQcj0xaVaJ7bVMsvAakpyzvHZYi2sGbFhhFdhko/J0XKKu46argoe639ELsuK6R7lB
	 1NI97qknuIKDfRBwd84D0ryP0tcD+6T9RkjqHaPxDxvdAzaia2dHL72IOq40B7ilXJ
	 swwsWZO1CEmRFWEArO8TyvR+2MxW37d+tlU89pqek6Yao6vUjsc6HXQ1FzoSzRAbPZ
	 huP7yEDXJBcNg==
Date: Sat, 09 May 2026 13:39:38 -0500
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
 Conor Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>, 
 Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
In-Reply-To: <20260509171644.12513-2-wsa+renesas@sang-engineering.com>
References: <20260509171644.12513-2-wsa+renesas@sang-engineering.com>
Message-Id: <177835197752.785526.10193851716163594776.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: i2c-mux-pinctrl: remove Wolfram Sang
 as maintainer


On Sat, 09 May 2026 19:16:45 +0200, Wolfram Sang wrote:
> The YAML conversion added me as maintainer but I can't recall being
> asked nor do I want to maintain it now. Remove the entry.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260509171644.12513-2-wsa+renesas@sang-engineering.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

