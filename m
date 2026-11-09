Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221147;
	b=UVscejRxEoYxREDYsDIOZoDy1azQPsBb2nCS+UB1VAd26hphTwNcLLcZm6SmIF9gGhWK
	 f9HcpbXQuKWJgh1q6oNi5kA79PdCBbVDn4ECJQPLk7C/O3/rIkQmaA7bzsCJ+kt8+yLN1
	 3kTPX4wp/XE4imJ8nwdXjOdsHZAVQeYNROm9rdAosCQIu9drKEtWkG7Wr0JvNmrEwIKEp
	 MmzpEZAW6SyPnA/UQoQUYbiVU/TfnJJD+UizSUxcVhNqcjSgLdxJnBhirzcLlwJyNe+bG
	 ERTTa6oX7zSLSYjKeMqQo+zpYgxCj6rtLTZ4esAlf4dOoaLOvFOex3q707BTR1V4dQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221147;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=nl+/KralOh+dGROnNTooIdasnREF4uPn5x3o1Ua7Igc=;
	b=2Tn+ACMUNmBKXNYZTlS704WYvbU1bkSJ42lGY7d2u/vQP+xJrBcF8FMJtEmAvSJSArDE
	 nM9cPvoXVU0nWYFGNkfjeylyqE7aQncnMry9dLK8nKujIv4+Yrl0+cb0iZ7D4gTU7QYPl
	 6SoXNtGRLai3rH/kcYj6mcZFOApIYAbtVmMfUGSmQ+PZ4SJm7Mz/sXHmr0KiVOfs4HLjX
	 ZKXutjvwP1fizVaNyKHfzpYHS80xbzrr9J8Z58OTRoNdVH0merIW2fDmGwxG3TN8CuePy
	 B9gDHyx22+1kgPpUjpuII+ixmxRNLHEG9pkgXmh7pf5vh/6C09YXAGpbs8KTi9y4x9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nEBBO2wO;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C70606A31C;
	Mon,  9 Nov 2026 10:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4C70606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nEBBO2wO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794221145; x=1825757145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YVRlamkkZSozoLLTh5QkHe05MxLIm7RB7e8eWyXUKzg=;
  b=nEBBO2wO+hlcPRE20lRKMoFJYF0njezqwL06BbqD32T8Mc1+kg+s1kXo
   FHYEEQz3eXHxSU8U0Vf7Viqf8AItAjEB1dAhqxN6PhdRdjrYF2u6eijD1
   jUc/xL2ZMN9WD2XyfwhmicxlM9I/lsFYCqx/dD9q4otbdYI3EoFxLt06k
   3dPCwGG8Et+70kGCPA+i6i91q2rVo+jRq8DYEQqcji6xOUU71MsE+Qovj
   p+ZG8gmZ6KpOuUdpjLrVvYyGgTzvGUGXljedOSeczx4uBq6rm2c9Isgfd
   U3exYI0dhII5lraGqdIeQT4dDiSxWc+76lFBE7yC/V4F1ZCcDkS0CbRvD
   w==;
X-CSE-ConnectionGUID: blaZpK8wTDiPEmWwqPm8aQ==
X-CSE-MsgGUID: M8+hGPvJQXCZMD+0fNX5GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2979102"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2979102"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 02:45:45 -0800
X-CSE-ConnectionGUID: FTtmwNsNTFSGqLCPz16Y9A==
X-CSE-MsgGUID: EVqy3W1nQDGL9YDZgIKh9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8174231"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 09 Nov 2026 02:45:44 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A7BC199; Mon, 09 Nov 2026 11:45:42 +0100 (CET)
Date: Mon, 9 Nov 2026 11:45:42 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: penhouse24@proton.me
Cc: "westeri@kernel.org" <westeri@kernel.org>,
	"andi.shyti@kernel.org" <andi.shyti@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [BUG] i2c: acpi: Dell XPS 17 9720 ELAN 04F3:311C touchpad
 (VEN_04F3) needs 100 kHz like DLL0945
Message-ID: <20261109104542.GL176724@black.igk.intel.com>
References: <CYQ1dYF3ZUj0L_VRzN490SfuHRaulkT_y5NWcIEIl8OtpIgWgXyOlwEyUqZD_uz9bmVBXM2uLOo8bkyzcR-qCxNObstCqFUlK6lUYXK5euE=@proton.me>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CYQ1dYF3ZUj0L_VRzN490SfuHRaulkT_y5NWcIEIl8OtpIgWgXyOlwEyUqZD_uz9bmVBXM2uLOo8bkyzcR-qCxNObstCqFUlK6lUYXK5euE=@proton.me>

Hi,

On Fri, Nov 06, 2026 at 05:48:02PM +0000, penhouse24@proton.me wrote:
> Hi Mika, Andi,
> 
> The ELAN 04F3:311C touchpad in the Dell XPS 17 9720 intermittently becomes
> sluggish and sticky for several seconds to minutes, then recovers. I dual boot
> with Windows and I do not experience this issue on Windows, only on Linux and
> across multiple distros (Linux mint, Ubuntu and Pop_os). I'm not the only one
> who experiences this issue; it seems to be widespread among Dell XPS users.
> This looks like the excessive-smoothing issue fixed for the Precision 5560 by
> commit 0b7c9528facd (“i2c: Force DLL0945 touchpad i2c freq to 100khz”). The
> Precision 5560 uses the same 04F3:311C touchpad. On the XPS 17 9720, the
> firmware exposes it with _HID “VEN_04F3” instead of “DLL0945”, so the existing
> quirk doesn’t apply.
> 
> Forcing the bus to 100 kHz fixes it here. The DSDT already supports 100 kHz:
> _SB.PC00.I2C1.TPD0._INI sets SPED from the TPDS NVS variable (0 = 100 kHz, 1 =
> 400 kHz, 2 = 1 MHz), and this firmware uses TPDS = 1. To test it, I loaded an
> SSDT through configfs that sets _SB.PC00.I2C1.TPD0.SPED = 0x186A0 and rebound
> i2c_designware.1. After 5 days of use, including on AC power, the lag has not
> come back. Without the override, it returns as randomly as before. 
> 
> System:
> 
>   • Dell XPS 17 9720, BIOS 1.41.0
>   • Touchpad: VEN_04F3:00 04F3:311C on i2c_designware.1 (_SB.PC00.I2C1.TPD0),
>     touchpad firmware 0x000b
>   • Kernel: 7.2.15-76070215-generic
> 
> Adding “VEN_04F3” to i2c_acpi_force_100khz_device_ids would fix this machine.
> However, VEN_04F3 looks like a generic vendor ID rather than a model-specific
> one like DLL0945, so it may need to be limited to this model with a DMI match.
> I’m happy to test a patch.

That VEN_04F3 is not even a valid ACPI/PNP ID. Have you checked if there is
a BIOS upgrade for your system?

It's odd that Dell would use identifier like this as they typically follow
these pretty well. Anyways if there is no BIOS upgrade (or if it does not
change anything) then I don't see much other option than adding a quirk. I
do see there is one quirk added already for GPIO side on Dell system with
VEN_0488 entry (drivers/gpio/gpiolib-acpi-quirks.c).

In that case we would need output of 'sudo dmidecode' to be able to add the
DMI strings.
