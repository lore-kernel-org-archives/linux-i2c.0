Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90812197558;
	Wed,  9 Oct 2024 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482472; cv=none; b=IpDhzxy9sRHbgA6WI1lioOu/dmLFC5Zi69yMMu8YDT+BaAw3GRQV8WnIOBrlkhlxSrffAJRB/scsNJsBg2lNKNdU2ds/v3xIU85Ymy3TITz569htaPUS/V9gqV04uzWCGpo57j14uUefkq0GecsNsKv7dde+HeHcDYulUNtmTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482472; c=relaxed/simple;
	bh=3MSs1fdm/p1+LrhWHubFXSBSpCZhYGnR8WaGMOsiEUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mn2GmBvGr2ZTV3S0j0P/S6dnAdKnQmzminYmXjfNdT13l6nAYdT790qAzl3DC1JQHOOz3v7LvNDXlBWrntfV2CnvJM4R+eHGtqXbwBZn4OB+JVa9quFcRsNyoed9ll9EYokaba6he/gVXJTnc1J4/98vJkBhESibPYtNxDOooBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b2jo1umh; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b2jo1umh"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DA7B1BF205;
	Wed,  9 Oct 2024 14:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728482469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gA2VtzJur2fLfrAh7HiOZK9GKI0XRlL4niun8+mE/+k=;
	b=b2jo1umh/A1j9iiRQpuv8IobE+8z3xMSlPprZC7+qc/zEYrw9hdJxIPIVSWQcSOwq+ATWR
	cBqbqhPTca8N7tm2EY/PCleh5FgDGsnbZRqTGNeABg8QpsrNyWc+hOYMRFEvKP4SekANYI
	peYF2opUr/J5GXkFIuSzJaCoemNceFMo5NH7ZMayeEZtDUkTOvPQfpb0/JvbW775e7H/xL
	W76H8vbHBa86aL5meHk7UXBbVHALrvosc/c0GzvF4a2aSGCxUl2vWab0gquF3xnORQXsEl
	zQCzI6LCQwb+XC/58lF4IALwgHmtPsep+Tr0sp4elDjCROPMzV/3vJlQL8+TOQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 09 Oct 2024 16:01:08 +0200
Subject: [PATCH v3 2/6] dt-bindings: i2c: nomadik: support 400kHz <
 clock-frequency <= 3.4MHz
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241009-mbly-i2c-v3-2-e7fd13bcf1c4@bootlin.com>
References: <20241009-mbly-i2c-v3-0-e7fd13bcf1c4@bootlin.com>
In-Reply-To: <20241009-mbly-i2c-v3-0-e7fd13bcf1c4@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: theo.lebrun@bootlin.com

Hardware is not limited to 400kHz, its documentation does mention how to
configure it for high-speed (a specific Speed-Mode enum value and
a different bus rate clock divider register to be used).

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/i2c/st,nomadik-i2c.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/st,nomadik-i2c.yaml b/Documentation/devicetree/bindings/i2c/st,nomadik-i2c.yaml
index 7e84465c20094b799697a71a66c66d144d621f46..012402debfeb244b85dcecdc0411a77ada4494df 100644
--- a/Documentation/devicetree/bindings/i2c/st,nomadik-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/st,nomadik-i2c.yaml
@@ -68,7 +68,7 @@ properties:
 
   clock-frequency:
     minimum: 1
-    maximum: 400000
+    maximum: 3400000
 
   mobileye,olb:
     $ref: /schemas/types.yaml#/definitions/phandle-array

-- 
2.46.2

