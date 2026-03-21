Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2136D51E;
	Sat, 21 Mar 2026 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073195; cv=none; b=duiH1ZpjyiYQOoSV+QywlR73CvN+uz6Tk1DSpVxGDF4SQzmp8oqKXNQ0e6WIcwO1kej1FT4fjn/b2NdfZu+MiYJRMMXyssfgMRv21J9EoL0AwL5w6mELb3R/xjf1hmeT42tfn57161mogdI8YWW44STPA7ta/L9GMx4blXxPdWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073195; c=relaxed/simple;
	bh=YkDqAiuLZbkCnBbCHESOAoR6zZUZOeJdrVgMsi4/LEw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PBTnsVmDmhkNwzlTZKAFAcakpu79ZH/RbAvcopdS/lZuoqYAZuFRGK9hUrTX4xsVGgaKMsNrcTovGhhES+ymBPjm64bi2rF06N1fSICrFXla3g5Xlot8YyhTK66PHuwMx6rXWhewINS77s9sjiFP3Rdxy9DV3c8SieTAq4dhbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=A/zFOjqp; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="A/zFOjqp"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2028427080;
	Sat, 21 Mar 2026 07:06:25 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mqTkm8cfzvK9; Sat, 21 Mar 2026 07:06:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774073184; bh=YkDqAiuLZbkCnBbCHESOAoR6zZUZOeJdrVgMsi4/LEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A/zFOjqphng/Lohd2aFEfLd4KMs00b3q1WUvRxpa4O5veV3wkdU1N5FLptT7U64Sx
	 54O0WhDDE6FAXyMLkxXQ6hUojSSupfpADq13wn455d45FfVu3BMVHcFAXPEnUVXlHw
	 saPAbG/s+cx2d34gsYL6rIaoR30X+VdB6Qfwwz/XMJGSlH4nWZYtH7vAHmEDl/m5u1
	 SEXm8dKTKIZN2M9GleufQ+8F4blp2xSkkz5yQrNx0gDItW2AjSMw54Ql/BtdVjv3Oa
	 4VxN0xacBO0MpWOSbAn9WXyylj3hNHGdVGrB9+BqkVQuvNL3jas0E993vxR2MgILNj
	 fsjG2owl36+pg==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Mar 2026 06:06:24 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Andi Shyti
 <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for
 RTL9607C support
In-Reply-To: <3cfcf811-94f9-4ab4-af5c-d589d696f843@kernel.org>
References: <20260319175753.32338-1-adilov@disroot.org>
 <20260319175753.32338-8-adilov@disroot.org>
 <20260320-serious-noisy-ladybug-bad92b@quoll>
 <c87523f2741687c6037c4b7b54d72dba@disroot.org>
 <3cfcf811-94f9-4ab4-af5c-d589d696f843@kernel.org>
Message-ID: <623240c8b1bf7a9f390c5c0e9de0f8c5@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello
On 2026-03-20 13:11, Krzysztof Kozlowski wrote:
> On 20/03/2026 11:39, Rustam Adilov wrote:
>> On 2026-03-20 09:24, Krzysztof Kozlowski wrote:
>>> On Thu, Mar 19, 2026 at 10:57:52PM +0500, Rustam Adilov wrote:
>>>> Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
>>>> RTL9607C SoC series.
>>>>
>>>> Add a clocks property to the properties since RTL9607C requires it
>>>> along with the realtek,scl. And because RTL9607C is the only one that
>>>
>>> My previous statement:
>>>
>>> "Other devices do not *have* any clock input?"
>>>
>>> And second one:
>>>
>>> "If devices *do not have* clock, you set it as false (see example schema
>>> and even line above!). Clue here is what I wrote "devices" and "do not
>>> have"."
>>>
>>> So why are you using completely different wording "require" with
>>> completely different implications?
>>>
>>> I did not leave any room for interpreation in my statement "If devices
>>> *do not have* clock, you set it as false".
>> 
>> I apologize. I was using "require" merely to relate with "required: - property" notation used in bindings.
>> 
>> Would changing the commit message to something similar in vein to [1] be better?
>> 
>> [1] - https://lore.kernel.org/linux-i2c/20250927101931.71575-9-jelonek.jonas@gmail.com/
> 
> It does not cover clocks and it does not answer whether devices have it
> or not.
> 
> Decide first whether devices have the clock or not. I asked more than
> once last time.

I took some time to read the available docs like [1], [2] and my educated guess is, there has
to be i2c clock/s and it is most likely connected to switch core by lexra bus as the other
peripherals in SoC. I am not from Realtek so i don't know accurate that is.
The difference with RTL9300/RTL9310 and RTL9607 is just, how SCL clock of the i2c master
controller is configurable but that is for driver to deal with.

[1] - https://svanheule.net/switches/rtl93xx
[2] - https://github.com/plappermaul/realtek-doc/tree/main/datasheets

> Then write commit msg and code matching this.
> 
> Best regards,
> Krzysztof

Best,
Rustam
