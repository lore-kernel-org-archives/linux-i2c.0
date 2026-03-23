Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BEF1DE3DB;
	Mon, 23 Mar 2026 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774246909; cv=none; b=dge0YVLlzVpV9ecPxHuBT1G9OcEDLjU/a2kZmEhONjsWZqBeI1HaNsVpR9cuBHCfqsIzDmyZYU59oCr1E0lWK/bO66/55Zbz6uY/h77hgJKtYtDDUJ/q8INYOIdn/r4PvbxXPHZdd+zdikmE3x2aHtXiFsTLAP+AzM4p4krTC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774246909; c=relaxed/simple;
	bh=+JTCVX5wyxrbWfmcp+HMnvIrjPYnbpe7tDYmKba/uIk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pHQ2cN9upFPWrtx/Butq5MU+HiOjFJ89Uscd+irtwxiF+48SE84xazrrFKEgkxhUHjCm74C40a1aDxlxFBvsoVTHHsI3p3lG7BTFqMD8Jlhzl95lnjjMjpgc9gniaaDaDkaxcYqiEPezJphn6f3AN76t6Qk/MCEH6GSsah191gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lLJFQ5St; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lLJFQ5St"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B4A81264BE;
	Mon, 23 Mar 2026 07:21:44 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AeWVaGRIl8ZZ; Mon, 23 Mar 2026 07:21:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774246904; bh=+JTCVX5wyxrbWfmcp+HMnvIrjPYnbpe7tDYmKba/uIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lLJFQ5StJPVJQXo75XsYG564n5odrwcrdi0f4h2Fs7iXKnq5MxvI546dKZ1SpFiWJ
	 8ZqlX+ZmZHkJvfqUJaIa1k7d706JheMwTRu7Dg1U5IrZXS9s7P9/AOss2UXxvJKGDd
	 RTcS5511nyIoaole8iqhl+a0zDJCXyZ8sGUjJfE0peCn2eu/IFMvZXLrLUgo/rFg+F
	 Et9xIZIURiEgec198FZ05BptcGtg7X8/svWc/YIV/RM6robN7Fcw1jtwHLWX+q2HDa
	 3fW5b4DiNLU+MGXEV3s3MQOYKwxRPXyHjY07KZSW1sFR88JLXYRU9ygyebD7Ls0O0Y
	 ag00nnivyRUiA==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Mar 2026 06:21:39 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Andi Shyti
 <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for
 RTL9607C support
In-Reply-To: <76007bf5-26fa-485c-a07c-6c8c3f437cdf@kernel.org>
References: <20260322123411.32102-1-adilov@disroot.org>
 <20260322123411.32102-8-adilov@disroot.org>
 <76007bf5-26fa-485c-a07c-6c8c3f437cdf@kernel.org>
Message-ID: <3f5a87c7ed40a57cb40bb71e08e66654@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-22 21:02, Krzysztof Kozlowski wrote:
> On 22/03/2026 13:34, Rustam Adilov wrote:
>> Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
>> RTL9607C SoC series.
>> 
>> Add a clocks property to the properties to describe the i2c reference
>> clock and make it available for all the compatibles. This i2c 
>> reference
>> clock is assumed to be coming from switchcore region via Lexra bus as
>> the other SoC peripherals.
>> 
> 
> Why the clock is not required for rtl9607? I did not find explanation 
> of
> such change in the changelog/cover letter.

I have apparently forgotten to include it back after moving 
"realtek,rtl9607-i2c" to another spot.
Will add it back in v4.

> Best regards,
> Krzysztof

Thanks,
Rustam
