Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD10340DB8;
	Thu, 22 Jan 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090474; cv=none; b=ZwGYGBgsge4D1DQDbweFGJwPGxK4L26AYg1TrMW4l80F5QjWtyPKa3sGb2ceLjQ5VvSe1JdRVrJdwWb4aRsnwzK0WWhuJ5IrKvzX4Rc0y+n9O1UhJovcKAKepUQ0GvsQvrYbGidu0ChR/RlHbWQ+OD4Hu77+w+YVuk+cEbxlO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090474; c=relaxed/simple;
	bh=fsi6tZlV53Bbo7PI+1XsqofghlWX4lua2yC1YfkvdKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK5poNiFwGjyuHvKzsx49ydzeldAMuCcas1rnjIJhI/4UrIhZb6oR5uCjws+GMHvavN8wLr1x6SGHj8OBnmlblBPRtPLn+F+rNSpvrkUNhclki06Ir+gBmIOXFMf/7E4czPLRWr4k5lhqDkYleVLkR6WPV3sOr86TvOdt4zd39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTP id 60MDxOHh098730;
	Thu, 22 Jan 2026 21:59:24 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from ANB420.andestech.com (10.0.12.111) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 22 Jan 2026
 21:59:28 +0800
Date: Thu, 22 Jan 2026 21:59:27 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andi.shyti@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: add atciic100
Message-ID: <aXItPwMWZELM_BoL@ANB420.andestech.com>
References: <20250207021923.2912373-1-ben717@andestech.com>
 <20250207021923.2912373-2-ben717@andestech.com>
 <20250209-antique-camel-of-assurance-390cb9@krzk-bin>
 <aXIHg59ZZouB9WMl@ANB420.andestech.com>
 <d85048ff-ed13-4fe0-ab5c-b1ba810964a5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d85048ff-ed13-4fe0-ab5c-b1ba810964a5@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 60MDxOHh098730

On Thu, Jan 22, 2026 at 12:27:00PM +0100, Krzysztof Kozlowski wrote:
> [EXTERNAL MAIL]
> 
> On 22/01/2026 12:18, Ben Zong-You Xie wrote:
> > On Sun, Feb 09, 2025 at 01:29:58PM +0100, Krzysztof Kozlowski wrote:
> >> On Fri, Feb 07, 2025 at 10:19:22AM +0800, Ben Zong-You Xie wrote:
> >>> Document devicetree bindings for Andes I2C controller.
> >>
> >> Explain what is the hardware... Here is Andes I2C
> >>
> >>>
> >>> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> >>> ---
> >>>  .../bindings/i2c/andestech,i2c-atciic100.yaml | 40 +++++++++++++++++++
> >>>  MAINTAINERS                                   |  5 +++
> >>>  2 files changed, 45 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml b/Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml
> >>> new file mode 100644
> >>> index 000000000000..cf96a9186176
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml
> >>> @@ -0,0 +1,40 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/pwm/andestech,atciic100.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Andes I2C Controller
> >>
> >> Here as well
> >>
> >>> +
> >>> +maintainers:
> >>> +  - Ben Zong-You Xie <ben717@andestech.com>
> >>> +
> >>> +allOf:
> >>> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: andestech,atciic100
> >>
> >> But here atciic100. This is all confusing. What is the SoC? What is the
> >> name of this device?
> >
> > Hi Krzysztof,
> >
> > Sorry for the confusion. atciic100 is the name for the I2C IP block, and it
> > is integrated on QiLai SoC. That's why I added a new compatible
> > "andestech,qilai-i2c" in v2.
> 
> So atciic100 is not an SoC... but then why there is I2C and SPI variant?
> Is this some serial engine? Because if it is, you probably miss here
> much more bindings for complete hardware description.
> 

There is no variant for atciic100. It's a dedicated I2C controller IP.

> Plus, if this is IP block, how can it be used alone? We forbid that sort
> of compatibles long time ago.
>

I made the mistake you mentioned above in v1. But after your review,
I know the compatibles in the bindings should be <soc/platform>-<device>.
Thus, I have removed "andestech,atciic100" in v2, and have used
"andestech,qilai-i2c" and "andestech,ae350-i2c" instead. Also, I have
removed all the occurrences of atciic100 in v2 to avoid the confusion.

v2: https://lore.kernel.org/linux-i2c/20260122-atciic100-v2-0-7559136d07cf@andestech.com/

> Anyway you have entire commit msg to explain that.
> 

> >
> > For AE350 platform, I know it has not been upstreamed yet, but it was
> > discussed and acknowledged in a separate SPI series [1], which is why I
> 
> I see ae350-spi there, not atciic100.
> 

The reason I mentioned the SPI series is I want to add "ae350-i2c" in
this binding, like "ae350-spi" in the SPI series. Again, could I keep the
compatible "ae350-i2c" as the fallback compatible in this binding? If
not, there will be only one compatible "andestech,qilai-i2c" in the
next version.

> > included it as a fallback. Can I keep this? If not, I will drop it
> > and update the compatibles in v3 as follows:
> 
> Nothing was explained in the commit msg, so with all this being
> confusing that's the review you got. You literally wrote one half baked
> sentence being copy of subject, so like nothing relevant and should be
> treated as almost empty commit msg.
> 
> How do you expect us to understand anything from that if you write
> NOTHING in the commit msg (except copying subject)?
> 

I apologize for the lack of detail, and thank you for your patience.

Thanks,
Ben
