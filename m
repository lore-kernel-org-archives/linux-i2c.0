Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3E332615;
	Mon, 18 May 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114482; cv=none; b=Q2mgP3kNPRv3bdyjg7OMtSLrhigqaIkIeCcZrCusjvOKMTIJuMN7In53WId0vtnPUr/h5BCvNZ1nNjnwLFeaoh5Yklm1fWMoQoPcth4MiCITxJwIbC+rANgXbHkRqsOQJJgaVpbtsVvYEc70vT0otT44jvL9DF76GILBjt6pyYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114482; c=relaxed/simple;
	bh=0bx3o3+vpBpa60JgaKzfKh3XfYsWOTddwsaMmYG6x7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlynLNfOnOLpOzZjVp9lDxeblmla22dHx6kRI3bcK3IQ7Ld2EUCjZJ1IOk3ut+Ga800JhWNfbfckfrvLkpDqV0NwlCYr1ov6rvIx94Q+Yn7IkPggxaYHPpCDppnj0hvmlmZFQwiePEsb/0E9T8rWik2sfP61j2ZJeLcPgOoMMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNKXW1sp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNKXW1sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779114480; x=1810650480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0bx3o3+vpBpa60JgaKzfKh3XfYsWOTddwsaMmYG6x7w=;
  b=LNKXW1sp7H0aTWPEMArmg6nxiSMu45hmEwwHKghBaYUK5h8sKEnL6Huh
   eYcbNdK6sqOnLErvJETvHe7HYBu82ue+79nu9fXKMKmOWS8T4kEPRVtb3
   JkP63/Wa+Zt+zt+76zf9M0q9/zqWDDS8gHdFDikm+qcl9qgOMGXktDkh+
   c0MIodkUM2ttPvnO1ed2O9CfNpqTdLhdAiAe7+mR/8Eol9mS3y4NB6s6A
   QEmXTAQRCnQEApankFiHWCQT6KAXevhAK/EzH+ROZMFUnUqAxSwOOPiNy
   Xwp7I51UDzq034ctkUl4hoJOwo/uvEyEyO46B7Z44ZhgY9w5oW9RfZ7+t
   Q==;
X-CSE-ConnectionGUID: EC0n82cPTeuP8DyJPREJMQ==
X-CSE-MsgGUID: /pnSe6oZT7eX5C3+xWoM3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79106931"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="79106931"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 07:28:00 -0700
X-CSE-ConnectionGUID: a5A8CawHS9uyE0ScX1ZBtw==
X-CSE-MsgGUID: Q20CDUz3QMC0C1mYZ64JdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="236812387"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 07:27:58 -0700
Date: Mon, 18 May 2026 17:27:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	wsa@kernel.org, basavaraj.natikar@amd.com, linus.walleij@linaro.org
Subject: Re: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
Message-ID: <agsh652HlC4rg1_1@ashevche-desk.local>
References: <20260518122814.8975-1-hardikprakash.official@gmail.com>
 <d57dd297-6be1-43a9-a38d-e40c8949e23a@amd.com>
 <CANTFpSWGC7GsAY-3UvPtBZzqjNek-T5haiDb59QYRoRgwuQf1w@mail.gmail.com>
 <7d0f0cf9-1936-4cf6-a425-228a37f83137@amd.com>
 <CAMRc=MdS_BVKb=FQLhky=8dpghBSoHeBhUk0LM5hROFxmJeyGQ@mail.gmail.com>
 <9d5da93e-bbe0-4359-9f17-e3c6b3a5cb34@amd.com>
 <CAMRc=MfT_WVMxPnYZW=mg52PHew0O4VQMGFrfo6G9vxZDDoArw@mail.gmail.com>
 <CANTFpSUX5rYhuTQH3dTTvzW+_yhW8Gs0U=A1t_8LDzKz4dzzAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANTFpSUX5rYhuTQH3dTTvzW+_yhW8Gs0U=A1t_8LDzKz4dzzAw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 18, 2026 at 07:53:28PM +0530, Hardik Prakash wrote:
> On Mon, May 18, 2026 at 19:35, Bartosz Golaszewski wrote:
> > What is blocking the pinctrl driver from probing? Does it return
> > -EPROBE_DEFER for some reason? Pin control core is ready at
> > core_initcall() so it should work in theory.
> 
> On Mon, May 18, 2026 at 19:16, Mario Limonciello wrote:
> > Please try arch_initcall instead.
> 
> Tested arch_initcall + patch 1. GPIO 157 now fires at 0.255s (earlier
> than any previous boot), but arbitration errors still occur at 2.309s:
> 
>   subsys_initcall + patch 1:   GPIO 157 at ~0.310s, arbitration errors
>   arch_initcall + patch 1:     GPIO 157 at ~0.255s, arbitration errors
>   patch 1 + patch 2 (v5):     no arbitration errors, touchscreen works
> 
> The driver is not returning -EPROBE_DEFER. The problem is that
> amd_gpio_probe() hasn't completed by the time i2c_designware fires,
> even with arch_initcall. Promoting the initcall level gets the driver
> registered earlier, but probe itself takes time, and i2c_designware
> catches it mid-probe regardless of registration timing.
> 
> This is why device_is_bound() works where initcall promotion does not
> — it waits for probe completion, not just driver registration.

The alternative solution is to have a registered notifier for the device in
question. But not sure if it will be less-invasive than given solution.

> On Mon, 18 May 2026 at 19:41, Bartosz Golaszewski <brgl@kernel.org> wrote:
> > On Mon, May 18, 2026 at 4:08 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > > On 5/18/26 09:05, Bartosz Golaszewski wrote:
> > > > On Mon, May 18, 2026 at 3:46 PM Mario Limonciello
> > > > <mario.limonciello@amd.com> wrote:
> > > >> On 5/18/26 08:40, Hardik Prakash wrote:
> > > >>> On Mon, May 18, 2026 at 18:17, Mario Limonciello wrote:
> > > >>>> I'd still like to avoid a quirk if we can.
> > > >>>>
> > > >>>> I know my proposed patch to try to probe at an earlier stage didn't
> > > >>>> work, but could you perhaps try pulling pinctrl-amd even earlier?
> > > >>>>
> > > >>>> Maybe fs_initcall()?
> > > >>>
> > > >>> Tested. fs_initcall + patch 1 still produces the same arbitration
> > > >>> errors:
> > > >>>
> > > >>>     subsys_initcall + patch 1:   arbitration errors persist
> > > >>>     fs_initcall + patch 1:       arbitration errors persist
> > > >>>     patch 1 + patch 2 (v5):     clean boot, touchscreen fully functional
> > > >>>
> > > >>> The initcall level does not appear to be the determining factor on
> > > >>> this hardware. i2c_designware is still probing AMDI0010:02 before
> > > >>> pinctrl-amd finishes regardless of how early pinctrl-amd registers.
> > > >>> The explicit device_is_bound() deferral in patch 2 is the only
> > > >>> approach that has worked.
> > > >>
> > > >> Please try arch_initcall instead.
> > > >
> > > > What is blocking the pinctrl driver from probing? Does it return
> > > > -EPROBE_DEFER for some reason? Pin control core is ready at
> > > > core_initcall() so it should work in theory.
> > >
> > > Currently it's module_platform_driver() IE device_initcall().
> > >
> > > That's why I think we "should" be able to move it a lot earlier.
> >
> > I mean with fs_initcall() change - what's blocking it now?

-- 
With Best Regards,
Andy Shevchenko


