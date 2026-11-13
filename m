Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559115;
	b=qX2MhLLKOmVfc3PSrdztnoDadeYwec6/ivt7R+5gMXHa2BU12OYXh7wvXgS69E7m25Kr
	 LBCCfhyhVMZb/sOYjjTGJKMGLxTFZEY5OIPd67tIDluYEhNIkHFJOORJVkh+zPJvnDlVV
	 3wLdK0rPLfzkz1u0D7b8i5ro0DtjnfF0n7p4teytMVUlhRyC2gk+Ie6MHRmQomI9g63lv
	 qCb8D5J9YkDBuncLoJ4vdRxvtN6JlirY2yAKPK/F+dXUStij01ovg3bN05uIt7bqtmIZL
	 vZWEpBJw8PJB1dLJvqVgh7qKZvoC9Xt2r6Vr6/SpBqtfBsLiwhY9KoBSPcbzmFWN5aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559115;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=jJPPmrgHvFi7FJRmblAVYAxltGeBo3M3QF8JnKerhoQ=;
	b=5E/mpiLYnPAVIGtLXj3tzVol9EiLGa2ks+W6VUp42++LbBkHliZ/E5Yao8EXTrqVOqCU
	 SRKFmYOYaclOciONZE+l2Vsx43nFOmdAZWS2lgR4veaJynpfOU/yXuSQFCIfRGZIXW4i/
	 CTs3XCM/UKf4Xws8k8+cgSCoUOo2XgNeUi8xEZZIIIlhACrBZmTwvyqu3uj+WK46kE2A4
	 hPZ6T5T2kFIJSE1cTyBJ4iAumZjUT2qSqHmr59kqJoEFoUphHMyTO2xGPTdJDdOrJ50dS
	 hcPdJZEnZTkSC46slkkcOZ2JQD49J2SvErOKhlVBF6sEvBT08xf78oiiUUajXK8b+tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dL7mxt7t;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE5606A31C;
	Fri, 13 Nov 2026 08:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EAE5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dL7mxt7t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794559114; x=1826095114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=THoWPqTSk5fnke7XCzT4M9s/J2ey2Lfhv5W+Bhz1vIs=;
  b=dL7mxt7tuNBbuksC+4Bc5pMyHnX7B8Cyu0/QvlwFGv/M0tprXHIa9PEj
   QFhNfHLOm8QBTL6YI8Du+8W6uKX84W+8lFl2TrNByG2SDr8ZXPKMBbvez
   /WWvAOZpbBP+Qd/5J9/ixz0CtJrzyEPoxUkahYjMKLH0YDN2NoBD4aTY0
   +BJM5tT54Nr+kdHyoVakKTn7H8SA+y2dvOW37TRMpNl2JYDEh/2/OhT9W
   pANp3MpnBcgEah8cRgF8rysHJ7br66sCSdH4/mLoDQIkMBaYMUid5ZdXv
   FKF/+/IuSSUyI3f4iHlfC8Sato7KLZPsbPazBpY+7iqhJ3msi6OvWrp7s
   g==;
X-CSE-ConnectionGUID: Zwm6ywuVRNCOXEFKWYnOnw==
X-CSE-MsgGUID: kp/4MkiXRJe56AOmMmRA+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3259457"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3259457"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 00:38:34 -0800
X-CSE-ConnectionGUID: yySeRgJ4Q0yBYjW850LAuw==
X-CSE-MsgGUID: hjfjjnXYTeKaSwXOOgKsCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8890186"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 13 Nov 2026 00:38:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D59BF99; Fri, 13 Nov 2026 09:38:30 +0100 (CET)
Date: Fri, 13 Nov 2026 09:38:30 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: penhouse24@proton.me
Cc: "westeri@kernel.org" <westeri@kernel.org>,
	"andi.shyti@kernel.org" <andi.shyti@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [BUG] i2c: acpi: Dell XPS 17 9720 ELAN 04F3:311C touchpad
 (VEN_04F3) needs 100 kHz like DLL0945
Message-ID: <20261113083830.GP259790@black.igk.intel.com>
References: <CYQ1dYF3ZUj0L_VRzN490SfuHRaulkT_y5NWcIEIl8OtpIgWgXyOlwEyUqZD_uz9bmVBXM2uLOo8bkyzcR-qCxNObstCqFUlK6lUYXK5euE=@proton.me>
 <20261109104542.GL176724@black.igk.intel.com>
 <lGd7ChJVtwyvhMVkRinryqLG3Lx32U7xoSjT4_inKH1pBNoAd4dvBKV1A4i9MOIVLKmgx8sVg98gfK-iUwb5Uoy0wX1CM2_c7I1vdTr2tYU=@proton.me>
 <20261111075931.GG259790@black.igk.intel.com>
 <iZI_luLf6KPDE7sZSzG-aRF3V1fJFh7moD99YLp6nXVGLKgHTGMY_fnseRx1glU4YXGKNN3zKxSkitJW1MxfxR8WWGb1fegxZnOmq4VArTo=@proton.me>
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
In-Reply-To: <iZI_luLf6KPDE7sZSzG-aRF3V1fJFh7moD99YLp6nXVGLKgHTGMY_fnseRx1glU4YXGKNN3zKxSkitJW1MxfxR8WWGb1fegxZnOmq4VArTo=@proton.me>

Hi,

On Thu, Nov 12, 2026 at 02:18:35AM +0000, penhouse24@proton.me wrote:
> Hi Mika, 
> 
> 
> Tested on top of v7.4-rc2 (067c5c24cef2) on a Dell XPS 17 9720, BIOS 1.41.0, without the SSDT override.
> 
> The quirk is applied at boot.
> 
> I've been using my laptop all day and the touchpad lag has not come back so far including on AC power. On the unpatched kernel it returns as before.

Thanks for testing!

> Interestingly enough, I did use an off-brand AC charger for my laptop and the touchpad lag returned on the patched and unpatched Linux kernels AND Windows. When I used the Dell AC charger, the lag was gone on the patched kernel and Windows, but remained on the unpatched kernel. Perhaps the root cause of this problem, on Linux relative to Windows is that Windows aggressively filters noise without smoothing? Not sure, just a thought

Indeed it can very well be. Someone should really investigate this properly
by hooking I2C analyzer to the bus to see what is going on there. However,
that is not trivial to do with form factor devices.

> One question about the DMI match: does it need DMI_BIOS_VERSION? The VEN_04F3 ID check already makes the quirk stop applying if a future BIOS switches to a proper ACPI ID. The 400 kHz problem also seems to be in the touchpad itself, since the same 04F3:311C part is affected on the Precision 5560. Matching only on sys_vendor and product_name would also cover users on older BIOS versions, and any newer BIOS that still reports VEN_04F3.
> 
> Dell also ships the same BIOS image for the Precision 5770, so it likely exposes the same ID, though I can't test that model.

I agree we can drop the BIOS version. I will send the updated patch soon.
