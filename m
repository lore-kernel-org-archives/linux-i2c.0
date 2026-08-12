Received: from Atcsqr.andestech.com (220-128-198-181.hinet-ip.hinet.net [220.128.198.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D742472B6;
	Wed, 12 Aug 2026 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.128.198.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505558; cv=none; b=R8Jfz50Y5k9OQHxruz4xDfC+3SPp2FqEJnvJZJ3WTDaGdRsKHLGZ0iKcz8jdz6veatJgyhyYnOM0k+IvZ14RZN5JHD5NGVv272K8RP0cyXag5zkGZeLxNmDs3zFOTV+mdKERdo8xj5SuRCf4kpYE/T6R98eJYiQNKQqcaGMurpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505558; c=relaxed/simple;
	bh=Vt4npGdHVAVO1FMJtYfce7egZqTKAr+j0do1EqgqjVk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJXwI7MJue/uBdDuLwSurJ5VcEs2LyHmeTPBO+JpVsprHOaxDDrpHxFa+aLZ+9aiD8kkSobEKBzsOFje/QDZUHVh6NjCSO/tBSMxyl6RzM4gDDy2v47DssM2tYAzOf69PRH/Q5/Jx/vjwtg1DAs0hWFlLoQmfZEGT67jzWHGMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=220.128.198.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
	by Atcsqr.andestech.com with ESMTPS id 67C3VclI039026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:31:38 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Wed, 12 Aug
 2026 11:31:38 +0800
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Aug
 2026 11:31:38 +0800
Date: Wed, 12 Aug 2026 11:31:37 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 2/4] i2c: add Andes I2C driver support
Message-ID: <anvpGTqOnwlbERgR@swlinux02>
References: <20260811-atciic100-v5-0-1d306c21dba3@andestech.com>
 <20260811-atciic100-v5-2-1d306c21dba3@andestech.com>
 <361b7fa5-0e4c-429a-ad66-c81fbee86c45@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <361b7fa5-0e4c-429a-ad66-c81fbee86c45@wanadoo.fr>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 67C3VclI039026

On Tue, Aug 11, 2026 at 09:37:12AM +0200, Christophe JAILLET wrote:
>
> Le 11/08/2026 à 08:29, Ben Zong-You Xie via B4 Relay a écrit :
> > From: Ben Zong-You Xie <ben717@andestech.com>
> >
> > Add support for Andes I2C driver. Andes I2C can act as either a
> > controller or a target, depending on the control register settings. Now,
> > we only support controller mode.
> >
> > Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
>

Hi CJ,

> ...
>
> > +static struct i2c_algorithm andes_i2c_algo = {
>
> Could this be const?

Yes, I will add const in v6.

> > +     .xfer = andes_i2c_xfer,
> > +     .functionality = andes_i2c_func,
> > +};
> CJ

Thanks,
Ben
