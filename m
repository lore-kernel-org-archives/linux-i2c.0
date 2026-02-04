Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D941B359
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227905; cv=none; b=BC08m7oi8tHa9o3uVqpTXYWWP3JcY38SYpxue+ENULhfbN2HTEivDFmgWw30UePdQQmMM2v2/gElUry3sIV5OkEG1/RfB1gvfytaiNTcZPdkxs7igIXwiAW7sjWwHYO3z29989JQVxUTAEWW3+3ICPPLAlM1P5WwxipHmRRpw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227905; c=relaxed/simple;
	bh=Ylflu87t4XO6Boqx/bumFhPwthDDDNETXoAlSRV/YZw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k6d5ycDYTyM6HBxMTWQTkRATPK6888AtUNBEhJAxf1QTavEIRBGyTL2ft1F4SIdQRwYUSM1c21VW5g934niVhN2uVKWyxfHOEz+o1k4tqbtqN7xjG69127hr7Vieqonda18YjlsdRk+DxXjJNalWcjxbxYHpe8FVaag17IeMDsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=ccxnFtkr; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="ccxnFtkr"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c6541e35fc0so4156638a12.3
        for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1770227905; x=1770832705; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dP9+SSaF4S/xGob3h6+xhj4HHf6/W4fGZ/oR1PAFXQ=;
        b=ccxnFtkr5YTc6/9ZIdDRV9UIXW2/RsQWDMQH6mQq44pHXPadWv0O8c8uCl8YMUt3wC
         8PioN4Bg+1338MYH5jtq6XSIxpZTdBXEs8LbyyKUhkW0KEvcAv119T8uC15TLVCq3GWv
         9I9+E6FSMyvDjL/TIweAKvFQOx1Al/jyoRc399hQDnWCd7N4cJBUQqJjKG3KJkKxmCns
         PAR1Dey89mPDRv6gk7LQqROVQJyR/nRNgTi5EfJPdLS8RlJEqZ05A+AvfHApdo/ryocJ
         AwX0bYN23PTZhTcmkeHCwmqKKfLI8m12MGi2EctNxoE+RV9kNBC4fCIJtwUpKBX5d3Th
         Nk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227905; x=1770832705;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dP9+SSaF4S/xGob3h6+xhj4HHf6/W4fGZ/oR1PAFXQ=;
        b=EUA2YWeYGPvkjSWaBhPrOpCnotANEBXuLoi7M4cfAOkRD8NEMXvo9Om5bSdkbBqfgo
         Trz80vy5caopE1zAh07s4Cp7sqxomPoZkMzC1e1WG7PYLu02eVUvB7Ex18QyW/sjUBYL
         YiBPqqM5pieuvhacNmpvst9rZqiH+OmI9f1jVCF7hWXxMy4B5UjBEySW7S7h2WBZx7FS
         4BGP2S9tAtSTQmIGYyZjxiQzw2QjJoQLNbz0NQsOVyl1re9w+ffOV8ePAbQoxJacC7Pg
         sg5XGrQNxH5DuGwJABuCq1ntTWmx98qU17bbk4dqJWCVmvV0CUE+pvamVuBUqKWnl9iz
         4QWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrr0udCfwX9mf2HDFnnVgrQ1hPE8B5EOq8jymKqfn3I9VbwvZm8Xam3Wx3F2jZ+zlHZX/K6CWtdbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZuTVWSQ4Y0Wznn70PA14Mqhhfr7f8rteVqiSUSYLlxE59OMb
	eH+UPRJlqEw6cTICxZQD9xmXRKqCahxl2dqANqKFRKzMmB2eH7rQLJ99kwXTP8NirGE=
X-Gm-Gg: AZuq6aJNkN/m0LwwrnBm5BpdVyJzv3p79VXS6HTqgiLIvnUbaJDQ/WITCUBqsTNg6LX
	yEuP7VJ7ajnR+3sGs723YIwv78o2L2HcvkVryYAwy7xH05W8LFzc2TACu/0Nc5G/wL6EHW6YO3P
	fvSbdzfj3XhTgAPMgViPflOjc6CCaO/+WxKmvUX3OCVrRVuFUKcDK85lLDTHs3tjW+jC908XdgN
	z1/VDNA2k5ummIH6pcpG8tFeVC/3l9cLODZSR+ptw8GxTmtCEC4pQ53QU9sVsrxTje79UqAX7Z9
	CB0c7vmMGEFDAQ0NLQwIJotA/MYi8rzHlww0zchYtJfWfpRGs/a55UMBZ25QUI0xqICYvoBEEm/
	1jYbrjFmTVLbo5Vv3PVU5bsuN6kjKG3nG09WVak1/rozNnZjvRPttr0uyADk/UBpHeegmGkakXi
	cFXS5h7HBh3O5b/NxUXWIefHOjvczkRoKaksM=
X-Received: by 2002:a17:903:1a86:b0:29e:e925:1abb with SMTP id d9443c01a7336-2a933e44bd1mr39524525ad.27.1770227905009;
        Wed, 04 Feb 2026 09:58:25 -0800 (PST)
Received: from smtpclient.apple ([50.47.115.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e84asm29646375ad.47.2026.02.04.09.58.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 09:58:24 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v10 1/7] i2c: xiic: switch to devres managed APIs
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <20260204100034.000050b2@huawei.com>
Date: Wed, 4 Feb 2026 09:58:14 -0800
Cc: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9BCFA228-EC6D-4084-A63E-060917C948E0@nexthop.ai>
References: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
 <20260204-i2c-xiic-v10-1-c2b996425235@nexthop.ai>
 <20260204100034.000050b2@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Feb 4, 2026, at 2:00=E2=80=AFAM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Wed, 04 Feb 2026 07:01:58 +0000
> Abdurrahman Hussain via B4 Relay =
<devnull+abdurrahman.nexthop.ai@kernel.org> wrote:
>=20
>> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>>=20
>> Simplify the error code paths by switching to devres managed helper
>> functions.
>>=20
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>=20
> A quick drive by review whilst I have a coffee...
>=20
> 1st one is a taste thing. Second one is kind of a bug - be it one that
> I think is probably harmless.
>=20
>> ---
>> drivers/i2c/busses/i2c-xiic.c | 29 ++++++++++++-----------------
>> 1 file changed, 12 insertions(+), 17 deletions(-)
>>=20
>> diff --git a/drivers/i2c/busses/i2c-xiic.c =
b/drivers/i2c/busses/i2c-xiic.c
>> index 28015d77599d..16ff83fe280b 100644
>> --- a/drivers/i2c/busses/i2c-xiic.c
>> +++ b/drivers/i2c/busses/i2c-xiic.c
>> @@ -1423,6 +1423,7 @@ MODULE_DEVICE_TABLE(of, xiic_of_match);
>>=20
>> static int xiic_i2c_probe(struct platform_device *pdev)
>> {
>> + struct device *dev =3D &pdev->dev;
>> struct xiic_i2c *i2c;
>> struct xiic_i2c_platform_data *pdata;
>> const struct of_device_id *match;
>> @@ -1461,7 +1462,10 @@ static int xiic_i2c_probe(struct =
platform_device *pdev)
>> snprintf(i2c->adap.name, sizeof(i2c->adap.name),
>>  DRIVER_NAME " %s", pdev->name);
>>=20
>> - mutex_init(&i2c->lock);
>> + ret =3D devm_mutex_init(dev, &i2c->lock);
>> + if (ret)
>> + return ret;
>> +
>> spin_lock_init(&i2c->atomic_lock);
>>=20
>> i2c->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
>> @@ -1472,8 +1476,9 @@ static int xiic_i2c_probe(struct =
platform_device *pdev)
>> i2c->dev =3D &pdev->dev;
>> pm_runtime_set_autosuspend_delay(i2c->dev, XIIC_PM_TIMEOUT);
>> pm_runtime_use_autosuspend(i2c->dev);
>> - pm_runtime_set_active(i2c->dev);
>> - pm_runtime_enable(i2c->dev);
>> + ret =3D devm_pm_runtime_set_active_enabled(dev);
>> + if (ret)
>> + return ret;
>>=20
>> /* SCL frequency configuration */
>> i2c->input_clk =3D clk_get_rate(i2c->clk);
>> @@ -1489,7 +1494,7 @@ static int xiic_i2c_probe(struct =
platform_device *pdev)
>>=20
>> if (ret < 0) {
>> dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
>> - goto err_pm_disable;
>> + return ret;
>> }
>>=20
>> i2c->singlemaster =3D
>> @@ -1508,16 +1513,14 @@ static int xiic_i2c_probe(struct =
platform_device *pdev)
>> i2c->endianness =3D BIG;
>>=20
>> ret =3D xiic_reinit(i2c);
>> - if (ret < 0) {
>> - dev_err_probe(&pdev->dev, ret, "Cannot xiic_reinit\n");
>> - goto err_pm_disable;
>> - }
>> + if (ret)
>> + return dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
>>=20
>> /* add i2c adapter to i2c tree */
>> ret =3D i2c_add_adapter(&i2c->adap);
>> if (ret) {
>> xiic_deinit(i2c);
>> - goto err_pm_disable;
>> + return ret;
>> }
>>=20
>> if (pdata) {
>> @@ -1529,12 +1532,6 @@ static int xiic_i2c_probe(struct =
platform_device *pdev)
>> dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
>> (unsigned long)res->start, irq, i2c->i2c_clk);
>>=20
>> - return 0;
>> -
>> -err_pm_disable:
>> - pm_runtime_disable(&pdev->dev);
>> - pm_runtime_set_suspended(&pdev->dev);
>> -
>> return ret;
> Trivial but if you are respinning...
> If you get here we know ret must be 0, so make that explicit to the =
reader as it
> was before with
> return 0;
>=20
> Otherwise they need to look up a few lines to realize that is true.

Thanks! Will fix in v11.

>=20
>> }
>>=20
>> @@ -1555,8 +1552,6 @@ static void xiic_i2c_remove(struct =
platform_device *pdev)
>> xiic_deinit(i2c);
>>=20
>> pm_runtime_put_sync(i2c->dev);
>> - pm_runtime_disable(&pdev->dev);
>> - pm_runtime_set_suspended(&pdev->dev);
>> pm_runtime_dont_use_autosuspend(&pdev->dev);
>=20
> Take a look at docs for the devm_runtime_enable() that is called
> by the cleanup for devm_pm_runtime_set_active_enabled()
>=20
> Short story, it will call pm_runtime_dont_use_autosuspend() for you

Thank you for the feedback Jonathan! Will fix in v11.

