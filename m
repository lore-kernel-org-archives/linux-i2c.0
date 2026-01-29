Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CDC26CE2C;
	Thu, 29 Jan 2026 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726194; cv=none; b=W6zlJXMMK+nPymnGsCQklXt9VKmnECbdMucdn8GNBoA4iPe5N5VCX/l4NQZdeDMNzmQmRgwXOruGVXAzEbnJ/NWy2yP22ibDQR900XRS3My+d5mUAz3fVmi+xhEZbtrvwhH4a5Rz51AQIP8/oGedv1yYpibD/MRyxb7SqndS/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726194; c=relaxed/simple;
	bh=G2SdIgPcBVmON/TcPFsa7TlxXPEYeqXvtVqyuKHLK+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htNqwbhoN4ri6WxEJiWkNB4vjRoEZOodzWU6d+T+4VjddoB5XdZz2z2K3DODCgub1UhVM/RmFDejQe293+OjJOCYp3Xlo9M/WBoPHg9SyT38N1FKhoosLLJFZPCm9AIS9VUGva9GLAW77SE1JPtt/ztcIG2Y22DrD06XniB2GyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B7qBbi57; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B7qBbi57"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GAvJBn0EVQV5Lrq275v/ZjaGTKsbQ1c6FK2QQBX7pqY=; b=B7qBbi57I/QYTmzkAb8vMTWLIT
	wfXNimv49Vg/NgMmX+EsMMlVPInC0U3VoLxrRK1xnfPUu96q29PTens7E4Zl9pPdYYG9toma6vxxC
	KEkMskNejxWqlslpvD78oaZGFcaoNFPErMMgMNBMVWu87uei8xkMqK0bE0ZvqZFXFQQY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vlace-005Pvc-DH; Thu, 29 Jan 2026 23:36:20 +0100
Date: Thu, 29 Jan 2026 23:36:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/6] i2c: xiic: use generic device property accessors
Message-ID: <ec8693a4-e982-4227-9558-0b1fac543e62@lunn.ch>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>

> Skip clock setup on non-OF systems where clock cannot be provided.

I think 'cannot' is wrong here. Non-OF system technically could
provide a clock, using whatever binding method they use. Not having a
clock simply appears to be a limitation of your implementation.

      Andrew
