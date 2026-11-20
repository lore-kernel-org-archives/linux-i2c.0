Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159170;
	b=AHkQMXQRGJaPLEhzczA7JXO2288GRHfHKA78EwEh+N4ylW7W2xCnmym/OdQvfsz69S7g
	 Ow9eU5q5TmBvZRKiT1SHjQKmDSsP5h7kFqPpUep8UOWKBpzjlsiHr9eKYQjfzawbIGUve
	 HZHad7trj6myoFyBmnrj1dRZ67XCYQ7HPxQccKhJLDTVOKORlIFDJ1sN5xIR3pAnnjax7
	 Fn0uMzZMwUOlHN+qUaMF6cx4YFwcJbJhi2HOw+vogP3XycpVYiXPv61mkA877A1+WUcPO
	 1mOzrM9kX8edn4SREMGMqVmqqpQBMhbuWwXp76lW4nPzPUE6tKqgvw0sVZmi/zL+zbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159170;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=UCkJVInVpe45tTPUC1N8YCSud4itWnhph5HOVXhfzDc=;
	b=ytvln8dA9YoNP7Ot7BUizTEdJw8F1/p6l09afI8ImAq/neSQaLbBTq2wzd9WHzhsgpN8
	 Rwf4gVPoZDCiMoCkyAQapRlL58/0yvdl5JPp/6xPBCN2jxoAhFZpgnrzsyhXlpmmP9+yW
	 ISUpiyplC7jEd6yciMoIY8suitiKE4mqtUZuvZnqRab+rnXO1CKRcL2ivYTPMRiPrMuZT
	 N5dk+rP8/U+eJKRUzP97GOQeXoxTEdlJ9u7W1cyt8B19NlRlTF6lDNaflb3vTgUdsdTSy
	 9AvZfyDtII9b6R7UHqeMzZDAXDi9v9AYKCd/dzeGC/6K4q/gt1m9adTqObAkm/QFHrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TulpEHln;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C531606A325;
	Fri, 20 Nov 2026 07:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C531606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TulpEHln
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795159170; x=1826695170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pukM0lbVTsObyCpMsg2GVxDX11Bwhn6NE596KFaKpts=;
  b=TulpEHln4sJpyN4zXJABHLTsyJlCaU69qgztsfq2AF8PGCIUti+KC0d+
   XULog541WM2atSAjRbmwiTvAXhGDfneHoZ7PYphEl95AiBIACa3jPPpgZ
   xGQXrqvloxiPjYmeTJzWBl7L48TqEzCvTBwJGLyHj9ufYtsCt/BTWQoLM
   efxouErEtF2BHYnoSz0f6ddZpr3limipRZMHgVXObnVK/M5HCPtwNKK2d
   OIeV1GUWqu5Cbvm4hQfp16BEgEuuUC/q6EZrDoA5q7gqluzJBYi5dQcrl
   taQ27o1DpWHiovkZ3BYw5yvsumsFHhSxblc9xSZyQKCVE+w/LJ03kz7Lo
   g==;
X-CSE-ConnectionGUID: UBM5oMpVSVGVtQYmxszYKw==
X-CSE-MsgGUID: FG+u3SIIRrOgdAu98OBXDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4065613"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4065613"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 23:19:29 -0800
X-CSE-ConnectionGUID: EwKkfr+qRTmS5uNY0L8ULw==
X-CSE-MsgGUID: 19Ch2pzcQA6XqOrjY5dy/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10633239"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 19 Nov 2026 23:19:26 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F24FD99; Fri, 20 Nov 2026 08:19:24 +0100 (CET)
Date: Fri, 20 Nov 2026 08:19:24 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"fangzhong.zhou" <myth5@myth5.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Dell.Client.Kernel@dell.com, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Limit DLL0945 100 kHz quirk to Dell Precision
 5560 and XPS 15 9510
Message-ID: <20261120071924.GI229695@black.igk.intel.com>
References: <20261119143218.586632-2-pmenzel@molgen.mpg.de>
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
In-Reply-To: <20261119143218.586632-2-pmenzel@molgen.mpg.de>

Hi,

On Thu, Nov 19, 2026 at 03:32:16PM +0100, Paul Menzel wrote:
> Commit 0b7c9528facd ("i2c: Force DLL0945 touchpad i2c freq to 100khz")
> forces the I2C bus to 100 kHz for all devices with the ACPI ID DLL0945 to
> work around a sluggish cursor on the Dell Precision 5560. But DLL0945 does
> not identify a touchpad model. Dell uses it for touchpads from different
> vendors:
> 
>     System                Touchpad
>     Dell Precision 5560   ELAN 04F3:311C
>     Dell XPS 15 9510      ELAN 04F3:311C (bugzilla #214597)
>     Dell XPS 13 9310      Synaptics 06CB:CDE6
> 
> The ELAN touchpads are the ones known to need 100 kHz, but the Synaptics
> touchpad of the Dell XPS 13 9310 is slowed down without need. Its DSDT
> specifies 400 kHz, and Linux logs:
> 
>     i2c_designware i2c_designware.0: [Firmware Bug]: DSDT uses known not-working I2C bus speed 400000, forcing it to 100000
> 
> The touchpad scans every 7.1 ms (scan time field in the input report), and
> i2c-hid reads wMaxInputLength (64 bytes) for each report. Tracing the I2C
> transfers for 30 seconds of moving a finger on the touchpad shows:
> 
>                              100 kHz   400 kHz
>     read time (median)        7.3 ms    2.5 ms
>     bus busy                   87 %      36 %
>     reports per second          111       140
>     frames lost                18.6 %     0 %
> 
> At 100 kHz the host cannot keep up with the touchpad, and every fifth frame
> is lost. At 400 kHz all frames arrive, and no sluggish cursor was noticed.
> 
> So, only apply the DLL0945 entry on the Dell Precision 5560 and XPS 15 9510
> by pointing the entry's driver_data to a DMI table, which can be used to
> restrict other entries in the same way.

Yeah, we should really figure out how this works in Windows. I'm sure they
don't have such a quirk list so maybe it's up to the vendor specific
drivers to "tune" the bus to their needs whereas in Linux we obey the ACPI
description.

> Tested on the Dell XPS 13 9310.
> 
> - The `[Firmware Bug] … forcing it to 100000` line is gone from dmesg.
> - Re-probed the touchpad’s I²C controller with debug output on, and it
>   reports `Bus speed: Fast Mode (400 kHz)`. The touchpad came back up
>   under hid-multitouch.
> 
> Fixes: 0b7c9528facd ("i2c: Force DLL0945 touchpad i2c freq to 100khz")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214597
> Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>
> Cc: Dell.Client.Kernel@dell.com
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Acked-by: Mika Westerberg (Intel) <westeri@kernel.org>
