Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com [45.254.49.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A627425CC4;
	Tue, 11 Aug 2026 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439617; cv=none; b=FYcPzpDJRQTnZMrQy7hqTTxmd9sEeN3ruje8DF1qYXRTWI+iaQE2fDxr+0eJucH+n/P/05Po12Ckgn6C49T0Y9P7Bz7tYM6AZ71jkL3sCK1sbYJ2rSP3NRulmQ1up/ZrWVkiwKpvO48If66T3WrtppI1P+OVzRjw9VGAsTyM5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439617; c=relaxed/simple;
	bh=k+5q2GFDm/w/4Wxk+VW6ipO2KJOZ8aNul3VUW3j42JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIzdCPX+qqmdzO5EXvCY2xfIwQzP9WdUe0SD5w4sKLBish79zDmbRewzncI2EQlom3KDKfOKHKMUNnT51j2Ciwn4yC0duf29Z1+SGgrmYHBfDb+kq3mCM6rv2t4/t8CSUDaO2lPLzHmCecJ5+vzgo+vnfi5mOC3s87oK5JzHjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b=QFcxNGFQ; arc=none smtp.client-ip=45.254.49.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b="QFcxNGFQ"
Received: from 1clarkelill.hj-micro.com (unknown [122.224.241.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 498f1a1a8;
	Tue, 11 Aug 2026 17:08:11 +0800 (GMT+08:00)
From: "clarke.li" <clarke.li@hj-micro.com>
To: andriy.shevchenko@linux.intel.com
Cc: andi.shyti@kernel.org,
	andy.xu@hj-micro.com,
	clarke.li@hj-micro.com,
	jarkko.nikula@linux.intel.com,
	jsd@semihalf.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	peter.du@hj-micro.com,
	rafael@kernel.org
Subject: Re: [PATCH v3] ACPI: APD: Add clock frequency for HJMC01 I2C controller
Date: Tue, 11 Aug 2026 17:07:51 +0800
Message-ID: <20260811090751.123062-1-clarke.li@hj-micro.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <anrHKdFEUF339B7Q@ashevche-desk.local>
References: <anrHKdFEUF339B7Q@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ff014512f09d6kunm82230f2d286765
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDThhDVhlMSR1NHkhPHUMaQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUlPSlVIT1lXWRYaDxIVHRRZQVlPS0hVQk
	JJTktVSktLVUpCS0JZBg++
DKIM-Signature: a=rsa-sha256;
	b=QFcxNGFQvZjNVM10SiNBkAfTwc+xKL3C82Jg9ifekhhoK/QZBsVwvIy8qCiduQZp1/2EcgN7q6S3gam63SR3PqaouTnqicBQq3UEvfMk9BMIXMEQrpbUgTnMDvMw//WuK6ktMax0iMXtm07fYyRt8UZwX47mdEFngJZ/29n8VVo=; s=default; c=relaxed/relaxed; d=hj-micro.com; v=1;
	bh=L6eZGn+z7EEql0hETPKjW0bixv3kp5tuxmyYGRtLz2w=;
	h=date:mime-version:subject:message-id:from;

On Tue, Aug 11, 2026 at 09:54:33AM +0300, Andy Shevchenko wrote:

> On Tue, Aug 11, 2026 at 02:22:34PM +0800, clarke.li wrote:
> > On Thu, Aug 06, 2026 at 11:31:01PM +0300, Andy Shevchenko wrote:
> > > On Wed, Jul 22, 2026 at 03:30:31PM +0800, clarke.li wrote:
>
> ...
>
> > > > +	.fixed_clk_rate = 200000000,
> > >
> > > Can you at some point update these constants to use
> > >
> > > 	.fixed_clk_rate = 200 * HZ_PER_MHZ,
> > >
> > > and so on?
> >
> > Thanks for the suggestion, I will use 200 * HZ_PER_MHZ in the
> > next version.
> >
> > By the way, do you also want me to convert the other
> > fixed_clk_rate constants in acpi_apd.c to use HZ_PER_MHZ?
> > If so, I can send it as a separate cleanup patch.
>
> The idea is that you convert existing ones in a separate patch and then use a
> new format for the new hw support.

Understood. I will send the next revision as a two-patch series:

  [PATCH v4 1/2] ACPI: APD: Convert fixed clock rates to HZ_PER_MHZ
  [PATCH v4 2/2] ACPI: APD: Add clock frequency for HJMC01 I2C controller

The first patch converts the existing fixed_clk_rate constants in
acpi_apd.c to use HZ_PER_MHZ, and the second one adds the HJMC01
support using the new format (200 * HZ_PER_MHZ).

--
Thanks,
Hongnan Li
