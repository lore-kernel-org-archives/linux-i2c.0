Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADF37E2FE
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529315; cv=none; b=WHNqwxYTM7Y9g2lM01xeaAuoREl+ZRqCKOSF8vFPNkV1kJrH0y1Lui4lDeOWg5fxuCGSb+KGCGeSxa1LC5y56IrwEzLAqPanRAgMxqK8v5oT9XFDzlYzArDnBnJhndoLkhsaFEExgXLnW3PXLYyYBlS2h0nD5WrgnRr09pktCbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529315; c=relaxed/simple;
	bh=y7RyIjZ5lQwaXinf+QCKIdAlERDihfdqXGl92iysSAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocg91pFe7X+bfceV2LfXygsz2gcogP/zEpywprZfURQN6XUv3vLrqtgqmKQww4qE2mXDjUQ99fStNgwe+LgGpOnhaQX0ti+fUkfJNAJeVx8nO3zSoUZVMAfhnUZ0oMOKYU0gSWUTl6BS7c6rci1xrT2wYAV/ZFqQlA64i7166eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=01J05Fpy; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="01J05Fpy"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1309f4ee97fso5858843c88.1
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778529313; x=1779134113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pjKeLWgjHBQTkmJ6p6z8OY+FQ1KX7+7BPlZYS7zHpNw=;
        b=01J05Fpy/eIg2sLwC3qpMLB+5cguVkBhcoyWqa5m+Ne2JMy3gQOI3txe6p278NvM+d
         MRECLXAASzAeP5PB91W1gDFHBcN8g7WHvnR15E4Ri2yIaphguzFhKk5SakZwjwWKIxuN
         Ls87baKlTOewhi57iBaqckNwTiHcO9z8pFeMpKNvn6P1HrQakjG5zS4H7YuNPtS8f05f
         a8Dtw/YxWlM+ZEojU6FouJzK+mQ8eia37wauFVByMmmXt1pwUeg1FIQbxLv80JiK0vlH
         Iqn+EENPNbHH+zf1Q9P9IZe+fIqzEvbDw8dfq+TOKreK7PYIpxLQWYkd9ZLElEWikLIu
         2Wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529313; x=1779134113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjKeLWgjHBQTkmJ6p6z8OY+FQ1KX7+7BPlZYS7zHpNw=;
        b=lCmpCgRGmJjumWIhGEZqVbsT/Om+gLSAlSCS5hnXifYPF3ZXS7DrJt69VR8Irp9Fmw
         AX1O3hHWW/33bjf48UByiZz1CVeduB67PNQCMGUNKTG1/0csS6IkqN2ZrNPrziV79lZu
         I8LJ0TyY/puSC2+goOYvBsFfSeU1zIbdhUryDYNjGKIxUoxdMz/rfAAdojFNTS27znpo
         usty5HxZ9hNWysbHb1exReh+Bzv9LHTozz/3GGgUiyKYI/JjQkTVmUODA2F/G47QTpjQ
         9sOUT+b6yc6cWOgwqD0yyM3Vx9dBwvvpifD9rPx3hc7gJeaxOGYe34NPbc4UPAM4VnJF
         yeyw==
X-Forwarded-Encrypted: i=1; AFNElJ90wYRjUTuahWwvvxnGCTDCMVP0TrnQb/PtNgx5DgNTBatsrERGZNr2xB1Sfk9cx8JDdkV87uc8LR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Dl8F5Y6P9lsclOI3zcm3IEJDNOi4GUQQ1lL8lQ5W7fhCLMrV
	CKLIAtsnr1XM4zCAqACKCJ9a1o4+X+/zKPYQOuSbFhvR/1rf5HgGmwa4KalJ6/vZUh0=
X-Gm-Gg: Acq92OEg7RrYIzNlhqPH1E98YphNHPq84RcBvJIA5R0UlZp1bTOEmet6uV+Mk5yTyte
	FnBp4EGbUVTRUNYqpFrKSuWjRTNuUGbuFAkZK9w7zbDcwMEW0Yi0nVf8048lw7YYWDxVT/gk6p8
	NUnT8FXwjeldLvzXuIyd8q1lTjwnZII93pTKNUYHULcp6Wz4dKG//HV7ex/6m5fxu9GWVjEidGE
	FjUn+JHqkAB7U37EswTiCwg4YbwySE62j68vsKzGNOeOtRnC6IFkbq8gl/fntrJTeGEhWOf0NKl
	cxVuQINVDSfI7J4vnBv0dE3f3KW/r8goGMcgVGEdBPKyf2TzQz2I6kcgGfFzTxqmcX8c/JelAHg
	bVP6uuIGQWiJX8+6NNRkd11Sn4DAxjjHZX7qZnOjzGPdebucy4fVKS6hAeHsDEOXgToSYSWmyaf
	PmS7le47ZeHWbDL5d7Rj1N9L9RwzWhuOYDLXpg3RXggZXc8HdgN1ExQbRVGyd26QGpayU0q+BLp
	7nKi+pGgTEZpeTzGkVF2TxqYOnJojw0d9K2rMW5ZmIPgqCAGtCbbQ==
X-Received: by 2002:a05:7022:6899:b0:132:5e72:43d3 with SMTP id a92af1059eb24-1325e724784mr9414388c88.29.1778529313040;
        Mon, 11 May 2026 12:55:13 -0700 (PDT)
Received: from ?IPV6:2a00:79e1:2e00:d201:e58:7bff:fe94:34ed? ([2a00:79e1:2e00:d201:e58:7bff:fe94:34ed])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865700asm15837620c88.9.2026.05.11.12.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 12:55:12 -0700 (PDT)
Message-ID: <92459fea-da73-4e16-890a-6e6f42621c0e@wkennington.com>
Date: Mon, 11 May 2026 12:55:11 -0700
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] i2c: designware: Convert PCI driver to use
 shutdown hook
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
 <20260507-dw-i2c-v4-2-9a447b23bfdf@wkennington.com>
 <af2biS8SRkeNtGDC@ashevche-desk.local>
Content-Language: en-US
From: "William A. Kennington III" <william@wkennington.com>
In-Reply-To: <af2biS8SRkeNtGDC@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/8/26 01:15, Andy Shevchenko wrote:
> On Thu, May 07, 2026 at 08:05:16PM +0000, William A. Kennington III wrote:
>> Convert the PCI driver to use the new i2c_dw_shutdown() hook, allowing
>> the controller to gracefully NACK master requests during system shutdown.
> ...
Done
>
>> +static void i2c_dw_pci_shutdown(struct pci_dev *pdev)
>> +{
>> +	struct dw_i2c_dev *i_dev;
>> +
>> +	i_dev = pci_get_drvdata(pdev);
>> +	if (!i_dev)
>> +		return;
>> +
>> +	pm_runtime_disable(&pdev->dev);
>> +	if (!pm_runtime_status_suspended(&pdev->dev))
> There is a difference between pm_runtime_status_suspended() and
> pm_runtime_suspended(). Are you sure you use the proper call here?
> (Please, double check.)

pm_runtime_suspend() would always return false after pm_runtime_disable()

>
>> +		i2c_dw_shutdown(i_dev);
>> +}
