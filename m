Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192E321A42D;
	Tue, 21 Jul 2026 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618205; cv=none; b=ufoRjgoEG3xTAnlR+kaS1JtpOD4s0yrAed6ORehUPmSsaTgW3iI1Nu+EWGfrUmri2FsJ60g0nd3VsTmk/Hl7vIXzviw1VK/KXamTVQpgU6P0Mrefu0p70UnRMow8ei7mBjm0NGYMV0VAUNBcJHgabvKuISkLcNM5HI8jQexOzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618205; c=relaxed/simple;
	bh=b/f9k1gyyGbDesTqVKEoUQFUylCeG/zfo9Lqg4ZEU84=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sDZNzW/I1awpjHMlpUwouvTtmzntLKbaF3g9WGms3wbbcLStgiAoFfRlVjZFw+2ePJ3ysF23yudWDAlqG2DCISe13ZusGNuSvKV6B/rqUOHmcxAEaPZhfiKJn5alLHfr5MtthyiczCNamLdsOqnQPemzxy6apniWn4gNvLQmDbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPU4H0xQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPU4H0xQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA4D1F000E9;
	Tue, 21 Jul 2026 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618203;
	bh=69FmJzHLdzbbdDaGF4UnDrcHcMG925omC873SGxELgE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=lPU4H0xQXXtjh/q8txAXIJgobtqwCw8pK4UVSYrJDKJTW7DAyCyYdL8PRPlQbCVg0
	 DPV836sIYf4Xhv7yNZuHnJruNcTNQ3WgMCcrSBg12Iv9GWfRcPbx7+SWG3LpCkxfwb
	 4bDGdfPQ7B5mejPBhAx4ZkzVyghAw5lhs2GXORupno7CYjEqH/PXM4O7ms4s2N31z0
	 Qp/ztsoO29F7qcvd3kiaD9cZNCjstbANxEqU80GwvmQJL1enLteKjMWBpqwUjaH04G
	 Dff3GivH7JG/XtXa1bdB7zn3ksiBbPoCehjw34GH1p7Cqa3clglmgsRc4/1at5ZhPX
	 bvQempuZmfcEw==
Message-ID: <65492810-a5ae-4686-b7e9-2cd43afd47df@kernel.org>
Date: Tue, 21 Jul 2026 09:16:37 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] MAINTAINERS: Add entry for Novatek NT726xx SoC I2C
 controller driver
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nina_Kuo@novatek.com.tw
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ben_huang@novatek.com.tw,
 toby_chui@novatek.com.tw, shihpei_hsu@novatek.com.tw
References: <20260715073443.147490-1-Nina_Kuo@novatek.com.tw>
 <20260715073503.147552-1-Nina_Kuo@novatek.com.tw>
 <20260721-comical-dragon-of-competition-f1b6da@quoll>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260721-comical-dragon-of-competition-f1b6da@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2026 09:11, Krzysztof Kozlowski wrote:
> On Wed, Jul 15, 2026 at 03:35:03PM +0800, Nina_Kuo@novatek.com.tw wrote:
>> From: Ben Huang <Ben_Huang@novatek.com.tw>
>>
>> Add entry for maintenance of Novatek NT726xx SoC I2C controller driver.
>>
>> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
>> Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
>> ---
>>  MAINTAINERS | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 806bd2d80d15..15df47f9e81f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19234,6 +19234,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
>>  F:	tools/include/nolibc/
>>  F:	tools/testing/selftests/nolibc/
>>  
>> +NOVATEK NT726XX I2C CONTROLLER DRIVER
>> +M:	Ben Huang <ben_huang@novatek.com.tw>
>> +L:	linux-i2c@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
> 
> There is no such file.
> 
>> +F:	drivers/i2c/busses/i2c-nt726xx.c
> 
> Neither this one.
> 
> Apply this patch (important: this patch!) and check yourself.

And I already told you that here:

https://lore.kernel.org/lkml/20260604060411.355675-1-SP_ISW1_AT@novatek.com.tw/T/#m1589bef5c6da621ba79f46fc87c0d39844f17534

which you just ignored.

Please respond - how did you fix that issue? If you keep ignoring
comments, why shall we keep reviewing this patch?

Best regards,
Krzysztof
