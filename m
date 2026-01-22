Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023C3A9D93;
	Thu, 22 Jan 2026 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080865; cv=none; b=brFTyAAczyfOT/ZsHkAkNOYshUP48FEZNNIkBOrmHMR9fyLX+bnIVqSs8fTM8ra4YUCCxEJFVimdvEZ5a9Lswkh2ScpH/t5o/JarUR1X2pp1mQ3rqyGGdzNcp/rNua2vb/S7ejRqAPl0+6u5W/UTMxBRv6S8EACVqgT9rUuR3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080865; c=relaxed/simple;
	bh=3Yojzs8UTYV+tM4EYnxzYyzAnIWHx36MfIb1mj50Exc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCMkXbVAxgKAD4GpJID+s4qNqrPXubgAQk5KvnD0+vczKrk7pFF2sixiB6CDpt6xod0AGQjuoZn4JEIFuemi50ypZ4HqmnHNDkngEIEGs4dw62Jtb+W67e24GLaugObsb1XjUTk+n5PYaWLxh0YeLdebmM/K1lMDQ/kBd9r7N24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTP id 60MBIOsv046163;
	Thu, 22 Jan 2026 19:18:24 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from ANB420.andestech.com (10.0.12.111) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 22 Jan 2026
 19:18:29 +0800
Date: Thu, 22 Jan 2026 19:18:27 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andi.shyti@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: add atciic100
Message-ID: <aXIHg59ZZouB9WMl@ANB420.andestech.com>
References: <20250207021923.2912373-1-ben717@andestech.com>
 <20250207021923.2912373-2-ben717@andestech.com>
 <20250209-antique-camel-of-assurance-390cb9@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250209-antique-camel-of-assurance-390cb9@krzk-bin>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 60MBIOsv046163

On Sun, Feb 09, 2025 at 01:29:58PM +0100, Krzysztof Kozlowski wrote:
> On Fri, Feb 07, 2025 at 10:19:22AM +0800, Ben Zong-You Xie wrote:
> > Document devicetree bindings for Andes I2C controller.
> 
> Explain what is the hardware... Here is Andes I2C
> 
> >
> > Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> > ---
> >  .../bindings/i2c/andestech,i2c-atciic100.yaml | 40 +++++++++++++++++++
> >  MAINTAINERS                                   |  5 +++
> >  2 files changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml b/Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml
> > new file mode 100644
> > index 000000000000..cf96a9186176
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml
> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/andestech,atciic100.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Andes I2C Controller
> 
> Here as well
> 
> > +
> > +maintainers:
> > +  - Ben Zong-You Xie <ben717@andestech.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/i2c/i2c-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: andestech,atciic100
> 
> But here atciic100. This is all confusing. What is the SoC? What is the
> name of this device?

Hi Krzysztof,

Sorry for the confusion. atciic100 is the name for the I2C IP block, and it
is integrated on QiLai SoC. That's why I added a new compatible
"andestech,qilai-i2c" in v2.

For AE350 platform, I know it has not been upstreamed yet, but it was
discussed and acknowledged in a separate SPI series [1], which is why I
included it as a fallback. Can I keep this? If not, I will drop it
and update the compatibles in v3 as follows:

properties:
  compatible:
    const: andestech,qilai-i2c

[1] https://lore.kernel.org/linux-spi/20251210-repeated-perjurer-99219893524a@spud/

Thanks,
Ben

