Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0D3A7848
	for <linux-i2c@vger.kernel.org>; Mon,  9 Mar 2026 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057822; cv=none; b=T+YgBGjUsle8A44Lklrq05CADsHYExsDj5w0G66ez8au+FibKOi5DflRSFDDKuWu5B6hEo5ECDWWLDzoZToitnsCgzeIVKKPHY+7gwmRw+Jq5mPGkAKq+BicN5gRo20rWn/GuCwFsaYnKPfFzTbT+sIZuJl3t7tYZ1khB6GOzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057822; c=relaxed/simple;
	bh=lHR9JJBOfopUU6rWUx75U2eWXAdEG/5cnC187WtEZYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELx0Lxd0+KDAtY9ZO9HJu+GreVCwWqe12nThsUDuE6UUrZ9qt/lG0kbnbmeF9HxHwv9snzZYMvyy5D0zpVwms8mc8kK4kWgm1bHqXmUQB0EboTUmfgZn9tZyYo5Kfrw5BxRT2m/Irr3/4ujLCc2sw+kS/iBVo62JEuFujeA9na0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mAS/0Zmg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mAS/0Zmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=w02o
	vZAEGyUnNiwRG41VAUQvUtw4ELCi/UFkxt/wBic=; b=mAS/0ZmgKOYMHgZNRnlM
	nvhDB4Z8WLWdSVsvi069GrvtT+HBWwNcY3BQBq2LAhlZk19rG5JhrWLuaHNje04s
	NXney0za0s1PFlo14+lO2dKO98xKwE2SgR4mwi4duH893W7C/YEcXjt/QeJBW2bN
	upcEhGU//ubdTcH0uxkGLi4oS0tLyFzz78AOMn7ng/RtKzwfbJKDzVjk9kYaJDjd
	gQKT7dWUTDLbjPNTlMPh43EfuWtdE6keOPKf685l6jXW5wtTZ/Q9gcMRxmh3pj1A
	PjInRLf3KEHXZQer7QjYy1sZ3o4HCEopPaIhYQQ+WO5geGHiZnCQ73zzgjHJwQh0
	XA==
Received: (qmail 2765949 invoked from network); 9 Mar 2026 13:03:37 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Mar 2026 13:03:37 +0100
X-UD-Smtp-Session: l3s3148p1@GRpiMZZMyIIgAwDPXzF+ANZpdrMKUeLI
Date: Mon, 9 Mar 2026 13:03:37 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: diolan-u2c: drop redundant device reference
Message-ID: <aa63GdPpNMk_aroH@shikoro>
References: <20260305125221.11009-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305125221.11009-1-johan@kernel.org>

On Thu, Mar 05, 2026 at 01:52:21PM +0100, Johan Hovold wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied to for-next, thanks!

