Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0D25DB1C;
	Thu, 22 Jan 2026 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088623; cv=none; b=jPN7eLraG7oUs9dIL5SxAPzVBH6hh2uNef6ucOV24t9K/GJeN3RC1KV9O4CLdiNU/OdrqgAH00S39Jlj41UFHLLQCMzwCiaHbtcHFYkWoHQwUi8aTFeCe8gMz3eU5w6K09yLYvjKyTFxuRc93zVxYhQsCRPnOc16XWwPAn99exI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088623; c=relaxed/simple;
	bh=/vZ3m5qm0m9svVuxBIAwmw9mfM7WdXYKVYrlOdOOAxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEgRfKfdsspgNLggBA9dZeTqmnJI+p6PXGKxYlvKJGexrVop7KT4ciFE2vW0s6ttjDjGuM+UClyL01exj6aFTnR73tiZyLi1cAdQoSMusTurb+9D6xk4lcngan1sDe4T5Z6lpQE5PzFqURfUyBCsuT3Y8YJvqzrHbJ3aO6shaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHhka5CM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHhka5CM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62943C116C6;
	Thu, 22 Jan 2026 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088623;
	bh=/vZ3m5qm0m9svVuxBIAwmw9mfM7WdXYKVYrlOdOOAxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHhka5CMK1c6sXf738CRE+D3mbKGVVPLpALcUc6jujDMRHKj+43QZ0P7GCYttIMt1
	 rpMtg8FcKEV18BI9bomwf6XAmcoVH5SN1CdR1qYmlqZzIJE1eUDJqkvRHy8kCBRVFa
	 7jqq1n9wNuzujz230GBN1rE4CAjy1pRNrMtcfNWaQP2V5R58W/ZRJWDCSW4lqN6zwc
	 z+UWJc0feJcfUMeZetE4WWziXSnTPfdzr3c2/t3rU33VUTbDWq/zE+/HgiOeNawiOW
	 jcHxInlxO1rkgBhoScCMI5BGR+pheagbg0qaGEXH0yDBAwUj06U7q5b0lsY5SrxVNI
	 lfTH+kwfWEsWA==
Date: Thu, 22 Jan 2026 14:30:19 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Dmitry Guzman <dmitry.guzman@mobileye.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 2/6] i2c: designware: Sort compatible strings in
 alphabetical order
Message-ID: <aXImUj7pO9HsMCTB@zenone.zhora.eu>
References: <20260120-i2c-dw-v5-0-0e34d6d9455c@bootlin.com>
 <20260120-i2c-dw-v5-2-0e34d6d9455c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120-i2c-dw-v5-2-0e34d6d9455c@bootlin.com>

Hi Benoit,

On Tue, Jan 20, 2026 at 10:28:02AM +0100, Benoît Monin wrote:
> Reorder the of_device_id structures so that they are in alphabetical
> order. Also drop the unneeded inner trailing comma in the
> "snps,designware-i2c" struct.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>

This patch has already been applied, if you are going to respin,
please take it off.

Thanks,
Andi
