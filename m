Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7131F9AB;
	Wed,  3 Jun 2026 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468793; cv=none; b=ixNJi7AnXolGJ07eoAjJM9YvzKNQ5v84HNdCQMhxkVt9cEH4cjmd0L6QKsTt9/GhEueIR8demY37OUV+9oFJJLys8/w70Zc57bsG+HCPdTzJTTh4Ovfji168IqcWAK2Ax5ejc9Qa7sNHLam4tyHbeCmLFgzQVMO+DMAeuMtgJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468793; c=relaxed/simple;
	bh=QmIWRaXeF2fKRC17cCFiZPWUh2eCA1WqliMbAIdeuSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1smaD0KhRQItC1JYPJPasAgU0lc3VVlJnfCCEsCN0/KgE50iZlnKJMPQ5tn6pAgAfIx1DxJ+sgMIjaGDe1CRf/9zXbGMON1NGnHMiyiJQRMg69R3jPKntLeNt2xn0CDi9jP8zDzNsS4gM6yog4yvrJ6LYYC44d8f18dWPuy5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/qET2L+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/qET2L+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780468792; x=1812004792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QmIWRaXeF2fKRC17cCFiZPWUh2eCA1WqliMbAIdeuSc=;
  b=U/qET2L+UieVQYtr0iOEYqlpBAV2HecNbDIe4Bzbgo3Pruhe1Uptn2WQ
   jPZj8Ez0FqzNtNSa7RbCEWl2uYMz5dOS86da2UAJ0RoseeuUyfiFohatn
   MU+iZTLa6q08oJPwWuUIY3bH+fFiWv4QZtyHeqkAq0qXEpESjKPVsRZkX
   TjK7If+8G2uyZSH1dANNSw+Cq/T5e3EdIGNWQ3RwPzHsOwW4tg6amvBat
   c3hOPgeu9N9hd5P1P4FPalD36+Y3YIiRSPzMrOqkrK0Dk4ZMXGswUKw+Z
   ZInhx1KhJdPyKh9E185fpoPNCyaDb5q6+iA3V3CXqmv55v2Zjf3rPXh4+
   w==;
X-CSE-ConnectionGUID: jS01UFwJRoOl19dGqdZ4Cg==
X-CSE-MsgGUID: i2r4Y9cuRDSWknGysxLAuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92750733"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="92750733"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:39:52 -0700
X-CSE-ConnectionGUID: mAoLJE4xTLWZHY26Wo03Yw==
X-CSE-MsgGUID: tQHaaNqJRFeWfj7ajuGnGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="243976573"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:39:49 -0700
Date: Wed, 3 Jun 2026 09:39:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?= =?utf-8?Q?H?= v2 0/3]
 i2c: Add Starfive JHB100 I2C master/slave support
Message-ID: <ah_MM_Ur-VGixAyr@ashevche-desk.local>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
 <ah9Yrt_gO8uGaPw_@ashevche-desk.local>
 <ZQ0PR01MB12690FA279708FD6A6DB063282132@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
 <ah_AOjTY9effYDtb@ashevche-desk.local>
 <ZQ0PR01MB126986C9C4A60F6AA767F3D882132@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQ0PR01MB126986C9C4A60F6AA767F3D882132@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 06:09:24AM +0000, Lianfeng Ouyang wrote:
> > -----邮件原件-----
> > 发件人: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 发送时间: 2026年6月3日 13:49
> > On Wed, Jun 03, 2026 at 05:31:38AM +0000, Lianfeng Ouyang wrote:
> > > > -----邮件原件-----
> > > > 发件人: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 发送时间: 2026年6月3日 6:27
> > > > On Wed, May 27, 2026 at 04:50:36PM +0800, lianfeng.ouyang wrote:

> > > > > The Starfive JHB100 I2C controller is a variant of the widely-used
> > > > > DesignWare I2C IP, with a distinct register layout and enhanced features
> > > > > such as SMBus Alert and programmable FIFO depths.
> > > > >
> > > > > The series is structured as follows:
> > > > > 1.  Adds the device tree binding document for the starfive,jhb100-i2c
> > > > >         compatible.
> > > > > 2.  Prepares the existing i2c-designware-core by exporting and making
> > > > >         certain key functions overridable, allowing code reuse.
> > > > > 3.  Introduces the new i2c-starfive-* driver, with separate modules for
> > > > >         master and slave functionality, based on the 2023-07 revision of
> > > > > 	the Synopsys IP manual.
> > > > >
> > > > > Currently, due to the following differences, i2c designware cannot be
> > > > > fully reused
> > > > > 1.  For high and low level counting settings at different rates, i2c
> > > > >         starfive can use IC_SCL-H/LCNT to set SS, FM, FM+, UFM
> > > > > 2.  Interrupt clearing is achieved by writing 1 to the corresponding
> > > > >         bit of INTR_CLR, while designware reads different clearing
> > > > > 	registers
> > > > > 3.  Master and slave require separate probe callbacks and cannot rely
> > > > >         solely on the runtime mode switching provided by
> > > > i2c_dw_set_mode()
> > > > > 4.  The value of FIFO depth is not obtained through registers, but
> > > > >         written through DTS
> > > >
> > > > NAK in this form. We well discourage code duplication and ugly ifdeffery with
> > > > full of __weak annotations that may not be present in the regular driver.
> > There
> > > > is not even a tiny bit of justification for this nonsense.
> > > >
> > > > TL;DR: this series needs much more work.
> > > >
> > > > > I have written some poorly styled code to reduce changes to i2c
> > designware
> > > > > and reuse its functions by keeping aa always true, for example
> > > > > 1.  the implementation of i2c-d w_probe_master() differs only for the two
> > > > >         IPs in i2c_dw_set_timits_master(). In order to reuse
> > > > > 	i2c_dw_probe_master(), i2c_dw_set_timits_master is declared as
> > > > > 	__weak. A better approach is to use a callback function, but using
> > > > > 	a callback function requires changing more i2c designware files.
> > > > > 	I don't know what the attitude of the community is
> > > > > 2.  For the operation of clearing interrupt flags, i2c designware reads
> > > > >         and i2c starfive writes. Therefore, in order not to modify the
> > > > > 	relevant logic of i2c designware, I added a write operation to
> > > > > 	sf_reg_read()
> > > > > So I think this version of the code is not allowed to merge, but I don't
> > > > > know how to handle this situation because if i2c designware is not changed
> > > > >  at all, we will have to write code that is similar to i2c designware.
> > > > >  Will this type of IP not be allowed to merge?
> > >
> > > Thanks for the review.
> > >
> > > In the future, the designware will be changed to the form of callback functions,
> > > and then callback functions will be passed in i2c starry - * and implemented
> > > using designware as a library
> > 
> > Why you can't specify your own regmap as it was done in Baikal case? What are
> > the obstacles to achieve that?
> 
> The main reasons are as follows
> 1.  For high and low level counting settings at different rates, i2c
> starfive just use IC_SCL_H/LCNT to set SS, FM, FM+, UFM, 
> ====> Therefore, it is not possible to directly use the i2c_dew_set_timits_master() 
>       of designware, Because the definition of registers has changed

So, it's not a DW per se? What the DW databook reflects the register layout and
other bits? I.o.w. which version of DW i2c IP is this?

> 2.  Interrupt clearing is achieved by writing 1 to the corresponding
> bit of INTR_CLR, while designware reads different clearing
> registers
> ====> The way of operating registers is different, so it cannot be 
>       distinguished solely by address or offset, and can only be adapted 
>       to operations belonging to i2c starfive through callback functions

This can be done in the custom regmap functions. You know that you may
redefine the regmap IO accessors and do whatever you want there based on
the registers. Yes, what you are probably talking about is a workflow.

But we basically need to see a patch-per-workflow change for each case
to understand the differences better. I.o.w. if you need, for instance,
separate or special IRQ handling part, create a patch to move existing
code to a callback with explanation why it's needed. All the same for
the timings and so on. It would be nice to have a datasheet at hand to
actually read and see the differences. Without that it's even hard to
propose better solutions. But current state is for sure no go.

> 3.  Master and slave require separate probe callbacks and cannot rely
> solely on the runtime mode switching provided by i2c_dw_set_mode()
> ====> There are host and slave IP addresses separately, unlike designware 
>       where one IP supports two roles, because the logic of switching roles 
>       cannot be distinguished by address and offset

This feature should be left at last, but altogether it smells like either
a completely new i2c DW design (like they did for DMA and SSI at some
point) and most likely will need a brand new driver explaining all of this
with a link to a datasheet.

> 4.  The value of FIFO depth is not obtained through registers, but
> written through DTS
> ====> The register does not have information on the depth of FIFO, 
>       and manual writing of register settings is required
> 
> In addition to the above four points, the initialization, transmission, and interrupts 
> of i2c Starfive are basically the same as i2c Desirware. Therefore, we hope to reuse 
> i2c designware instead of re implementing the i2c Starfive driver, otherwise the code repetition will be high

These sounds like candidates for i2c-designware-lib.c, indeed.
But the rest most likely shouldn't be intervened at all. I.o.w.
please provide a detailed analysis (something like [1]) in
the cover letter, or just send an RFC on the driver design
before even starting considering actual coding.

> Hope I can answer your question, thank you

[1]: e539f435cb9c ("spi: dw: Add support for DesignWare DWC_ssi")


-- 
With Best Regards,
Andy Shevchenko


