Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212445;
	b=nA2WnGfifEtBiflfHbFjmirB/o4IqupuW5tvXQDxPQoq5AdW8AYp1BsacCiD8a3l1Ovr
	 1C+keFY0KXkHft2aB64y8vRspYP5a8KcxpowB2UKCQ2EuXcl9LIUczToa6veNNwerQdSu
	 lriyWY5bpjir2+OEVjy4oFAyGdEflFeU8wWWnF5j+l/K7aBCKYmsgG4F2YFKZROAAiCGo
	 dC2MYgHMz+kLHt6pmjgNaaNDs7/Vq/dU1CpcAWsKW8zJHvbryKUwlZ6TiX80yiV6eNLmp
	 mi20YzKh/0WEfzEaBetGo+4L/YCYFDSFv4L7rE6p33EKFQpZtYAb4E56aKn4tUT8Ydw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212445;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DTYmFCEB465wYwuKSVWIKjqhbVZmXzLt8Fc+jMBonX4=;
	b=KeHSEkvku3wRKi4nBoFKpKkBFA5rjiSoXcTkLZWgAjXjVfq1iBuvW9wHceKGAtuT2tCs
	 dB4cVP6McJREasp+CuMtGMDuBCr8ShrWttumiwFnaA9/RE/lWb4ydoZm06mc6XPbQ7u+n
	 bn+6bp20huKKkMwbUj5NYKcmAKJxY6nQpYPdUbe+HCGGEiL/GBPL0F0y0wSUylbqqxg67
	 nkm522ZPuQt+cr+gcwyk0jhMNcziW4hiTvasyfeHg2w2Ch+ZuKrPcluJaVXWwNRVfM5T2
	 QgBVP0GovlawA9K/d5uYXacXboWrF0hcC6zgIJPAhJmpTbhdOzsdLuyGCRYg2mwBf9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2FD606A31C;
	Mon,  9 Nov 2026 08:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F2FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794212449; x=1825748449;
  h=from:date:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Km96QfJf/xhJ8KPGePK7XEw/Gw/0Wp4vlIMbXoYhshU=;
  b=nFWzkk4+GlN6szzZhvtH7F6X/J5yvwQ9+tCFSEJfH1hpLcOjFpfnOBbd
   1OkRhL8HUQVm6/kYTn3xS/n0frrrOHntsgSSfHUZWx9/cgSMXapgWTtGJ
   /6zY347mn5OIZITZPt5Qp5QkmORzm2jyc4oNhOA1KNaKq8t86vpxlhuv1
   rLQRpi79s3IlQ9eRG8Szw3S27pxW6sj4kzDvQ4ocgYBPLF3Dv8F7hEXbM
   eSDyfBLgDgm47Nmz2vawf+ESbNZRXK4XUuKzabMIdTymYwCY/OdIOMKcq
   n6q6XR3/8TNs7O6xDw/O9B0duvNYnyihLIeTX167QxWtbXP+cKKCgbGjI
   w==;
X-CSE-ConnectionGUID: r+T0DYdVQkiZebElOlgokw==
X-CSE-MsgGUID: wqPz6SHoSquiq6bPrq1UWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 10:20:47 +0200
X-CSE-ConnectionGUID: lpKBdzlrSHqCfhnek4/bTA==
X-CSE-MsgGUID: hesYJTjQTs+s5JN1P6z40g==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 09 Nov 2026 10:28:33 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Mon, 09 Nov 2026 10:20:38 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Mon, 9 Nov 2026 10:06:06 +0200
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 srinidhi kasagar <srinidhi.kasagar@stericsson.com>, Ben Dooks
 <ben-linux@fluff.org>, Andrea Gallo <andrea.gallo@stericsson.com>,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] i2c: nomadik: handle pm_runtime errors
Message-Id: <20261109100606.493ca48095bcc3527be18573@mobileye.com>
In-Reply-To: <avFzEaxgam-UuZH0@ninjato>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
	<20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com>
	<avFwLctRcnJHtINQ@ninjato>
	<avFzEaxgam-UuZH0@ninjato>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Wolfram,

On Mon, 9 Nov 2026 08:15:29 +0100
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> > Testbots revealed a smatch warning:
> > 
> > drivers/i2c/busses/i2c-nomadik.c:737 nmk_i2c_xfer() warn: pm_runtime_get_sync() also returns 1 on success
> > 
> > I will fix it here.
> 
> Like this:
> 
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index 104da275ff91..8cf1d443a25c 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -734,13 +734,13 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	struct nmk_i2c_dev *priv = i2c_get_adapdata(i2c_adap);
>  
>  	status = pm_runtime_get_sync(&priv->adev->dev);
> -	if (status)
> +	if (status < 0)
>  		return status;

There is another problem with this patch: 

include/linux/pm_runtime.h:

> * Note that the runtime PM usage counter of @dev remains incremented in all
> * cases, even if it returns an error code. Consider using
> * pm_runtime_resume_and_get() instead, especially if the return value is
> * checked by the caller, as this is likely to result in cleaner code.

I think we just need to replace pm_runtime_get_sync(&priv->adev->dev) with
pm_runtime_resume_and_get(&priv->adev->dev).

This solves both the positive return code issue and the usage counter leak.

Do you agree?

Best regards,
--
Dmitry Guzman <Dmitry.Guzman@mobileye.com>

