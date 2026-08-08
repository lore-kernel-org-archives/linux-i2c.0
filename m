Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A58306D2A;
	Sat,  8 Aug 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786220741; cv=none; b=iQdLePvZ4FuBftAJ6F8wiAqRbt+0Ze9HOnuL9N3TpRGUkwOdyMp36eRfbvx9FJMY15vnU+TfWiNSTAx1W9LTg3neE5JRBpWvhn5bCtQYuOfTmocdw7jHXbrtNGFuC0WOL6neqz0o8YGobW3+ZZdUuOK9YxLfMlPDbCzWiqCTW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786220741; c=relaxed/simple;
	bh=Ekdwg4c4KafmDiLEhSwzoAhPssdwN8TEhYtmp026hN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiDxbClfsdfImeq3kLDc2UN2InZLhmX0HzjX3J7x0MoEX4mDZddDiUn0bwfU/9YuIMWBIjXnP742kV2GOH79Jc38WAXtufKUXhrUAI4yjwjnkeVaCIqa37PDQb9rscUpmRnFLtDkHoG1B5xjQpnEd23G6zly1oxBJWnpiS90xZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZUf/omR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZUf/omR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786220739; x=1817756739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ekdwg4c4KafmDiLEhSwzoAhPssdwN8TEhYtmp026hN4=;
  b=bZUf/omRevV9VbhNCGCkaj3gruVuaqudb0lV0TbwNLs4HxMSohx2s52/
   0NR3eeXrmzzwYWVHfczhKkB7n41eA0haS+D6EWz+w1jhH1qZ+/etbbx7G
   i4bn1YJQIA2UrrMh53LS1ksOjMu2wBAFeodSV6rOA4R1+u7WqDvYN7dlI
   RJNgEhwCKD3mydgaQTmJtI0SwtQ3kRqDNVCOtALSa17wjTB/x2nZ660nn
   RHqmZiTX91wTZOAorni+YNflVAXbasYfzfoJAG+I1iqkfwYW+iIvvqLR4
   tZx7TRwSBNg6UqzN2+6aoGCKT/VtXvxhTp0gfB4lmMz6QUk9QgFWG7TLx
   g==;
X-CSE-ConnectionGUID: O1wGlyb9T92jbvE8jF0CJQ==
X-CSE-MsgGUID: Op8X8SRSSMOnrDP2zSmmVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="98155372"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="98155372"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:25:38 -0700
X-CSE-ConnectionGUID: weSY3ktxTICZnBd2xVSvjg==
X-CSE-MsgGUID: M4ApHUEFTsSeI90zVI56ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="264667361"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:25:35 -0700
Date: Sat, 8 Aug 2026 23:25:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: Thorsten Leemhuis <linux@leemhuis.info>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org, wsa@kernel.org,
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com,
	linusw@kernel.org, nathan@kernel.org,
	chaitanya.kumar.borah@intel.com,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: i2c designware change broke touchpad of a thinkpad (was: i2c:
 designware: defer probe if child GpioInt controllers are not bound)
Message-ID: <aneQvMN_Zet2b62n@ashevche-desk.local>
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
 <amhodWpAI3K6aeBH@zenone.zhora.eu>
 <b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info>
 <CANTFpSW+w1GZMbLXszuqZFCZjeVJfFG2bc1vJad+OMzsy-CPCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANTFpSW+w1GZMbLXszuqZFCZjeVJfFG2bc1vJad+OMzsy-CPCg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 08, 2026 at 10:31:28PM +0530, Hardik Prakash wrote:
> On Fri, 7 Aug 2026, Thorsten Leemhuis wrote:
> > This became 0a4bb2abc3e56d ("i2c: designware: defer probe if child
> > GpioInt controllers are not bound") and causes a regression for me: the
> > Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working. From the
> > kernel log:
> >
> > i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
> > i2c_designware AMDI0010:01: controller timed out
> > i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID descriptor: -110
> > i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID Descriptor
> >
> > Reverting this change in current mainline/master (f9a2394a23482) fixed
> > things for me. Full dmesg of current master and master+revert can be
> > found here:
> >
> > https://www.leemhuis.info/files/misc/dmesg-master
> > https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
> 
> Thanks for the report and both dmesg dumps, that's very helpful. Comparing
> the two: the working log shows SYNA8018:00 probing cleanly around 2.33s
> with no GPIO-related activity, while the broken log hits lost arbitration
> on AMDI0010:01 at almost the same timestamp. Neither log has dynamic debug
> enabled for the relevant code paths, so I can't yet tell what my dependency
> check actually decided for AMDI0010:01's children on your machine.
> 
> Two things that would help narrow this down, whenever you have a moment:
> 
> 1. A DSDT dump, to see what GpioInt resource (if any) AMDI0010:01's
>    children declare, and what it points to:
> 
>    sudo cat /sys/firmware/acpi/tables/DSDT > dsdt.dat
>    iasl -d dsdt.dat

Side note: It is better to collect with `acpidump -o tables.dat`, then
`acpixtract tables.dat` followed by `iasl -d dsdt.dat`

>    The resulting dsdt.dsl, or just the section under AMDI0010:01, should
>    help.
> 
> 2. A dmesg with dynamic debug from a kernel built with the attached
>    patch on top of current mainline/master (adds pr_info() tracing to
>    the exact decision path, no functional changes):
> 
>    dmesg | grep i2c-dw-gpio-dbg
> 
> Both together should tell us whether the dependency check is finding a
> GpioInt resource on your hardware and mishandling it, or whether
> something else is going on. Appreciate you taking the time.

> On Fri, 7 Aug 2026 at 19:37, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> > On 7/28/26 10:30, Andi Shyti wrote:
> > > On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash wrote:
> > >> I2C controllers may have child devices with GpioInt resources that
> > >> depend on GPIO controllers being fully initialized. If the I2C
> > >> controller probes and enumerates children before the referenced GPIO
> > >> controller has completed probe, GPIO interrupts may not be properly
> > >> configured, leading to device failures.
> > >>
> > >> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> > >> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> > >> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> > >> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> > >> fail with lost arbitration errors:
> > >>
> > >>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> > >>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> > >>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> > >>   2.348157  lost arbitration
> > >>
> > >> Add a dependency check that walks ACPI child devices and defers probe
> > >> until any referenced GPIO controller is bound.

[...]

> > #regzbot introduced: 0a4bb2abc3e56d
> > #regzbot title i2c: designware: ThinkPad touchpad broke

-- 
With Best Regards,
Andy Shevchenko


