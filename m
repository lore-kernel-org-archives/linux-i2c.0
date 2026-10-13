Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70204FECC6;
	Tue, 13 Oct 2026 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899084; cv=none; b=pLjumUDBYsLZMhHQmkKn+fxMEcy4HbDfH1wNUotuaZO3P0e4wUCPYs7un0cOltLhMNmNd74F8Cbeg3yCnPD1Ar15a3YY2UF+Iol5ER/4HVA5vRe45y6fmQOR+gBkFGXMYaYQEBfyM+8vq9LlZ/iXN/4VQlY0BthodDL6Jy1ca8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899084; c=relaxed/simple;
	bh=piAiww51YRB6HNo2b8t6J4hR12jxUaVQeDexGXvZqnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PIQm7rpHp5d3szQDH9RxEtBLH59Tak05oBLJZGV++DB/p4P89k6xnRHq7/G2aMRgE0Yw8v/vnwC1+Ogoly+Y/Ta6FfsMUp8XM+GabNrmXcKrm+G9jQ3RoMSnMDQjRZHWGUY8OHVnTgyYUexD3YTTxLJ8T2FMn3X4Fq8h7DYogoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j3wHN66pRzKm9J;
	Tue, 13 Oct 2026 21:32:16 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 1345340586;
	Tue, 13 Oct 2026 21:44:38 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 21:44:37 +0800
Message-ID: <96db6147-f9f2-4f27-b43c-e3c3f9e9f94f@hisilicon.com>
Date: Tue, 13 Oct 2026 21:44:36 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] i2c: hisi: Add I2C bus recovery support
To: Bowen Yu <yubowen8@huawei.com>, <linuxarm@huawei.com>,
	<liudingyuan@h-partners.com>, <andi.shyti@kernel.org>,
	<linux-i2c@vger.kernel.org>, <acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>
CC: <prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<xuwei5@huawei.com>, <ouyiyong1@huawei.com>
References: <20260929121348.109556-1-yubowen8@huawei.com>
 <20260929121348.109556-3-yubowen8@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260929121348.109556-3-yubowen8@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 9/29/2026 8:13 PM, Bowen Yu wrote:
> When the I2C bus is stuck due to a slave device holding SDA low
> (e.g. during an incomplete transfer), the master has no way to recover
> the bus through normal operation. Add bus recovery support using the
> subctrl register to manually toggle SCL and generate clock pulses to
> release the bus.
> 
> The recovery is performed via a second register resource (sctrl_base)
> that provides direct control over SCL/SDA lines through mux and
> output-enable bits. After recovery, the I2C controller is reset through
> the ACPI _RST method and reconfigured.
> 
> Recovery is only registered when the subctrl resource is provided in
> the firmware description, keeping backward compatibility with existing
> platforms.
> 
> Signed-off-by: Bowen Yu <yubowen8@huawei.com>
> ---
>  drivers/i2c/busses/i2c-hisi.c | 142 ++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
This version looks good to me now.  Thanks!

Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com> 
