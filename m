Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783201946DA;
	Wed,  6 May 2026 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058722; cv=none; b=TMWhtj1JCzcYj2/sw/KkU1h4ZrRis3RPFHfhh1ugveXVmQi0wZ08j5IwTHruQiea7YyYa+sbh6i/eFOWzSMdR7kCoeTv1VwZqnXCjvzXVtmqU4Y4Va8wsqH7/SBdZzC+RcJ6QJw0y8ETzqNm8TvsCn1TcRX5soQuhXncWqchSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058722; c=relaxed/simple;
	bh=k/9nC1Oh9B1Vz5BNPYgltV2a5XRrsgqGv3XuyqCaGQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDgLguCkvBQCOGLCd333AFVChycYi7mXetwco2t05Li8W1Rpaxz7Z9gPd7AmE0tSzZV1R5g8Y6p++KJQ9zMw/3ys4o2fuQDPU6R0W1QAc77BWaLDU0N4x1o8cDirxOWDcTrkJBAuevN3dp9muemM95cKUGEXHbym54hF5es18n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MchCgeLu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MchCgeLu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778058720; x=1809594720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k/9nC1Oh9B1Vz5BNPYgltV2a5XRrsgqGv3XuyqCaGQk=;
  b=MchCgeLura1zPOmQUQklDeugZlQsfNnfpxE4YgHPMoaPHma5/rUgu+XJ
   MsrwzNs3QEH/MWWGmtTdzwHPgubC+ZADV3hkLqYcSw7bYts/pwQCup+WO
   UZMRkcGcK2+bZ/UB4Vz3XimwuDFsOIsRTggyZOZBjSYRBmMWvJgoCmduo
   a72hC2LUZZ+urYnHrW5zLlD89nRImRYjjFSEXLH6DSacc4AM3u+JpmGEa
   JmrsavgTqqfprxLwVOPgWtYKlAierHkDsGzbnVnnEhUHeLV4vGlboe3yw
   X3Sa11VCHbIoQaheB5gk9t2kwI9MrpOixuqQF3U3llEf5T1VZQSUAluKW
   w==;
X-CSE-ConnectionGUID: OhEsLx+9RxSQy8Gu4i0obA==
X-CSE-MsgGUID: MZctEVg0SQe4RRR5j1RVsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="79031436"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="79031436"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:11:59 -0700
X-CSE-ConnectionGUID: Im+XSyRZQ72lQKQe6NrWSA==
X-CSE-MsgGUID: /aWWs2tkTNiiOTTqysH8FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="235247650"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:11:58 -0700
Date: Wed, 6 May 2026 12:11:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Carlier <devnexen@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: ls2x-v2: return IRQ_HANDLED after servicing an error
Message-ID: <afsF2y0_oe2IloXT@ashevche-desk.local>
References: <20260506044818.19842-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506044818.19842-1-devnexen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 05:48:18AM +0100, David Carlier wrote:
> The event ISR reads SR1 and, when an error flag (ARLO/AF/BERR) is set,
> calls loongson2_i2c_isr_error() which clears the offending flag, issues
> STOP for the AF case, records msg->result, masks every CR2 interrupt
> enable and completes the waiter. The handler then returns IRQ_NONE,
> declaring to the IRQ core that the device did not interrupt.
> 
> That report is wrong. The device did interrupt and the handler fully
> serviced it. Because the IRQ is requested with IRQF_SHARED, the genirq
> spurious-IRQ tracker counts each error as unhandled. A bus that emits
> sporadic NACKs, arbitration losses or bus errors will therefore march
> toward the spurious-IRQ threshold and the line can end up disabled,
> wedging the controller.

Have you exhibited this on a real HW?

> Return IRQ_HANDLED on this path. The other IRQ_NONE site, taken when
> neither an event nor an error bit is set, remains correct.

Hmm... This sounds logical, but we need the Loongson folks to confirm as this
is sensitive code and changes like this may affect existing work flows.

>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ls2x-v2.c b/drivers/i2c/busses/i2c-ls2x-v2.c
> index 517760d70169..9df73557ecc4 100644
> --- a/drivers/i2c/busses/i2c-ls2x-v2.c
> +++ b/drivers/i2c/busses/i2c-ls2x-v2.c
> @@ -304,7 +304,7 @@ static irqreturn_t loongson2_i2c_isr_event(int irq, void *data)
>  	regmap_read(priv->regmap, LOONGSON2_I2C_SR1, &status);
>  	if (status & LOONGSON2_I2C_SR1_ITERREN_MASK) {
>  		loongson2_i2c_isr_error(status, data);
> -		return IRQ_NONE;
> +		return IRQ_HANDLED;
>  	}
>  
>  	regmap_read(priv->regmap, LOONGSON2_I2C_CR2, &cr2);

P.S.
Is the analysis and/or commit message AI assisted?

-- 
With Best Regards,
Andy Shevchenko


