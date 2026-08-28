Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387239281F;
	Fri, 28 Aug 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936995; cv=none; b=BU8brh6A5MQYYG696Teik3usr7/nJD2frWFKZrW1XYHzma9t4xT30S+K3z9qy+yaXmQfN+6os4qIOekKAMqjB/teFbbWrlZ6Y9Uqy5i4CWgINXlquECrHwTKS+xJHZeLZraEh2HnEPAWh00wlDoB0RZkea8LEpEIyawr10Pvm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936995; c=relaxed/simple;
	bh=pVPQSnQG9PjzlkGq7RWlB7oabPvWWZJVJ6yWCDm04Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMKyLnvCduAsxXhH5Qv8S30802xPc4nbR2wKtzglfDtGszPm8CZR6eavFMRUBC7LJ75r6kdaz2kKmK8bO9p26x/7u2VHzJD5YW1h+V29kHUA8+rmlOG8ejw3auNx2z6la3lMg5/Jc7XsqgS21vVCJMLDoMkLiZgBECOT6+ogSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVHF+8c3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVHF+8c3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE7A1F000E9;
	Fri, 28 Aug 2026 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787936993;
	bh=6Aw0cBMrpNirPI3cH25b5UaKv4Edjd11Y8c0yDuaRsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gVHF+8c3sWofXUjXDg3Swg2NrNtF5kSqtIsRtWc3pI9AcXqoTmi7FjG3iPymd/Jse
	 3/TpdKG151zc6NmyQKolVZWhQmNxJwN7UjA9idO9M2eoea6udOACKc7VnXYw+cRS1R
	 zYCvtti28Ojgoh/yfpSRhZcaSyPrbRCuo+EUEQ3MJ1G1Q+N9bPkOpHizcnIkDKpja7
	 N2laplViVLeKPIoFoJ43N9PpgeGbyq8E0jHLBeE2RnuYcPKesBt5i7a+119JKZ/ypP
	 +bClyg4c8rQIc7+APpp+GTgoQ+1tjzq4D7yOk3H8ljCAc/u3X2GbMIXAUXy2lGUzSs
	 6oatHF3ioFwxw==
Date: Fri, 28 Aug 2026 19:09:50 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence98@sch.bme.hu>
Cc: Triet Hoang <triet.hoang.dev@gmail.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] i2c: cp2615: handle allocation failure
Message-ID: <apHAu8HnMD14c_Au@zenone.zhora.eu>
References: <20260816161751.24840-1-triet.hoang.dev@gmail.com>
 <20260818111703.19604-1-triet.hoang.dev@gmail.com>
 <05df77ed-855c-4897-857e-0bc2439666d4@sch.bme.hu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05df77ed-855c-4897-857e-0bc2439666d4@sch.bme.hu>

On Fri, Aug 28, 2026 at 02:08:19PM +0200, Bence Csókás wrote:
> On 8/18/26 13:17, Triet Hoang wrote:
> > Check the result of kzalloc_obj() and return -ENOMEM
> > when the allocation fails instead of passing a NULL pointer
> > to the message initialization helpers, which would return -EINVAL.
> > 
> > Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> Just change the -EINVAL to -ENOMEM. This is something which has been
> discussed before [1] as a potential to-do.
> 
> [1] https://lore.kernel.org/lkml/CACCVKEFXOKhXmF3rcmKQ8-aMFZJLZOf+imsuBYKAQsWptrJG6Q@mail.gmail.com/
> 
> On 8/19/26 08:28, Markus Elfring wrote:
> > * How do you think about to increase the application of scope-based
> resource management?
> 
> I second this, this old code could use some RAII modernization.

is there a managed version for kzalloc_obj()?

Andi
