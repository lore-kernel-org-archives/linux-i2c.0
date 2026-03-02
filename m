Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370C30DD2A
	for <linux-i2c@vger.kernel.org>; Mon,  2 Mar 2026 05:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428783; cv=none; b=lnoiYwSBHgQpgSSfRCF3gDumKpYVTeorOd3NURRYDdMrZgWpWsgbveunlyR6Hcf8GuM1wJLcxP7vRclefTx/uwyVZ0TmwJoI/oSgQTV/L+E4tAgD4XotMckkIV0hnrqASYESnKRRBqR2Kilhx31vd1fTJemll8fAsoG4haOf3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428783; c=relaxed/simple;
	bh=RMUy/0tXsYsIfw7fszbPW6WQvWoyeuo7bOvaDYvZeRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbcRBzxoOdRHNolyECq93enDGjVs9XTU9YdhZwedi6WWBLuPcjtamXsic+2FXFU5gPxS1PGaEjDuCcY6Xv1qlGKw6Zt2QL8bPt0QKVRjN1KLTHEY08nx61awXe9N0eTIxpU+B5OXlAvRvYTR4mpa1FzVh4uG+yKE7Gzlyqn8hN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdUWMRRP; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdUWMRRP"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2be19f05d7dso85139eec.1
        for <linux-i2c@vger.kernel.org>; Sun, 01 Mar 2026 21:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772428779; x=1773033579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ja3/sa5XTxKU/PVv8hZ7yVRAz9TdsmcdyMSSUtiPU0o=;
        b=SdUWMRRPmgXWVs5/WpnDQkLZIMYJsgvhzYwmsih26RHGk2HBI/AcGqP9/1pM7AfArR
         0f8VEWHksaKMmgd0TvT5wIRoXpvky3KusTBdHDfmb8oZ4N4nHZgevnW/nnslFfieDlNi
         o9AgE7EEweUm0cXMS4EyQv2rQVSAzSu9OStPbVUlNsrbCT+X7PCL5YwNiS4LZIlJqAPy
         l6zfIARd1lMVJJJrtrDxhcAyCHhvB2/N8up6rb7gv77lWeuSv3PoZWsSx81GLkspgUWi
         36gMz9z9IDyeHg2iJtfHuBeGbKNIxclQ5Y3pj0RRr8fNWZXoy6kIzFFhkqC7BxuCDhRb
         l+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772428779; x=1773033579;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ja3/sa5XTxKU/PVv8hZ7yVRAz9TdsmcdyMSSUtiPU0o=;
        b=wi2/6eijtjub4r2EhDDvrFef/W84bVPttmHFMXwM9NXi6UE1UGoB4nOJzktmB4trfD
         SO3iBCxfmeqaOCyMCyfGoFLIlLUJMeAsUsCtdqY1ocpiQBeYB4JZ4EMdTHZMsuKd/3gZ
         g0l9Sien9ur+Ly1lUreplKgw105fkigKNkHvfPIi/wMVwIk77sesW0jMSxGhAzxbQqUS
         tjMAjFuz/ur+NTcr+e7pWEelmbjm9WzBP9RjFDLXv+cfyAk/vGCOwzOAHRcwtBDMu7is
         PmBEgHBNAL2SZpkPMWZGl7C8QAo5UNqN/zzjIVl8JRn4IuwLwWAKEH0ZkB1KsmN7edDy
         ecVw==
X-Forwarded-Encrypted: i=1; AJvYcCWqUt0Flgh5p5XI31GSIZiM80uRhMyXmFPmbMsKuFAIMkTdN5f39bWhJTZf7PIGGXcF8LfWWrtd1Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy570Q7RyjM+/JBahWciTjYUu4n5XGoMz1lscrC1jGfaF/sygfu
	slqMjk9n0aIroWzSBdNWiqXUrABOAbynn8ArORElQnSvylbO6N4Vs/1/
X-Gm-Gg: ATEYQzxt7r/YKEZjuq/IIKWKDdmG95GZqTr44bh1ZznnKCgnyaVYSXZcbl1ebBSk3q8
	3kZ0IPxx593T0iVUTioEXpKvpY+3ETwdlKK5oH6H7sLuVyhW/Nm23h+nyJ5eixJDBWC2BaETUQQ
	Zg6t4U9WlvX+aME3fSZqfE63kfKTVBfo1DMsBdvcsYCuxxK5wlJuFTpkeVFiLcbSgfHZRkzbIp7
	54nW3tN6zdUzC+FMQ/skNv2NXr8q3oZYHRk1/HNH/3UASTUDn5uV4ZQ3vsAlJWDJpsPBFegMYHR
	jCPpJ1Q58nRFtXaR8B5DTLBnw+Ll/nkZBfBc3VnPT48isSvQPlG3s1Y5RFqvtwO8fyUOABGT37g
	+ckgI3wM5sKwsE69d3nKKEixkm6yN7EEwrweH9lXbmMhy7WkY5fe7L6LBHOAyNiiMM8r8OCr5GS
	kOXHB8cZJkIkOElVNjtOWaCuIbYiwyI4j9hCn/hK7ETLPw5zkop1xLwYGEjzcLVoRCkgwT/AIp
X-Received: by 2002:a05:7300:538e:b0:2b7:f145:a94 with SMTP id 5a478bee46e88-2bde1d32dc2mr4733312eec.30.1772428779327;
        Sun, 01 Mar 2026 21:19:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be0c63482csm2765847eec.4.2026.03.01.21.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 21:19:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <09bc2e1c-53bf-4af1-a26b-5a707d1b8271@roeck-us.net>
Date: Sun, 1 Mar 2026 21:19:37 -0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PMBus memory overflow
To: Kees Cook <kees@kernel.org>, Matt Corallo <yalbrymrb@mattcorallo.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-hwmon@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>,
 security@kernel.org
References: <bc9a14b5-8b10-436f-a791-28df245465e6@mattcorallo.com>
 <4e198aa1-527b-4ad8-abc5-e7408296bfbd@roeck-us.net>
 <03da7997-74f4-4435-a6c5-6aa5aea2f6d7@mattcorallo.com>
 <2025060749-attendant-trout-d2c8@gregkh>
 <695ebdae-7292-4a83-8aff-763da184921e@mattcorallo.com>
 <2025060848-reset-recovery-f67a@gregkh>
 <d16cb075-f924-4bd4-adec-8eaba589a3f2@mattcorallo.com>
 <a149cb52-925a-4365-8529-081e7e0a7b81@mattcorallo.com>
 <87767DC8-784D-4B9D-A2F2-0BB10EC4A96A@kernel.org>
 <e1eaab50-3a21-4aee-9224-6a1bbf8cfa6e@mattcorallo.com>
 <202603012052.AE51FCB9@keescook>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <202603012052.AE51FCB9@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/1/26 21:09, Kees Cook wrote:
> On Sun, Mar 01, 2026 at 12:10:08PM -0500, Matt Corallo wrote:
>>
>>
>> On 3/1/26 11:12 AM, Kees Cook wrote:
>>>
>>>
>>> On March 1, 2026 5:46:33 AM PST, Matt Corallo <yalbrymrb@mattcorallo.com> wrote:
>>>>
>>>>
>>>> On 6/9/25 9:57 AM, Matt Corallo wrote:
>>>>>
>>>>>
>>>>> On 6/8/25 3:14 AM, Greg KH wrote:
>>>>>> Have a pointer to that patch on lore for the maintainers involved to
>>>>>> review?  Note, we are in the middle of the merge window, so no new
>>>>>> changes can be added to our trees until -rc1 is out.
>>>>>
>>>>> A proposed patch was posted by Guenter, and tested and confirmed that it fixes the issue by myself, at https://lore.kernel.org/linux-hwmon/284466fd-39e8-419e-8af5-41dbabb788af@roeck-us.net/ . Wolfram suggested this patch was acceptable at https://lore.kernel.org/linux-hwmon/aAtEydwUfVcE0XeA@shikoro/ but that's the last he chimed in on this issue.
>>>>
>>>> Any update on getting this patch applied Wolfram? Looks like the buffer overflow is still present on at least 6.18.
>>>
>>> Looking at the code, I think probably the best place to check would be in i2c_smbus_read_block_data() when it does a I2C_SMBUS_BLOCK_DATA cmd, since the callers are all already checking the returned status.
>>
>> I believe that's what the above patch does?
> 
> Sorry, I mis-pasted. I meant within i2c_smbus_xfer (rather than
> i2c_smbus_read_block_data). Like:
> 
> 
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 71eb1ef56f0c..fbca606ba35a 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -547,6 +547,10 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>   			       command, protocol, data);
>   	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
>   
> +	if (WARN_ON_ONCE(res == 0 && command == I2C_SMBUS_BLOCK_DATA &&
> +			 data->block[0] > I2C_SMBUS_BLOCK_MAX))
> +		res = -E2BIG;
> +
>   	return res;
>   }
>   EXPORT_SYMBOL(i2c_smbus_xfer);
> 

Agreed, that makes more sense since it covers all callers, not just
i2c_smbus_read_block_data().

Guenter

