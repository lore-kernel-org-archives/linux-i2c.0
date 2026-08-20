Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12A415B68;
	Thu, 20 Aug 2026 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787227032; cv=none; b=cJ6gCd09rvxLFFvunMu0tnRQFB/C/1WKwzQbafRLh5QDc4JOhuVdXo3IWM+Vu3dvuqZBeUHxJ3ZZFvRdvAV9XvR9eJIdmoEG+M7wCRYsxKw7uoZleUld1iJeNUgLWBPoW/RG8tm6ziUQ6LSLtzpeY672hy0n0MxGMhjo0wrzh/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787227032; c=relaxed/simple;
	bh=p/L+dSsR7FwDeQ3u509HxhHno6HXI5CaXrHzAdqh9Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGVwBX/0ar/16mpFoCLhEhB5GiDNNZLqFm/aQyGMtthjMrg2EZPRwAg4MsPfKzgwnHSPihr/SwRaZgLkGggWi5Lez8Ok0/PlE0K/uxd+mQg6qRBGEa+Txh/4WEC1iz71XdglHrm/gHZ972Fotol+2QwzxElytQZ/VHkAT1ng4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IInbLDzK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IInbLDzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78881F000E9;
	Thu, 20 Aug 2026 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787227031;
	bh=0GJt5EL2uecAjTaJ1ne7v2q9OCPBsH5zzfeiip1fwKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IInbLDzKPeECLfDooLoXtA1xiKyUQfH6GF8mJabzVLGz++Lanz5CqtFbVGzsehise
	 CWu1eq3mvnoA43f7arQSbnSXaBk5bbqMJxRsFP5z+UhMco3mdmaOFwIcs4f3Mz5P15
	 xJPXW4X2QhnznS6aUTz3C1NI9QWxyzboEH/Lm6YxPbAj0puwZwJapk9waUrwerUtyy
	 39tTXmkzuTxUQlsbxI6apJIOpqTctgj14NwVQrK7y5ukmkrrhd5ckoVxK9U40eGw9l
	 /1XSODIwmtN8bz4Ej4sBgf7zoc8QQMwRN4Kq9OaOwkemEylZmHnFwgJ6EIM8qSIxtm
	 bTdSSySN30F3w==
Date: Thu, 20 Aug 2026 13:57:08 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: linux-i2c@vger.kernel.org, bence98@sch.bme.hu, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: cp2615: Validate read length before copying
Message-ID: <aoYYzhB7Ia6cTTY0@zenone.zhora.eu>
References: <20260818124737.64478-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818124737.64478-1-triet.hoang.dev@gmail.com>

Hi Triet,

On Tue, Aug 18, 2026 at 12:47:37PM +0000, Triet Hoang wrote:
> The read_len field comes from the untrusted USB payload, which could
> potentially exceed the client's originally requested buffer length or
> MAX_I2C_SIZE, allowing an out-of-bounds read and write.

have you experienced any issue yourself or are you just
speculating based on the code?

Andi

> Limit read_len to the maximum size of the response buffer and return
> -EPROTO for an invalid response.
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
