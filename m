Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8737A845;
	Sun, 26 Jul 2026 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068418; cv=none; b=D6TLCWUQIquaW4GdcvxAAW/WsM+YkxlZHMPd8T928T6VFgjKUHRJrWGbmIgXIuWVJHS04lLj2Fh1Ke4JqswO8mxilAaNBStQJwMvSnxhvnjPkSSfycO1bQRhSfvZ/ZSjbJdV2o58+ybRrb+QJjJHE6w+Vg2pBubF/SJGxB/ulpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068418; c=relaxed/simple;
	bh=RvNnXwcG6LtIM4DmKbcN5w6R8rh/aLmz1guTySE5fs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaEh5sJMddl5Ke022J3hfsDpvUYHSmF92PH/0jjgMvJhT9Mah/rSLD5qREfSvMSaLCziJsue0sIoOXcG1PAUD9eDRfD4uYLtQzQeRt5S2VJBN/AadeqFSTIGOcJuvOnJRZ7UhXKbzxEDNg6wKds0f3M0wWv7Fvw+yBlIYNXXM7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tye3+Nep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tye3+Nep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0501F000E9;
	Sun, 26 Jul 2026 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785068417;
	bh=DmI9fdOdzUdWpec4E+81bxO7ODC2be0PWwXd3fnmoO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tye3+NepvbgCF65YDhJenIzRbKbzm12mL1+oZ2JUelcH2RdBc+Vggr8UNPwM0BM/j
	 nhxw7Ut2f1bV/PHLfP/ot0Ei2+TM8S7fgAIb4uIXi7ah+LpkdTS3O0E1y+RGSBS00j
	 AVVhCC/8l1lG1N0ySwXggMjH9b8MwXz+0OGuCcHs=
Date: Sun, 26 Jul 2026 14:18:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: HE =?utf-8?B?V0VJ77yI44Ku44Kr44Kv77yJ?= <skyexpoc@gmail.com>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Israel Cepeda <israel.a.cepeda.lopez@intel.com>
Subject: Re: [PATCH 0/3] usbio: fix two out-of-bounds accesses and a hang
Message-ID: <2026072632-overripe-speech-1d10@gregkh>
References: <20260726080129.44969-1-skyexpoc@gmail.com>
 <2026072622-refusing-smasher-6eed@gregkh>
 <e6ce9251-fcaa-4833-ae6b-12a5d46415ba@Canary>
 <2026072638-construct-overload-c30b@gregkh>
 <CAOC0qyKoERn-DLK4TRX-FWGe=HOf+ioYko=HLgxh+aKqwZLCCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOC0qyKoERn-DLK4TRX-FWGe=HOf+ioYko=HLgxh+aKqwZLCCA@mail.gmail.com>

On Sun, Jul 26, 2026 at 08:59:58PM +0900, HE WEI（ギカク） wrote:
> Thank you for your suggestion. I apologize for my oversight, which
> added to your workload.
> 
> The html was my mail client, I have switched back to plain text.
> 
> I won't resubmit all three patches.
> I'll submit only the one for the debug hex dump,
> which I'll organize and document myself, and generate using git format-patch.

Why not fix up the first two to be sane instead?

thanks,

greg k-h
