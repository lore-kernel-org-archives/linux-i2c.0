Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D84F490C10;
	Mon,  5 Oct 2026 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214835; cv=none; b=ejHkeAYNS5t5S6goGerO4suOu4eehSe9gMquqFl1+tRu/EXAlGOW0w8fYQdbu5wW30fZ9ufwdoEDtmEp2Et18F0lZJOi5Cq6OlFFkZMY2+XdjqBwNvIuUYtwS3NTwJSoBj+5Y5d7GjXWuhx9+E6wdYLXwaNJjJ0GxzpQaj7f6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214835; c=relaxed/simple;
	bh=e7xRSjYl4E0fpu2J3ZomS4wEmXaESY5OJdfoqG1Gxnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ca/mRdJqhQYb9Efvb+kKtjBsCflWaFA0d+bHfAK5lEiF1MjBGhThOOHjG7aAkh2jEUNJLT5zNqtuq8OnYdOyL4NG/gjZp3erBHYsK3WEJ5lEilKytHlyHDrsBe1Y5luz4QvzmeVrjbDKSMlgyE5FIsipA2bzaPrp2gH8YgXwTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnqfR+Oo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnqfR+Oo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0A01F000FF;
	Mon,  5 Oct 2026 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214833;
	bh=770xBw6G6hcnC/5NwlVxxMZESUM0SI4myi4X8aEmkWQ=;
	h=From:To:Cc:Subject:Date;
	b=WnqfR+OoLMlS4MHMTLoF6Yfv5gfzxFOABvsPMapX02DQWOKws07NRtjLfzrjYED5o
	 QF/WS6UW63qcTrlB7GCJb9FqzhT+VNMqica6rw3IWOb2NAmExSmEjPuERkA/ld8RWV
	 Kve8hx1fKxRAYpG+SCBh8BjibLAUlzxs+6X6MjWturcNL1A1Z0cjn5XZ1Up5Oepxc4
	 aNEUkuf2/xwmqob9GmB3Sy/DUbtMTuoGLVbJdEaj6Ni8P28k4gm5ZQpR5OdXaltdjC
	 qBdtxZ/UodcJ1CYpijmL1LVd514OtGoRHLLRk0SI1/r/3PVHFF3V6xWDU+L4qjIbKP
	 +tLS0V1f8mdGw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: i2c: dw: Add Synaptics sl2610 i2c
Date: Mon,  5 Oct 2026 23:20:36 +0800
Message-ID: <20261005152036.25276-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the Synaptics SL2610 SoC I2C controllers, which
are compatible with the Synopsys DesignWare I2C.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
---

since v1:
 - use sl2610 instead of sl261x
 - send as a separate patch
 - collect Acked-by tag. Hi Andi, I still added your Acked-by, but
   replaced sl261x with sl2610, feel free to comment if you have
   concerns.

 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index 467bdcbb8538..467688be922b 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -43,6 +43,7 @@ properties:
               - mobileye,eyeq6lplus-i2c
               - mscc,ocelot-i2c
               - sophgo,sg2044-i2c
+              - syna,sl2610-i2c
               - thead,th1520-i2c
           - const: snps,designware-i2c
 
-- 
2.53.0

