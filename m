Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC70397E60;
	Fri, 20 Mar 2026 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003197; cv=none; b=PRVAYOT1SVNUp5ESgY/Bu0EXbMqw0BgkDvvpLZCpuEca24x4VqlucVY2a7qp5DsphPFw+q+6oERRRmgzN7KaSisNM98W5Hg9cIKEJB6SH1303kQ/n2lPFaptZA6Z3mCbeW8wqrsICT97eZ9miVR5DA1aRcJOxrk9QaDiN3AtHiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003197; c=relaxed/simple;
	bh=9UjKnNAiRqX0JE+ovhbmtOuqnjciyuKJkmLSDYsYXv4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Rfyor96xqlql7zQwCMECcsP4QeJnjfipbDq807PsGVK71Y2qv/R96t8UDJmTwrMCEYtWH7NRLqqakiaqWUlfOkpQGbIUcUXwc1O43HOLq6xyHpSmO/i0PBgCOJR+gelOI5P6JCe5rS/1pO0qax/Kz/6b3jBpnV1q/ZktYfLztEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XOfLBlx3; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XOfLBlx3"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E23E7270E2;
	Fri, 20 Mar 2026 11:39:49 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWAMZGt5LJ_f; Fri, 20 Mar 2026 11:39:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774003188; bh=9UjKnNAiRqX0JE+ovhbmtOuqnjciyuKJkmLSDYsYXv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XOfLBlx3I80IRkH5w3FvXvhhHiIFdfTOO2+1iUGLKinYlt5fGb5/trqEkA6EjdGDB
	 Y/5NQiz/jM6bIOunlPb6gwCVW7tPChiTQoFVSAby5Pu75iBNEMJzM8wJWGoHlqdmpV
	 DmUQiHSENJJlYYe0fgVoeOoYdoVswEzfKueVS6OHIBEMQfU6K8V537OT/iWEz/TmwC
	 s+n5+0jCConVx4Cx8vdf3BFuAn+r+CJDcZu1dJSKMRq79wzGTtiv8H5iv2p3zGzI3f
	 GLlKZ0WMlz1VSEj4dKqrZWsSTI2nQJapWIWRvhetn7ZXFf3fBKSg99x96ToOm8dQF5
	 wqyA8TJqSFNtw==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Mar 2026 10:39:48 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Andi Shyti
 <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for
 RTL9607C support
In-Reply-To: <20260320-serious-noisy-ladybug-bad92b@quoll>
References: <20260319175753.32338-1-adilov@disroot.org>
 <20260319175753.32338-8-adilov@disroot.org>
 <20260320-serious-noisy-ladybug-bad92b@quoll>
Message-ID: <c87523f2741687c6037c4b7b54d72dba@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2026-03-20 09:24, Krzysztof Kozlowski wrote:
> On Thu, Mar 19, 2026 at 10:57:52PM +0500, Rustam Adilov wrote:
>> Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
>> RTL9607C SoC series.
>> 
>> Add a clocks property to the properties since RTL9607C requires it
>> along with the realtek,scl. And because RTL9607C is the only one that
> 
> My previous statement:
> 
> "Other devices do not *have* any clock input?"
> 
> And second one:
> 
> "If devices *do not have* clock, you set it as false (see example schema
> and even line above!). Clue here is what I wrote "devices" and "do not
> have"."
> 
> So why are you using completely different wording "require" with
> completely different implications?
> 
> I did not leave any room for interpreation in my statement "If devices
> *do not have* clock, you set it as false".

I apologize. I was using "require" merely to relate with "required: - property" notation used in bindings.

Would changing the commit message to something similar in vein to [1] be better?

[1] - https://lore.kernel.org/linux-i2c/20250927101931.71575-9-jelonek.jonas@gmail.com/

As for the yaml, my only other interpretation (looking at how others have done it, like fsl,enetc.yaml)

if:
  not:
   properties:
     compatible:
      contains:
        enum:
         - realtek,rtl9607-i2c
  then:
    properties:
      clocks: false

if it is *not* rtl9607-i2c (device that has clocks) then clocks is set to false.
Unless the check should be "if: not: required: clocks then: clocks: false" (like in samsung,s5c73m3.yaml)? 
Or is the current configuration (which i got from reading the example-schema.yaml and arm,smmu.yaml)
with "else" fine?

It also doesn't help that i didn't get a response to my question in the previous email towards you in
the v1 patch series but i keep trying my best nonetheless to understand what is needed.

Best,
Rustam
