Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572555;
	b=hy8ezxJGodm+pCK6Kyw/oa1HYoScAY7/K/fwJijFxeczQImVrYArfZhkt5kGQVGhndvx
	 DMI7j7czQ0MoZVnJgwbgoG4sNz0IM0yWOxD8I0VoVR8EvMqmC4MtnOkVL6Bi4ViJXWYbz
	 GgVtOnzI0d4JjNnddq/vpeMM3CrlChjZq7rc2B9ZUP8SIg8a6eSTbdhTV3uJQH18qUZF2
	 NIQthJFZLTYi7bxwP9CRhbhhq9anmBViGSQqvD3nWfAjiZW5ztru7KjlWEvGZzxyydMPf
	 0G7jcMdmf0JDoE3ir8W8s2y5yO0xgrqQMKWCvL1sbN2kswqwZAVKqRsUQCZNmpLIBIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572555;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=F5Otla5cFQ/Z0Yu7+4RO/9Y7ncokf5V6Lb9ISWKcpvs=;
	b=Q309/EDCsBBYqwtwhSwFjU1zqvdplMufgWxVI2k6dPefHtBo6RwPAnZikEJ0yhCd0SO1
	 VH/Cwylg6R78XSSDHkzZIP9+1z5JbA2NmxBGryTyHoHkoJkL40PyAtVaTx6WmvefbJtQk
	 AL7+XJYFbyyzLC1l/DSSsO4hEsIVMf0wNW+yfBtHSGm48OXs8G3JezV+XW7vpzC/he0Ny
	 E1slljSXV4MJrQj/YkKQGh+zhWVD+PjonZbgUJkmd3zfFIvceT+nJ0UeC034WzNjw9B/c
	 MLKqPDaYQGd7kBDpqcpAtpZipW4NzZVWWQdNoxckBUlGSxooBJLLnTqxS4vZKoNrCLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mlrK0oHp;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D71606A323;
	Fri, 13 Nov 2026 12:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73D71606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mlrK0oHp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794572554; x=1826108554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AB23h+so+07nZAvMwKPjtG3lqmB/sy+QgJZ+BZ39McA=;
  b=mlrK0oHpAkiShH3nVy66K6utXWRAj4VHXgY9p1QQ77jeAMd0WZIkHQ4s
   weyqC94/q4jK75/u4asvF0+8XdLRPsFx3xzq2YqW5L/QU4HchgUzu6FWv
   kOnD5VjgH/LYoZwGmLgP+fZ7AKpZpiY5P1hguVt3D2AquMD9GL/W6mW8U
   9OazrdcFkWEISycJxMdZgFIMAuXNFLfsUiPWQapOdQy1YKQ/90DfP0jhz
   U6nq1MXOqFIwn+rpKz/cdLqsZc7Dy8voA3wOnaT8vGR1mwIpBlBPDaLzJ
   Qv5SqvKOxxhd1NwDyiZwHH+NnzkcRkosD+N6Zf6v9xsScoBesdzkQS/pD
   Q==;
X-CSE-ConnectionGUID: YKBg+LSpQ0OVtZqy/DmUMA==
X-CSE-MsgGUID: ZGMk8C6IRSKIhUN1frnVmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3233027"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3233027"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:22:34 -0800
X-CSE-ConnectionGUID: /vswKwj9RgSnx/VHdUX6Xw==
X-CSE-MsgGUID: Pslg9114StmRKMNEWsj6Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8757421"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:22:32 -0800
Date: Fri, 13 Nov 2026 14:22:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	penhouse24@proton.me, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
Message-ID: <avcBBe428-3Fdonb@ashevche-desk.local>
References: <20261113083940.2583439-1-mika.westerberg@linux.intel.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113083940.2583439-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 09:39:40AM +0100, Mika Westerberg wrote:
> The Dell XPS 17 9720 touchpad has the same lagging issue as with others
> when run at 400 kHz as the ACPI tables describe. This particular system
> does not use standard ACPI ID but it seems to use "Windows Device ID"
> VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk list as
> well but since this is not a standard ACPI ID match it also via DMI
> strings just to be on the safe side.

...

> Reported-by: penhouse24@proton.me
> Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.igk.intel.com/
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Isn't this https://bugzilla.kernel.org/show_bug.cgi?id=214597 as well?

-- 
With Best Regards,
Andy Shevchenko


