Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70E426D05;
	Wed,  1 Apr 2026 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052581; cv=none; b=d+frCyBTIE6md/cElHGEH7l/88a7YiNPDUgvKKI2kk4lfhPPl4X2t+btsSxgS0AAwxCzdPmtT5Upcez0/0X3j5/vgYx/q3EvheuDxPtk1WVYeirw/VsxegJJ9bKAhqQ+WCiqFsS0eCvKILya54m2bDJDNkD3b12oEpc6N+w9rT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052581; c=relaxed/simple;
	bh=47tRIZNI9xSR1J9LQxup3Dqu0F5P36sAvy+kn9+1MSE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B4q8MN6iaFMDr8rOzv5pZI10AcUVItIbi9gcpliKY2TyShb4VXfpkyoVPixU6P10Zs0oj7jclsLyl/6JJM2y3trSdrB04zNIl8+kJ9RUDYdAjDcNYF+kBC8IlTxVOtXJNXyH2SbhWgVZUrypBk1qEiN0m+MkPOldIivs+sOTs1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=M5NwA0wv; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="M5NwA0wv"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D22AD26476;
	Wed,  1 Apr 2026 16:09:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NF_4uX9QEzl9; Wed,  1 Apr 2026 16:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775052576; bh=47tRIZNI9xSR1J9LQxup3Dqu0F5P36sAvy+kn9+1MSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M5NwA0wvai1iNFa9U/dwK8coQmdrAjpyDupLIIj5kkIkTl3zPRoYegtLSeFKGEDKf
	 5MeIFbD9I/ub22qyvtWEQslt8igP8gT+jlFUj2P2RwvhV++J6HTzKAMoHno3f9XlW6
	 WRT+3s0oB4W1JfXgHKYlHmkb39Oldr4dhFIdafL9nRzB2JvLpu+MaVMGlwTz8a2Kr8
	 Qv4t/mFCNft8/Uzw6m/HgucbS9KO2K5dNvT6sJFL2zDTYrOEWE/KDtjKgQC+t0Kbaf
	 QPFOzQUiA7me3cSbeU9SLSJXuMbjGW3rHANtFr0eO6sVemB3NPmm7x+SJ4d/IYQkEH
	 eu5SI7kYGMvpQ==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Apr 2026 14:09:35 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] i2c: rtl9300: support for RTL9607C I2C controller
In-Reply-To: <acxMeyVpRh9nts3d@zenone.zhora.eu>
References: <20260326152656.14030-1-adilov@disroot.org>
 <acxMeyVpRh9nts3d@zenone.zhora.eu>
Message-ID: <049adbc3ec3b15229684bf26c167f1a3@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello Andi,
On 2026-03-31 22:38, Andi Shyti wrote:
> Hi Rustam,
> 
>> Rustam Adilov (8):
>>   i2c: rtl9300: split data_reg into read and write reg
>>   i2c: rtl9300: introduce max length property to driver data
>>   i2c: rtl9300: introduce F_BUSY to the reg_fields struct
>>   i2c: rtl9300: introduce a property for 8 bit width reg address
>>   dt-bindings: i2c: realtek,rtl9301-i2c: extend for clocks and 
>> RTL9607C
>>     support
>>   i2c: rtl9300: introduce clk struct for upcoming rtl9607 support
>>   i2c: rtl9300: intoduce new function properties to driver data
> 
> Patch 7 does not apply (not even in i2c-host-next, next,
> mainline). Which branch are you on? Can you please
> rebase on top of i2c/i2c-host, please?
> 
> Thanks,
> Andi
> 
>>   i2c: rtl9300: add RTL9607C i2c controller support

As per the request of Chris Packham [1] this whole patch sets depends on 
[2] to be applied
first before my patches.
I don't know if you have seen it yet cause Jan Kantert didn't include 
you in the emails to
the send the patch to.

Although, i just now have noticed patch 7 has a typo in its commit 
subject which i have to fix.

[1] - 
https://lore.kernel.org/linux-i2c/c933a245-2b35-41a5-9eee-cb655c8231ae@alliedtelesis.co.nz/
[2] - 
https://lore.kernel.org/all/20260227111134.2163701-1-jan-kernel@kantert.net/

Best,
Rustam
