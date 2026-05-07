Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501736D500
	for <linux-i2c@vger.kernel.org>; Thu,  7 May 2026 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140614; cv=none; b=pbsvRR2EEatIBzNWN4aDcdzX2lR16GHD8+rgARjqgLYHzsX7X/V+24SEHY2SMK790Gejl/DO7emXe+HbIWpDx2eF57LkEYRcx/OyRbcqZoDPJdBaQkTbXX3X+mL4OdPnmrxidVOYB1q/cPtS+mG26tVQ+r3JRU17hiFN9YX6g/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140614; c=relaxed/simple;
	bh=TlR/xsfN/SsPRQlJrt9edJEjZ/kU37wAuFHlT5eEPJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ik+2hqw9uPxB7zL872bBvJ+3s8z7sLRAjEGD1kCQjzdvAMdPT0OCDgSoGYmCka1St9BB8yR8YA+jFqWur+X3JzjZlbdLvyQ2W8+V4S0Rxcl/ZA7FZLUKgkRKzIC5Oe1s12Ft6jhHUfLPPmXsY67uB65pNQNkBTP+UfKb68Luuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=FCdL3ZFP; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="FCdL3ZFP"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso521916eec.0
        for <linux-i2c@vger.kernel.org>; Thu, 07 May 2026 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778140612; x=1778745412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAC2r2pIGYK6BoP8vASKjfj1y1PElzocW+Rdg94M4Ug=;
        b=FCdL3ZFPWlYBtEdMmX3aqfIrvBsYBVicXkNsb/3BK6mBeFN70zrcSWtHVsngsGTpwW
         XMVV8PaNMvmEdbzJm3IAUDlXjNvgg6Ozv8sJvLHFZ0jdrs4tCYqJjmT1RcwTTimedUvo
         9pnDVubkLx/kLDMXpTysUCItcPZZe+003EuoNlyG+xBsVAz4ebAxOEZ04WA4FEblT6N+
         4rR/RI4oFAS52YEt42QIFBbsgQ3yzM9MrHaawTLYhxlvqIBhlZF6YMtO4r1C31fMOQA0
         soC0p1yKmFnYh3543V+2TsPH3bI6Wi1hSLRClrQZwKIcTWPGjak1R0nwNapgfDc0/ipO
         dw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778140612; x=1778745412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAC2r2pIGYK6BoP8vASKjfj1y1PElzocW+Rdg94M4Ug=;
        b=rRGkG7UVBPSDmmRf5gL2Lnjc7b/2q+qTs+s4o8smZ0Wk4iATmo/xFBPoPQoV+Eg5bc
         pPZap6a9ZTsZuIfcKb3ex1IEj1zpf5NRkfFcyXxwh4eZ8PItJKdbbNZUkliiphyydJ2J
         w+HB6P9Fg+lZY2Ku57MfiB0XvIB7YoNqCbb2CkHB/oefJJOat5XP1cLaj4R7eL346PiY
         R4h0kCuykJcBAcTXSP/ym8mgS6QsC164gdDHHOzzbuYP7iQbsZ42ZLQSYJ9pwjJgqice
         4RhX4MqDs/BQ2V+F93CsijN/8G9eiea8jKN2YcQBVuAp2ptRotPAvEZ+5jtBHuJ7Xjjc
         M+3A==
X-Forwarded-Encrypted: i=1; AFNElJ9VGUlZfZuLxZP55JkVDywAsfv25WlFfI2tmPWyMDTVxH76gEJJtveoaj9Li6R+L79C0p647MrVueU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnbHbvikrEM2kCcMLFu6rbS9DpTB4uHRMBiq4VYLdg6P2ZmQU
	8rlAGg7Jrq/chy7NKJogZk1M+2DnFjZKa0/k/8CDJRJ9Xvm2unemXKi5IQOrB6ksE10=
X-Gm-Gg: AeBDieu0L205qwnKModwNxLdh3brmzsbxKPa0/UTaCPOoQxEynCBoPFVXnAd+9jUpLu
	E/7PVab1ykimQ1IrLRmNZBnIs2eK3RPLe/Y92NHAuHlcjEfiLt/TpTaM9KrLKpD27J7Dm8kOlOb
	80ir1VgwZKJ/6iZCm8qyxv5QgiAkWuyIVn6fg8HUJ7cENoiXu4sNb9++RXdUnwderbX7Qa5RL9g
	J9EWqeEWKHqaIlPB5oPXlShNOqostJSZCT0tZ5dir/41YvXE0jCiDe2Mfrxz+c5FiJKxjn/acxA
	eQ7YQ4ZMG0EmwhCmqanEqBo2HF3Jn45/Quq+yhU2JDa73b8NtUNrULak16iTW5+FYLE/vn82Epo
	nI0IL9z7kV6JIUDU/jFGfjS43lzvLgGHlqQ/Vc2W2Qls7u0iXOYhhZK2bAN9FSc3FcquWIBePgw
	r4bNouHwBKOAf5XZPGzWEPFS1bC+BYNpG2HssmXj5wltU1bgZ/9KzjUjji9aexpwr37oyD+7RK4
	mrV7HJqrTK1VRbSd9iN0vVwqA==
X-Received: by 2002:a05:7300:72d1:b0:2ea:ed7c:8064 with SMTP id 5a478bee46e88-2f548895145mr3507115eec.3.1778140611874;
        Thu, 07 May 2026 00:56:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:5ae0:228c:e58:7bff:fe94:34ed? ([2600:1700:5ae0:228c:e58:7bff:fe94:34ed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f57038b096sm6269848eec.27.2026.05.07.00.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 00:56:51 -0700 (PDT)
Message-ID: <471722ab-a6f2-4e21-9b68-ef2050ec4e65@wkennington.com>
Date: Thu, 7 May 2026 00:56:50 -0700
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
Content-Language: en-US
From: "William A. Kennington III" <william@wkennington.com>
In-Reply-To: <afmcdXJt9X0Y3mw3@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/26 00:29, Andy Shevchenko wrote:

> On Mon, May 04, 2026 at 08:15:02PM +0000, William A. Kennington III wrote:
>> Introduce an exported shutdown function to safely shutdown the
>> DesignWare I2C controller.
>>
>> This shutdown hook gracefully sets the slave disable bit before disabling
>> the controller. This guarantees that any incoming requests from the master
>> are immediately NACKed during shutdown, preventing the bus from hanging.
> ...
Is this just language correction?
>
>> +void i2c_dw_shutdown(struct dw_i2c_dev *dev)
>> +{
>> +	unsigned int con;
>> +
>> +	/*
>> +	 * We only need to handle shutdown for slave mode to ensure
>> +	 * we NACK any incoming master requests. Master mode cleanup
>> +	 * is handled after each transfer in i2c_dw_xfer.
> i2c_dw_xfer()
>
>> +	 */
> Since it's a newly added comment, can you switch to use inclusive language?
> Same for the whole series related to the commit messages, comments, and
> documentation.
>
>> +	if (dev->mode != DW_IC_SLAVE)
>> +		return;
>> +
>> +	/*
>> +	 * To quickly NACK the master during shutdown, we set the slave
>> +	 * disable bit while the controller is still enabled.
>> +	 */
>> +	regmap_read(dev->map, DW_IC_CON, &con);
>> +	con |= DW_IC_CON_SLAVE_DISABLE;
>> +	regmap_write(dev->map, DW_IC_CON, con);
>> +
>> +	i2c_dw_disable(dev);
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_dw_shutdown);
> Can we use namespace?

It already does use namespaces with

`#define DEFAULT_SYMBOL_NAMESPACE    "I2C_DW_COMMON"`

I assume I should just keep it consistent as-is?

> ...
>
>>   void __i2c_dw_disable(struct dw_i2c_dev *dev);
>>   void i2c_dw_disable(struct dw_i2c_dev *dev);
>> +void i2c_dw_shutdown(struct dw_i2c_dev *dev);
> Isn't more tighten to the probe/remove than this?
Yes, can move it
>>   extern void i2c_dw_configure_master(struct dw_i2c_dev *dev);
>>   extern int i2c_dw_probe_master(struct dw_i2c_dev *dev);
