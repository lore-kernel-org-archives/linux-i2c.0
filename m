Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD44218AB9;
	Wed, 11 Mar 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773228830; cv=none; b=h4VROvTJujAJUbz/GQHIw/fOo08cQMRqzwFq+hVhNIE7L8SRHfdc80BkzpJkEKJEGiq9CYQhxgEU/sadtl9WnyL0su4iGOHC/Nv76JCCj2U3c7IGfflGCaw+uvYlUaLpC0v8UmLVI94DRwufYF7LVYs4w6f5rcDzuS/9FGTgleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773228830; c=relaxed/simple;
	bh=29nHbowR7ZZ7bjPxN017BNgAheB6XpNZV73o2KEY8U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cC5SpHx1M3hwKzEgI0wSxIwrLbWb9T7qwO4AZ1VFWTw0b/ZE7CpwHoii0MEf29ixzHOUbx2uIhpr5urPL8sYfJj+YKim032Oexpijg7LFcAlrr5tB7jnEtf2cNUHZedEtMlaZgZRfPv6E6HKyjMGidCVaHRqBQ9doM9B7zRVOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foZ1F6ay; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foZ1F6ay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773228829; x=1804764829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=29nHbowR7ZZ7bjPxN017BNgAheB6XpNZV73o2KEY8U0=;
  b=foZ1F6ayTnfyyspeCu1m6oAjYk6/oDXNgST/HJR+CzDagIGOa599UZRT
   OJOA7SnQ4Vn+9isyyNXbtgRFPy5qWXleDAyJ6DKFgO19SPtiUc0WTLnvE
   2q06ZmLu/XBeiswGr1eoyDPozt6U4Gtk48LZxVsbrjXmOmktAShN9y0J4
   P4JkD2iT38bl5qnhuOO+RkX5ENi5qvo+18DtBgmf4dxcuRnu5C6zG8uJM
   Lt5lwdTIBhtq3PjPdk9Pp+wmqTObYEXOJSnMdjvjP/jh0E+X+Qmo7eR0u
   Ug6mf+7XHqLDc9pemF2GM9UNefQwFyb6qFynStptkDiLjhMjAlxlpG3D/
   Q==;
X-CSE-ConnectionGUID: ZWRgDSvsQOS5mrnQgfhoLQ==
X-CSE-MsgGUID: n4gv3jKFQomBX0Hh7Psc8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61867235"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="61867235"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 04:33:48 -0700
X-CSE-ConnectionGUID: XeShyzirSN6n+xqR5uLf8Q==
X-CSE-MsgGUID: dYyY6+3qQrK4FjJiRMZmoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="215675282"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 04:33:45 -0700
Date: Wed, 11 Mar 2026 13:33:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C
 controller
Message-ID: <abFTF-RDxLqsSs6X@ashevche-desk.local>
References: <cover.1773142933.git.zhoubinbin@loongson.cn>
 <bd5c06a20ef2e61f76902c4209f2be539ca91a97.1773142933.git.zhoubinbin@loongson.cn>
 <abAyd9uyl3TC8vC_@ashevche-desk.local>
 <CAMpQs4JVYRo4DQyEVe5NhHQ=VN96mF17AtSoo6a4CGB6w_Aphw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4JVYRo4DQyEVe5NhHQ=VN96mF17AtSoo6a4CGB6w_Aphw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Bart (what's going on with i2c_adapter_set_node()?)

On Wed, Mar 11, 2026 at 11:07:19AM +0800, Binbin Zhou wrote:
> On Tue, Mar 10, 2026 at 11:02 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Mar 10, 2026 at 07:48:53PM +0800, Binbin Zhou wrote:

...

> > > +     struct device *dev = priv->adapter.dev.parent;
> >
> > Derive it from regmap (and check elsewhere) as accessing dev in the adapter
> > may lead to issues related to the object lifetime.
> 
> Do you mean regmap_get_device() API?

Yes.

> Also, similar references exist in `loongson2_i2c_xfer()` and
> `loongson2_i2c_isr_event()`, requiring synchronized updates.

Correct.

> > > +             return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to enable clock.\n");
> > > +
> > > +     irq = platform_get_irq(pdev, 0);
> > > +     if (irq < 0)
> > > +             return irq;
> > > +
> > > +     adap = &priv->adapter;
> > > +     adap->retries = 5;
> > > +     adap->nr = pdev->id;
> > > +     adap->dev.parent = dev;
> > > +     adap->owner = THIS_MODULE;
> > > +     adap->algo = &loongson2_i2c_algo;
> > > +     adap->timeout = 2 * HZ;
> >
> > > +     device_set_node(&adap->dev, dev_fwnode(dev));
> >
> > Why?! i2c_adapter_set_node() is part of the i2c-next.
> 
> Indeed, when I rebased the v4 patchset, `i2c_adapter_set_node()`
> existed in the i2c-next[1]. However, when I prepared the v5 patchset,
> it was removed[2].
> 
> [1]: base commit: 6117e1ba1db78a52a4161208ea403d3769ad73c6
> [2]: base commit: b82316862bea929265725c077dffcec42e3dc20b

Bart?

-- 
With Best Regards,
Andy Shevchenko


