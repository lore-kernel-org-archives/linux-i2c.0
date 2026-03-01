Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE07236437
	for <linux-i2c@vger.kernel.org>; Sun,  1 Mar 2026 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772396267; cv=none; b=otvI8DW63cCAjwi+rAgBckV78H7uvn8FvQeTh60Mg+f3+X0hyevZFjue9DartXJKR4cLbQ0YQTBJ/xyPpaps17RqqE+LN5d9YX0e/30ovY/5QvdQzLM6hD6edcLPuFKlQtkODYwwBIgYiKQXrCLWQ4sTmK0L3u0YhZNyGjOuIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772396267; c=relaxed/simple;
	bh=2EJV1heyXGYyCRbbPt15J5PkDaiXV2MX3OCZT9DDtq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5kAy17YCLL9QvIhmkEj+8/28iinTTpioVAYAaCtmUcDNjxUHeuoA7Jk2Dz8PEw7wnbKq+2ygn1kCbuCb3WTvbaqYYo0/zvSgQrxBPb8h7FvwAG1Y8sMzb5srrOLJeKWbqH3YT02VPluG+Gn4hupVrAPHtbomoHdxxv6tjyYVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OM0/0+C9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OM0/0+C9"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35984cd0335so206534a91.0
        for <linux-i2c@vger.kernel.org>; Sun, 01 Mar 2026 12:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772396265; x=1773001065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4ozmx6Ip3e2l/TKlIxRVYZzE0ge3/onETLnKh186ItU=;
        b=OM0/0+C9joGArQVz5ZgrLSErkqW7zKmBpDDEnRVF5DYCGQclQwZcwpftKX0mWNPKGK
         x8kJFrD8euSGbUZCSOy8a/KfhKKYT8guUHsDxXY0LtZBWOgJVtKpYPZH4Fw6Xd0bliWb
         XS9cmXoqkxMrRGi7wZ/H7/txvVDoQHBb8cW1kdmkUOdYMuxX230HG6DDG/0rVe3vumRF
         Aymth0LrzVAeesle9FrQuI+QmYr+cYfIbtVCdIuK3Akd+Ohp8oitxs6XfP3arSdpBVUf
         tZVwQ6n1tZ8Q++MC/h/3kLCLOgnOrKAfqSZxD+XI229RrSdLL8Pgyak/3pErCFx3qJT/
         coug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772396265; x=1773001065;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ozmx6Ip3e2l/TKlIxRVYZzE0ge3/onETLnKh186ItU=;
        b=oU+dSkvElpwzyvqz9UJYfHFduqSo9WlJpsG0f2wVin+hD1B5KYpyPoRpcr6fd1bAlv
         zoPn+KFERrizwxqu2J05IguW8yRwYlJFtlYyZcvSgwjATI1I8abxAVH63mVN0VpeFDe9
         Sj7nQzPNC5GJRbTBUEPrEt4J+vDPyWXsPg/gbkMFRC1MThzpSNsgGGd2EeL8EL6GOitf
         BUFZBd39CkNxO5YbE9itiVaaaY70vgJIhQGDEV64CDP8wEqsvHoru05pt/umJiooRaME
         k6P6dvoFq/O8zJTLflUaC5VTWqOKoxoC1kzqsBW3/MNhoZddvBujrYWSoRhuBmdeUnyu
         JTCg==
X-Forwarded-Encrypted: i=1; AJvYcCUXsdk34Fdu7tXFNaVHmQsa/r0PTu2i9SSf+KjLw4ZxxdnEV113vrQPE/+tMuSlUUsxxqfZQMVnwBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx78hOoONA7RPHhYAN4NWTFk66Jn8QLgfyhTcloz31LkcuR/xKC
	C0wJICls+QlA6oAz1i/HtisNZRxFUWNJiERqXkBgWYtQ0yOXExvb3x1G
X-Gm-Gg: ATEYQzxMOHYFgx1x5bDPOJed62iysbbSyXY+6CLu68idaCOhNNCFBHUW41Q3ygYD54C
	FtgSu8xFKb6dBxp56A+2h6UUMjitg6TUY7jZKL9+YkwH3KKrpyog2/AaiFsEIrBHzoC7JaZq81X
	Uz8/lL4rs4akzHPUp5CxdYfYIH86W6Mtrg3Vz1jtDC+M0zM5gAEJDN0xc71DHk/+vGd5sBK+a4E
	Y9RTQBSKpJRUcodZe7uDw8/9UEtuj3DtgQpuA0iRFskfd3LQiJX0YzQQsAiPTpRRQe4OwugoXjm
	x6tXdM8iiUyMYnxT8I4KX8tFeVW6aSV4RiRVogHx6PBtuvMDLkvQ4O+W9MPkpTXz2UhcM9HFS65
	ojPVeLRA3zNhbRKzonVsiAogFpnK14St6+4mrtlpPd2NPt/Y2k6jErf93BXKc/4Xjfgk0wmCY/U
	B+0e5IqSxv+CQVlow+20km28SqwJ1kYK5pkGlv+j4fiN/7SIdw2FYfy/N3VtJAggRMoKERipMg
X-Received: by 2002:a17:90b:2587:b0:356:256c:4bf0 with SMTP id 98e67ed59e1d1-359690409b0mr9543755a91.17.1772396265185;
        Sun, 01 Mar 2026 12:17:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3598d0b793bsm1036109a91.4.2026.03.01.12.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 12:17:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <209dcf13-858a-4241-b9c1-cd9a33186bfe@roeck-us.net>
Date: Sun, 1 Mar 2026 12:17:42 -0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PMBus memory overflow
To: Matt Corallo <yalbrymrb@mattcorallo.com>, Kees Cook <kees@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-hwmon@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>,
 security@kernel.org
References: <d5abeb59-8286-425c-9f78-cd60b0e26ada@mattcorallo.com>
 <00baca6f-8046-46ae-a68c-525472562be7@roeck-us.net>
 <aAtEydwUfVcE0XeA@shikoro>
 <3a9ab7bf-6761-4a14-983e-e6bb288ce58a@mattcorallo.com>
 <e0e789b3-24c2-4ea3-9c79-fa815d801d83@roeck-us.net>
 <bc9a14b5-8b10-436f-a791-28df245465e6@mattcorallo.com>
 <4e198aa1-527b-4ad8-abc5-e7408296bfbd@roeck-us.net>
 <03da7997-74f4-4435-a6c5-6aa5aea2f6d7@mattcorallo.com>
 <2025060749-attendant-trout-d2c8@gregkh>
 <695ebdae-7292-4a83-8aff-763da184921e@mattcorallo.com>
 <2025060848-reset-recovery-f67a@gregkh>
 <d16cb075-f924-4bd4-adec-8eaba589a3f2@mattcorallo.com>
 <a149cb52-925a-4365-8529-081e7e0a7b81@mattcorallo.com>
 <87767DC8-784D-4B9D-A2F2-0BB10EC4A96A@kernel.org>
 <e1eaab50-3a21-4aee-9224-6a1bbf8cfa6e@mattcorallo.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <e1eaab50-3a21-4aee-9224-6a1bbf8cfa6e@mattcorallo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/1/26 09:10, Matt Corallo wrote:
> 
> 
> On 3/1/26 11:12 AM, Kees Cook wrote:
>>
>>
>> On March 1, 2026 5:46:33 AM PST, Matt Corallo <yalbrymrb@mattcorallo.com> wrote:
>>>
>>>
>>> On 6/9/25 9:57 AM, Matt Corallo wrote:
>>>>
>>>>
>>>> On 6/8/25 3:14 AM, Greg KH wrote:
>>>>> Have a pointer to that patch on lore for the maintainers involved to
>>>>> review?  Note, we are in the middle of the merge window, so no new
>>>>> changes can be added to our trees until -rc1 is out.
>>>>
>>>> A proposed patch was posted by Guenter, and tested and confirmed that it fixes the issue by myself, at https://lore.kernel.org/linux-hwmon/284466fd-39e8-419e-8af5-41dbabb788af@roeck-us.net/ . Wolfram suggested this patch was acceptable at https://lore.kernel.org/linux-hwmon/aAtEydwUfVcE0XeA@shikoro/ but that's the last he chimed in on this issue.
>>>
>>> Any update on getting this patch applied Wolfram? Looks like the buffer overflow is still present on at least 6.18.
>>
>> Looking at the code, I think probably the best place to check would be in i2c_smbus_read_block_data() when it does a I2C_SMBUS_BLOCK_DATA cmd, since the callers are all already checking the returned status.
> 
> I believe that's what the above patch does?
> 

That wasn't a formal patch. I thought you had volunteered to submit one,
but my memory may defeat me and I may be wrong.

Guenter

