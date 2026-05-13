Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381263955CF;
	Wed, 13 May 2026 04:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648128; cv=none; b=jWRlMMOxT4XXdsD9bB8ilDkJo2egzRJJMXS+NgSrnR3l3ffZxEp8RsPiyoBt2aih26FLQk8/N3M7T/9jhKj8dU1qkiEzXSB/0DRC7WoUO8fnjbcUjuGFdiwGRvCzjPG7y/9sj4yVR4JjSYInM/2rhvyvXWahF5CSHN1ZJ+VZ23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648128; c=relaxed/simple;
	bh=c2xTnTzkyzBGw2ozDRDzC6y/qz/0wJKDkOMCKy4LZJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfHwZ7X5O7QqQ7mJ3pzM80FpZXS/c80Ipae+AJ+CxOVJL/xDhR702St4mO9L4QHhOXNFuInH4pEQHQAGw39qsBcU+3BN76//m4bZvBR/GFEX7IY/dpPPkms8OTpH9mMD5A9JIBn8xzZUDwnECmwyMzPf1myBZ5MeF7WregjdHTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4ST8cDo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4ST8cDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778648126; x=1810184126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=c2xTnTzkyzBGw2ozDRDzC6y/qz/0wJKDkOMCKy4LZJs=;
  b=l4ST8cDoVYNlr09mhqW78vB3pECRHAWoutl4mztDkSHKLw0rPTcUwQYl
   P8b/v/EFs3uWFj7FbxX5iFa2DRCQt2NEZLRYjbkIKhi1uupDcCJan+6cQ
   ZiB/GHrDPH90pJb6N9I49AjwML9T/XtLrhviFHoyrTRGWCIoHeGGYGojm
   D66RL/XcQX5Z4KXtKQNZ8p3mi29F8VXQQZliGI4xWAxHhC2V8mvLhxB0v
   6nR7tu2tWfvZOqA02d6LRy7L8AdG8bH+MxPFFKOIYDypNBNGgy44ka49B
   N4Mjj7cyKj2XKhGTYZ6gwab0HF9jMnutpvSNTiNgcEr4AbEJR9nqq5ymK
   Q==;
X-CSE-ConnectionGUID: kHD6yRbHSHarN4zx9ok78w==
X-CSE-MsgGUID: duhmR6Z+RE6k4PQCjA01fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="67096195"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="67096195"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 21:55:24 -0700
X-CSE-ConnectionGUID: GF/zgovUQPS73lh5i0rZaA==
X-CSE-MsgGUID: 8z8lBThQS+e48YzOt9t5aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="268313952"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 12 May 2026 21:55:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 74F9695; Wed, 13 May 2026 06:55:20 +0200 (CEST)
Date: Wed, 13 May 2026 06:55:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Odoben <odoben@flipperpa.ws>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Niels Franke <nielsfranke@gmail.com>, westeri@kernel.org,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Add ELAN0678 to
 i2c_acpi_force_100khz_device_ids
Message-ID: <20260513045520.GF84797@black.igk.intel.com>
References: <20260418053719.15766-1-nielsfranke@gmail.com>
 <afhkiGREdd50vYNN@ninjato>
 <1453fe0d-230c-4655-93ad-3f685b8ab713@flipperpa.ws>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1453fe0d-230c-4655-93ad-3f685b8ab713@flipperpa.ws>

Hi,

On Tue, May 12, 2026 at 11:36:26PM +0200, Odoben wrote:
> Hi,
> 
> I have what appears to be the same issue on a ThinkPad X13 Gen 2 with
> Intel i5-1145G7, but with ACPI HID ELAN0676 instead of ELAN0678.
> 
> The touchpad is:
> 
> ELAN0676:00 04F3:3195 Touchpad
> 
> libinput reports:
> 
> Id: i2c:04f3:3195
> 
> dmesg shows:
> 
> i2c_designware.0 -> i2c-ELAN0676:00 -> hid-multitouch
> 
> The ACPI table contains:
> 
> Package (0x06)
> {
> 0x04F3,
> 0x3195,
> 0x15,
> One,
> One,
> "ELAN0676"
> }
> 
> and the surrounding firmware logic maps the fifth field to speed:
> 
> Local5 == Zero -> SPED = 0x000186A0 = 100 kHz
> Local5 == One -> SPED = 0x00061A80 = 400 kHz
> 
> So this machine also configures the 04F3:3195 ELAN touchpad at 400 kHz. The
> symptom is very frequent rubbery/sluggish pointer movement, consistent with
> the excessive smoothing described for ELAN0678.
> 
> Would it make sense to include ELAN0676 in the
> same i2c_acpi_force_100khz_device_ids quirk?

Did you try 100Hz and it made the problem go away? In that case yes it
makes sense to add the quirk.
