Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7B3F1AC0;
	Mon, 24 Aug 2026 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566945; cv=none; b=MjrPu7WJkdxUwiFcno/J8ffp6dsYXRyTjUiziduR5LQMNxrq9zBjkAivAIEztGPv/HH14KKu/D8a3rwpTl0Tg6UBm6l+u/8XHc47mBw6exIDv+b4/6BKonexf/czsnRvKa4imf2byxhTG/nz+cEHr6R6efYLDCM+K74EtIDDgPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566945; c=relaxed/simple;
	bh=8itdofsOPXidm6gqt1/415I4d7Zc2iJyah7th4xASXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI1nY0Wbo2YLPOzhH2Z9u0YGMYyP7PC6YLCnpolhJHN7S2KAsNUkQFzNoZ3lmRQdwFZwSLnij4rtn+98RA/dgyFFDSwoxy/Ecqpm4mUE3iOalMi0rU91yZ+7EMS5YLjhTLL4i/EAxNfMZ7ZyNMYazOW/uGOrFY9jmUohH73DTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kel3UoUo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kel3UoUo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787566944; x=1819102944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8itdofsOPXidm6gqt1/415I4d7Zc2iJyah7th4xASXQ=;
  b=kel3UoUowzIFkOkcSl7oWWF5ZaPqKJuNDhvaaSbFQMhpDkXofdicZi+2
   PEjFUyyPxnv5vbYUZE2Oiq8A5r27I/zikUK6xq7S5pGbI3pEQqVIXHk3q
   EIY1xZC2fy19TMtPKPjqNBOPVKBRPwnlW9W73K3WbWJa7v0EaTN0WgGgl
   GTavPl4Gs+fqThUHyfT9xb72B5IdFGSgKadbmtzFjOs9nL1WVnihqjHGD
   OyX+0syyxA6kxQkSo802Q0c38Athh5NuWt05qaGlOz8kPW/jyC6ibbd6W
   8m7EDsXt0IX8wsMiqaZ6faNitPBZevBHp2FNOoa8R85TIwE/7ao9bACRR
   Q==;
X-CSE-ConnectionGUID: 91WfhQqSSeWX/Ayug0ObAg==
X-CSE-MsgGUID: o9HbzdPMQd6gzw6dZFJigQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87884856"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87884856"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 03:22:24 -0700
X-CSE-ConnectionGUID: qUycJmyYTguHutobk/2J/g==
X-CSE-MsgGUID: aRJkUt2SQ0es38nF6GgHJw==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 24 Aug 2026 03:22:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A1D2499; Mon, 24 Aug 2026 12:22:21 +0200 (CEST)
Date: Mon, 24 Aug 2026 12:22:21 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>
Cc: andi.shyti@kernel.org, westeri@kernel.org, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] i2c: acpi: Add DELL0A86 to
 i2c_acpi_force_100khz_device_ids
Message-ID: <20260824102221.GE893316@black.igk.intel.com>
References: <63cb7f6e-27ab-43d8-adb5-d2f4acd57674@gmail.com>
 <20260823123310.188189-1-xiaoyueyoqwq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260823123310.188189-1-xiaoyueyoqwq@gmail.com>

+Andy

On Sun, Aug 23, 2026 at 08:33:10PM +0800, xiaoyueyoqwq wrote:
> The ELAN 04F3:3185 touchpad exposed as DELL0A86 on the Dell Inspiron
> 13 5310 intermittently exhibits excessive smoothing when the I2C bus
> runs at 400 kHz. During an affected period pointer movement becomes
> severely sluggish and sticky for tens of seconds.
> 
> The ACPI firmware configures the touchpad bus for 400 kHz. Add DELL0A86
> to i2c_acpi_force_100khz_device_ids so that the bus runs at 100 kHz, as
> is already done for other touchpads exhibiting the same excessive
> smoothing problem.
> 
> With the quirk applied, the kernel reports that the firmware requested
> 400 kHz and that the bus is forced to 100 kHz. The problem did not recur
> during extended heavy use, including an S4 hibernate/resume cycle.
> 
> Assisted-by: Codex:ChatGPT-5.6-Sol
> Assisted-by: OpenCode:Ox Alpha (x-preview-f-free)
> Signed-off-by: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>

You should use your full name here.

Anyway looks good to me.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
> Changes in v2:
> - Resend as non-flowed plain text; Thunderbird mangled whitespace in v1.
> - No code changes.
> 
>  drivers/i2c/i2c-core-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 8f3bdd5..3af0e05 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -371,6 +371,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
>  	 * the device works without issues on Windows at what is expected to be
>  	 * a 400KHz frequency. The root cause of the issue is not known.
>  	 */
> +	{ "DELL0A86", 0 },
>  	{ "DLL0945", 0 },
>  	{ "ELAN0678", 0 },
>  	{ "ELAN06FA", 0 },
> -- 
> 2.53.0
