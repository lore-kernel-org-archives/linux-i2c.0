Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCF188596;
	Fri, 27 Mar 2026 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571251; cv=none; b=IqF29yZYLz6XfBjULJDLEK68tEchjl75DJrhtuGyldAcMaxA62Tn0OL9npzuUy5o/U95uIPti/VxzKfsqg7Oxq7svDR/QEqAoL9lnyCzivjiEIVvaHMWOgQt4OBhtj6WMvlc1n0hv6KY5CoSps84v/eEUn+xeTHSMuA+AaWZJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571251; c=relaxed/simple;
	bh=9qHZtiDhanOQnxlnlcnMIGn5yWvjvh/nCVC9KUTq/2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKHVKT92mQw2ig7lEEYwhhvVd2KQU1geqz/VdUeTI8uVLSpMI1G7hy5CRFQXTGI2WXotq1tyPfcYOFt5BsdCRh5HQwf2VkockmFaIC8xqxEma8EyD4Lj6x+oNd/BQsENGdH28fIg0ROGToM2MXWL+kTAIh0kRVktEJrPwSF14n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dckkfzoW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dckkfzoW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eG/sTjio8XWgbGLo2OAUG4mjXh3DemIvsZC9G4MtvBw=; b=dckkfzoWgBd8lmaM1ZBOtoBWI9
	JNARRzv/aULxVQoN2n0ykkuapNlnytAC77PsQi8VsIy1vmDPA4XVqBeVyiDw6apQQ1i8q41fwOyFo
	p4PR8vMSXYLfiPEiLf+Y+CLil//NmsAWqnNSPEcJjNSjIHuXML50ol/OHXgTXhR+tS5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w5v2i-00DZ1u-BQ; Fri, 27 Mar 2026 01:27:16 +0100
Date: Fri, 27 Mar 2026 01:27:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Martin Aberer <martin.aberer@bachmann.info>
Cc: peter@korsgaard.com, andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: ocores: Use read_poll_timeout_atomic to avoid false
 poll timeouts
Message-ID: <c9afbdf9-d5ce-4f1c-8192-5d3baebe125c@lunn.ch>
References: <20260323135249.550925-1-martin.aberer@bachmann.info>
 <20260324140556.2249039-1-martin.aberer@bachmann.info>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324140556.2249039-1-martin.aberer@bachmann.info>

On Tue, Mar 24, 2026 at 03:05:56PM +0100, Martin Aberer wrote:
> Replace the manual polling loop in ocores_wait() with the kernel helper
> read_poll_timeout_atomic(). This simplifies the code and ensures robust
> timeout handling. By using this helper, we avoid spurious timeout errors
> that could occur under high CPU load or preemption, as the macro handles
> timing and condition checks atomically.

It is not that it does it atomically, but that it always does a check
after the delay, even if the delay has taken us past the timeout.

Apart from that, and the other comments:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
