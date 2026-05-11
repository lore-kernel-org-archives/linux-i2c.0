Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4769F2EBBA4
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529334; cv=none; b=PJhegyvZ1R/vh0F5P8DKBFOTD9TBVDPjYnknY8ZqSuYNJq1jVsXBbctX9QHJ63v9MuRjCsloq0NUhl18MYJn8mf/ttkbNjDx2PUixKSbUY1mdVokeolR3BSwCrqxzwY1ScEkx/PBnp/aKOry8Y6UuCGFRxq8kGJR+r+ylAVCl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529334; c=relaxed/simple;
	bh=fiPoQJ6ZGykxbkppSOWVJ/TTkvTkXOrbU+mE3D5zkkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmKa7b9Yfw66DJViodnr5QFjkZFPYNvahgDm3GFzt4LEaN8/g+ECt0r/BElS5TlP06wZfQHbsh3uHeQTYc969kHUH2Bx0SYM0Rwr+ZwQQ7ytSXIvvJ8wPlotLqUjqNcNv6/NE4sh5x5Yzvm5xhqQE1PNhOxSqi82WBO7SlOH5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=ruR9LUl+; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="ruR9LUl+"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3475497eec.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778529332; x=1779134132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJnkyVh9UOwiKW6M83VJ9FYPRfaHqc1ErguB55zjQEk=;
        b=ruR9LUl+1N4L663MrgPmlcdwKbfZHEmlrhUuWFIhg+d7w4tsUJPvQbGBrsuHQiSwrw
         DH8fdnLSaJzProwf1Ug7L/7wLHcc+92TRTZAyDXlM396T5i9E89P17nattVsdglUYk7R
         iU1L0ns0c+IEewx2D6AjneFg6+nU9FJ4fwHpwQsLNuHeUbldA8n3LEWKbzZNFo5vD9z3
         9afoAleOBES8nsERFYu7gAl9908LjrHAxKe/7uNzYqM3tX2QkCnwyJHIfv7+oEp+4L2B
         2WYLLMDcKhenNA9sJGUIkc/dwmZu1NAcQIzReS2qk3+Yy96KFfRoPyziY0joOKLV36hp
         fNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529332; x=1779134132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJnkyVh9UOwiKW6M83VJ9FYPRfaHqc1ErguB55zjQEk=;
        b=CZH+c+SJFekLVuZeoFbSfJVTSCvHjiPb+LS9d1SdSyNUCRr3vh6MpY163io6yVZ5pL
         r8vDPM9I9Oa+S7dxUfZjNyX6CtBLsnNiF4WDKQIIQHQMz/mHt0jzWbUbfzpTwMwQrwdD
         fZGyzSmELQltTN798NsPDlHnNFMr99c3z+l5XvUUru+cpseyGNqylCE7iqGi3GjNG2rH
         R6mRlXjolt9sMKznyHbQ3qwf2wigRlWeWobF33ZfC3BEPp/2Wlnm9mq3hUw8u8kqnfXd
         bg1JE0dlvXySTxO6JONN9ghOjNw6HHPrSmUdAkLEsVWpl0tywgaLpRDx5n0iml/C1Y9/
         mgvA==
X-Forwarded-Encrypted: i=1; AFNElJ/rcDwxgYmlve8vMxN28Wo9gK6T7do+gAfOhkydOPAQ9cybJ0PMYyf7NyGBqh1DRwVvC+scl47Ix3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzThhFQ4657NZR7Hqaqx/41jy4+Q/YAan4TeuLm4SEyrO1gDLJf
	tAy1l/wJy9+CPwRdUh5oIdM3tjVoxhL7H+p0eQQqRmJ6LvTs6ShyiM+lm8FQQRwahJk=
X-Gm-Gg: Acq92OHdPl4GpN8ySSErRQgk2FbpkBaT45iyx7qQE4Mv0QrjlCvcn2V/90pFMQXBFQS
	Y5immOvUs6YCUOH00ut3xnzcf0rYXPByKSF454w43WqJ434CxUrYuqXntC8/kH8Gs6BtwVj/pAV
	7aFRC1heE3lmxRVpvWSyWl6+u7MwC5c+Zu1guj2D360dx2x13/n+l/7EeiwdOsrF30KHjFvLAng
	cguY0f9st8Asot7fiIAFuyqVAqWO+gJ0DP7iPtqJqUJ2na/CEE/Q/qxjyvJh+Dd3oPsdZhO4sAq
	GF5AzQYRwcPoHNJl9speP6R1bxaAlRn7pR/OIte+D+MnVw1fJsaVkhBulhuZTL8txQScD7pDFHa
	8NwwVFmoAmkQ3AV4vOae0xMywG0Ut7GVf/cvc0ArjJRQKVPRFLYZRVQAgeJ0VVcStLOMLfLrQdS
	yRcdLvU8glN15I6j8gMlz1F1EboYypOpb7oLt2BC57CWLdeWXWFCAyrOE+iNWYs3mSqLn+w/G0Q
	yfEkYNP3G7ynJ/zRh8MjydPPGHrXnUacUzOelT6NmqhCWXsqzgBCQ==
X-Received: by 2002:a05:693c:839c:20b0:2d1:9b35:4edb with SMTP id 5a478bee46e88-2ff907f1630mr440313eec.0.1778529332302;
        Mon, 11 May 2026 12:55:32 -0700 (PDT)
Received: from ?IPV6:2a00:79e1:2e00:d201:e58:7bff:fe94:34ed? ([2a00:79e1:2e00:d201:e58:7bff:fe94:34ed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e381c9sm14616666eec.26.2026.05.11.12.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 12:55:31 -0700 (PDT)
Message-ID: <181ea47d-6eb3-404f-a799-e7d545f150be@wkennington.com>
Date: Mon, 11 May 2026 12:55:30 -0700
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] i2c: designware: Convert platform driver to use
 shutdown hook
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
 <20260507-dw-i2c-v4-3-9a447b23bfdf@wkennington.com>
 <af2bpjsvVsqAnqb9@ashevche-desk.local>
Content-Language: en-US
From: "William A. Kennington III" <william@wkennington.com>
In-Reply-To: <af2bpjsvVsqAnqb9@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/8/26 01:15, Andy Shevchenko wrote:
> On Thu, May 07, 2026 at 08:05:17PM +0000, William A. Kennington III wrote:
>> Convert the platform driver to use the new i2c_dw_shutdown() hook,
>> allowing the controller to gracefully NACK master requests during
>> system shutdown.
> ...
>
>> +	if (!pm_runtime_status_suspended(&pdev->dev))
> Same question here.
ACK on previous message
