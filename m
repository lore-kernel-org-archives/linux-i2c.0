Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C06237FF43;
	Sun, 26 Jul 2026 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785066283; cv=none; b=VI0WKhy+/L1DGUQyM0PMvI6BWNmthU94EGplg3OZ8K9HgmeVhuG+AiuKQZ1PEJSU0mizci1fuKANra1E1C6a+hDLU70fPgzrnU3JzcMn310eVHKMhrvsk47L0nDTCdF08QQ5Oy39aRrX8VKXRs4h21RIuTjbMnL45sK7D3YFjwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785066283; c=relaxed/simple;
	bh=pyVtMshB5w3Z3agco+2hAUNLs0xwj0Cr+b5BQgq2Nrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V66y/coQOTjg7b6iwjTvoagtXDChsMFuMr3X9/Wz9aIYmzV7KZL6vTRDV0/M3LIe5pZ9d0bDuIbnQ5QazNaHtxHDStwxJjcf2EfoIuUZvpVn5jDpNQRvSSj9Cvzhaoagt9akehSU1vgyJOAuzVtytcG+Cm3Dd5Bvzmroc859MrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GLULQDsg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GLULQDsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0634E1F000E9;
	Sun, 26 Jul 2026 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785066279;
	bh=2B5YoGLY4COBPKzV1Wb7Fhj4sWP2ZUbOkbLOlbqr8mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GLULQDsgJ+E/8Vhi+uCgLsO2dCr+0gAAPpTmRyLpae/HxpNl0LfpRZkyXlKd5WDH4
	 /a3ugnv7xj8ydHQ5iN16kRTRk+VzBKeTgRBuMziGEKQ51EJnbBGMUeSGsgvSRu9oFV
	 o+VrgSfJusNBFPJOtH5se3W64No/b/9aA/8j/6pI=
Date: Sun, 26 Jul 2026 13:43:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: skyexpoc <skyexpoc@gmail.com>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Israel Cepeda <israel.a.cepeda.lopez@intel.com>
Subject: Re: [PATCH 0/3] usbio: fix two out-of-bounds accesses and a hang
Message-ID: <2026072638-construct-overload-c30b@gregkh>
References: <20260726080129.44969-1-skyexpoc@gmail.com>
 <2026072622-refusing-smasher-6eed@gregkh>
 <e6ce9251-fcaa-4833-ae6b-12a5d46415ba@Canary>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6ce9251-fcaa-4833-ae6b-12a5d46415ba@Canary>

On Sun, Jul 26, 2026 at 08:32:25PM +0900, skyexpoc wrote:
> I’m sorry. I should have included an attribution.
> That was my oversight.
> 
> I did use an LLM this time to assist with the audit and translation. It performed variant analysis on the code around 8c6314489550, identified these three issues, and wrote the patches and changelog. I ran the build, reviewed the results, decided what was worth submitting, and sent everything out. The Signed-off-by line is mine, and I take responsibility for this work.

Yes, but the LLM did _all_ the work here, that's not good, you can't
rely on it being correct (hint, you also sent an html email here which
the mailing list rejected...)

> I have now read ⁠coding-assistants.rst and ⁠generated-content.rst. The following has been added to all three patches in v2:
> 
> Assisted-by: Claude:claude-opus-5 asan
> 
> The cover letter also explains what the tool did and what I did. There are no code changes compared with v1.

And the LLM got this all wrong, again, please don't assume that what
they spit out is correct.  I see on average, only 2/3 of the patches
they create are proper.  Given my initial review of your first patch,
those odds are still in play here...

thanks,

greg k-h
