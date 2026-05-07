Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2590626B74A
	for <linux-i2c@vger.kernel.org>; Thu,  7 May 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179724; cv=none; b=p7XOhd1avK952PS6k6V9TSADhSMeoGhhMgNxx9hUhFIa31D0B6/F2DBNy2yeBPXBwVknlSpWR1D5T+dQN2ccoXNfRR327hydEAoDfMGWQRIx8kUnzzQkkSvETQsWutQ0YvmU4/5bkDKK9y20SEF6ZnYH11jfnZbMJhbAGHhPZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179724; c=relaxed/simple;
	bh=vZRPUsJ8H6vPFrsZBGhZkIvVdskHA7hsrcgXl7eDv5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB5Z7fH9H7eB6oj/mEVp6JPHW8B1A/QCuaOJHv6pUqKhBmtj7SB96E3IiCBgQuHDs3qK0nXh33GsLmdrtP7VmTC/qIwkJB9gNw4xcC4N2fDcY71wd3OfyhV1Ek0HKNUXsrSYqaMQerIv6tZl5Hm8wkGp5/pz1Z4WgDMvAGzkh7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=dZb7x0Nw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="dZb7x0Nw"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-835399c11e0so543173b3a.0
        for <linux-i2c@vger.kernel.org>; Thu, 07 May 2026 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778179719; x=1778784519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwVr3VDk6+ellI1CrTIIDHY0uhTZTZ3stNMtbHD4e4w=;
        b=dZb7x0NwBmKnV9JkbbLbfeFrwGIbssiaXv7tMYcvxKNvhjMpwHfIceJm0601PC24DQ
         y/+RZ9690kcGSdkKja2zmWyXRpdws0Su18sSJkL8QSxQkJ4JAgyHR165lHOuDiP5wU3Q
         izmpz7E3mnJc5Ynr6+N9lerf84KSbmQKdPHVvS/4YIv6HL5lKYWM20VyEd2vzmmJGBnP
         aOZb8QfkChit5youduE854Yeo4vAXWfadE02UeK0MfJ28OfQhlfxHd5+PyPYq0ewH4va
         1BldAWjWI7IOv7TGBQWLo3YtAWRcD1WAKDF8AxUyclFBlsKHXhnL7GMEZx9CPQKn8wKX
         5DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179719; x=1778784519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwVr3VDk6+ellI1CrTIIDHY0uhTZTZ3stNMtbHD4e4w=;
        b=YSRbXXCn7aeJI8Tozo75pomGCLF62vEyCv2NMCvfu9S5uHyyssYBgQSWOGSxQL2bIJ
         DI7JaEJFEnRJnzN1nywCcIFDhNu9DTMcjOawo+YPxQ8ecEFslVpkRfuJkoqOFHI8s5OH
         wT9pvrYpFmUIXyfiGgL7+oQyYj5/UKfidy7Esodo8yQW081i5r9N2xt8D9mtjFC5z1kz
         GHkfS1OHFMICcLRHGfasgn05B71623of2OduM/NB2PP9xHTr7jpirZqBROjHwdICNX3a
         1vCw4/bo8wmy89JPYCU2eu/2IsKhsxOKqe85CuWUV9giymrxMwrAePtjJSy9CjMiPNUP
         Y5Dw==
X-Forwarded-Encrypted: i=1; AFNElJ8X7Da3VLs/HfEBsGh2d1JrDi+smkHNUOOptHyLfWfIfnKplujQ+woD7tHsnZBhGznLzHciVoALQwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSayGluPDoAIfz+F/9+YnFz767pz8wIVRRFNzgMZhODiL7K7j
	sgKDo+24FCHIw05NaNqii0bu4RaLgRhtr/Y6pCkp9edGac1VzjuqmVJKTtg4Jpx9SHg=
X-Gm-Gg: AeBDievmfr8e5eUZKusy+lIwtvmxghIgDXjdYfMtrwwTwF6zl3wCaRXcRF+jDyB2UsH
	91n/u/Cz/9l5QoxoLn+Os29bA6f1xu0S+6BgwFgVZYE6ZeF3kFDo2LmXa2aeK0QcMPgA4zg4A1z
	wS4v2aRuLFfQIg/cb+u8N2aTgfnXZMwj9nIknO9d8ahgffoXNoUtOf7X8cx8AtrlmVJnkuCHIhm
	N7U38prrFkJd1l+GHp8kc5Qtrfa/ATDTGbqBdoOboP0PJyGh9SRJjNfCwA26X7zZTBO16jA6Nyt
	WP/BsAleqaP9CQMIL7atWgfctPyFFc5xy/zSwRNUN5QYHhGYco0glAWjZ0avUzfA6kx09mbAJTS
	RzAH4NRvFrLOUz/wONFeBFYwGXZBHs71hc+D4Dby4DL6BJ8W0NchdgNe2BlJohXfVuYN4dIqD22
	OL4k9s2NH26YK+oBfk54kl0QYljJEd99PZch5VeMz4nqaDibKic/NKParu2FQGgU/xN+txWRLys
	gTHNSaQjxOB1GkbvyA3GPCb9wiIWXYubtwoY4P5A19UcWo6zMsL38LDpBov3I6R
X-Received: by 2002:a05:6a00:ad09:b0:82d:62ed:b01d with SMTP id d2e1a72fcca58-83a5e344711mr9203824b3a.45.1778179719422;
        Thu, 07 May 2026 11:48:39 -0700 (PDT)
Received: from ?IPV6:2a00:79e1:2e00:d201:e58:7bff:fe94:34ed? ([2a00:79e1:2e00:d201:e58:7bff:fe94:34ed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf16sm11292951b3a.40.2026.05.07.11.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 11:48:38 -0700 (PDT)
Message-ID: <b69efe0a-0760-4391-bc31-7a3ba2f297a6@wkennington.com>
Date: Thu, 7 May 2026 11:48:38 -0700
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] i2c: designware: Introduce shutdown exported
 function
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
 <20260504-dw-i2c-v3-1-57e56135d602@wkennington.com>
 <afmcdXJt9X0Y3mw3@ashevche-desk.local>
 <471722ab-a6f2-4e21-9b68-ef2050ec4e65@wkennington.com>
 <afxjpG8Gvh7FyC5z@ashevche-desk.local>
Content-Language: en-US
From: "William A. Kennington III" <william@wkennington.com>
In-Reply-To: <afxjpG8Gvh7FyC5z@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/7/26 03:04, Andy Shevchenko wrote:
> On Thu, May 07, 2026 at 12:56:50AM -0700, William A. Kennington III wrote:
>> On 5/5/26 00:29, Andy Shevchenko wrote:
>>> On Mon, May 04, 2026 at 08:15:02PM +0000, William A. Kennington III wrote:
>>>> Introduce an exported shutdown function to safely shutdown the
>>>> DesignWare I2C controller.
>>>>
>>>> This shutdown hook gracefully sets the slave disable bit before disabling
>>>> the controller. This guarantees that any incoming requests from the master
>>>> are immediately NACKed during shutdown, preventing the bus from hanging.
> ...
>
>> Is this just language correction?
> I have asked for replacing 'slave'/'master' terminology to a new,
> inclusive one.
Yeah, this is exactly what I figured I just wanted to make sure I didn't 
misunderstand. I updated all of those cases in all the patches.
> ...
>
>
>>>> +	/*
>>>> +	 * We only need to handle shutdown for slave mode to ensure
>>>> +	 * we NACK any incoming master requests. Master mode cleanup
>>>> +	 * is handled after each transfer in i2c_dw_xfer.
>>> i2c_dw_xfer()
>>>
>>>> +	 */
>>> Since it's a newly added comment, can you switch to use inclusive language?
>>> Same for the whole series related to the commit messages, comments, and
>>> documentation.
> Same here and...
>
>>>> +	/*
>>>> +	 * To quickly NACK the master during shutdown, we set the slave
>>>> +	 * disable bit while the controller is still enabled.
>>>> +	 */
> ...here.
>
> ...
>
>>>> +EXPORT_SYMBOL_GPL(i2c_dw_shutdown);
>>> Can we use namespace?
>> It already does use namespaces with
>>
>> `#define DEFAULT_SYMBOL_NAMESPACE    "I2C_DW_COMMON"`
>>
>> I assume I should just keep it consistent as-is?
> Yep, thanks for pointing that out!
>
