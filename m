Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC7640BCB4;
	Mon, 12 Oct 2026 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805970; cv=none; b=eDHrNwYQwfHtCcscdrPjaiKkQqbaMS5ulVzD5eCNIidJ+YRxmBrpcdVAMPUcQCRzLJASK5t9pTXBmf8/l/Q8AbK9+AzhjiS3a2xbsQK10u0sb/E+JTh3Ua5MhkyjcfHBg234tnf+lnACvH2hydjosNVH1O8J9J0fAWALMpfGmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805970; c=relaxed/simple;
	bh=Cx0V5n44wKR/15Cz0ZApx0HFfm4Qyw1pp5qgBuKOdb8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AUxM1rP1b5obxTZz6Yjc/FpQfL8La5ajwEE49cxb+oNwkAGXgqsC/1O773LGbEu63zeVH7dmZLyMZtrQL/ZCfNWEwfrL9AFLYS2nDkjNOUcGj3UGZz0tBK0Tt8vXzl1VEfQg1ZDz3BtXSQ7BdJa01H+CAg3i7LVQvbLSr33kRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=dPcqrA74; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="dPcqrA74"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791805960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ffd6U0ud/BZgtTg0q0JYVe7wVelt+yEgyu9d4S2SN0M=;
	b=dPcqrA74FmgwBDpXRUvCVdmUIB6qOUwNl8EFHoBSAQqkpUPDJhjRI0R2WQEeiUQHJ2uCxm
	LWyJdps+s/wXUv+iE+fIAYpPzcO5nF9VgzAAKsk5D+kq0sp9DjgRdPD9ooZDa0Vg8TfNYC
	s9rg80TW8oy7Xo8fSTPj95T5J66u9h8=
Subject: [PATCH 0/5] I2C and pinctrl support for Apple A18 Pro devices
Date: Mon, 12 Oct 2026 13:52:31 +0200
Message-Id: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAwA0F8ZORtYAmrxV8RD10aNjC6kVYSxf
 7fq8V3eClVcpcJpWMHlpVWX0kG7AdI9lpug5m7gkQ80EmM0mwUjBTRfMDc0Lan5jMoJ5RhoH6a
 ciQP0wlyu+v7158vf9Tk9JLXvCdv2AbuWsziAAAAA
X-Change-ID: 20261012-apple-a18-pro-dt-pinctrl-i2c-e78158bdd128
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

Hi,

this series contains two small formatting fixes for the A18 Pro device
trees, and adds the required dt-binding for i2c as well as the dt nodes
for pinctrl and i2c controllers used on the MacBook Neo.
The pinctrl dt-binding was already picked up from the previous series
regarding this topic [1]. The dtbs_check passes when this is applied on
top of linux-next or otherwise combined with said change.

Merge strategy:
The only change in this series outside of the device tree itself is the
apple,t8140-i2c dt-binding. There are no other pending changes to this
file, so it could simply go through the apple-soc tree provided Acked-by
from the respective maintainer.

Link[1]: https://lore.kernel.org/asahi/20260926-apple-pinctrl-t8140-v2-0-620bd11cd2a1@cyberchaos.dev/

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
Yureka Lilian (5):
      arm64: dts: apple: t8140-j700: Fix property ordering
      arm64: dts: apple: t8140: Group cache-related properties of cpus
      dt-bindings: i2c: apple,i2c: Add t8140-i2c compatible
      arm64: dts: apple: t8140: Add pinctrl nodes
      arm64: dts: apple: t8140: Add i2c nodes

 .../devicetree/bindings/i2c/apple,i2c.yaml         |   1 +
 arch/arm64/boot/dts/apple/t8140-j700.dts           |   2 +-
 arch/arm64/boot/dts/apple/t8140.dtsi               | 172 ++++++++++++++++++++-
 3 files changed, 168 insertions(+), 7 deletions(-)
---
base-commit: becb95e45ef0dda9ffb35156d909d3da7a2789c3
change-id: 20261012-apple-a18-pro-dt-pinctrl-i2c-e78158bdd128

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

