Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3714E3784;
	Tue, 29 Sep 2026 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724162; cv=none; b=QFpbXOirZp/XHPN+KQkXJ6+OT1S9kAPVyjpFsLU1fITqe2icKwX/2s/rf9UOvOkNYieU0HaRL38m5t9k57h+xfguNPl89UorLZu4LF7P2nx9S2S9yv4l/Kz0hXXUwkMBqxBSUwCkTpuvZTKfsg297zpQhnByp0JKKE+vdlApeJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724162; c=relaxed/simple;
	bh=eKVV53kFdNEuoc6ndbryGR58WiHcECMoxPW7WZ6S89s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJF4rlCSRWUJpQyBNk3XPMgQgy2om6nxWC0JzxbNDkxLy/H190rU6PpF5QpZOBlc4pT5+97fQ1EhrtdrvmYExGtrgLFS3WsGHXxKGRt2HvmcfAOdwjEf1kudg7HaHS5UUWFNiTY8cJbqzwvg690uVtfgw/RC7xw57ZNopwr7MRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOg4M544; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOg4M544"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0291F000FF;
	Tue, 29 Sep 2026 23:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790724161;
	bh=Eou9fgSiO3HeotFiJwMyOMv6cJ3ryz7weAQZJU5neuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OOg4M544gZHONMXoE607/wFxm+Ls1cHy1siLSR++nYf6vS3Yyq4N4F6LAdZgZvHUV
	 O/fuiYTFcQwqBTF77YT95ZMeBS2BVoXlhRyc2UL/NQP9nYLJ4IbLNNKfwzWGqMl7rG
	 tkuHgKQGv7c7y9WnfBOAvsSS/9FrhHLb6LWhau40O15Xvh41mfYt85KG8Y2w/TQcPJ
	 i19ne2xRn564tMwIel68nRAX2J5Dm1zJpZT90aRrWQKEBnaTMMuab6cpy90Do/0zjF
	 jK3UViQi9FXtccWv3n5Mtz9FXHDAfaj16gTFNq9KdsXNZrF7kfWyLKa6FVxwkSqNeD
	 u9ZqI2eLGJScg==
Date: Wed, 30 Sep 2026 01:22:37 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH resend] i2c: qcom-geni: Use device_set_node() helper
Message-ID: <arxHazGOhJTVz96v@zenone.zhora.eu>
References: <20260919141434.22999-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919141434.22999-1-johannes.goede@oss.qualcomm.com>

Hi Hans,

On Sat, Sep 19, 2026 at 04:14:34PM +0200, Hans de Goede wrote:
> Use the device_set_node() helper instead of manually setting
> adap.dev.of_node, this:
> 
> 1. Ensures that in if he parent has an of_node adap.dev.fwnode also
> gets set to point to the parent of_node, rather then leaving it NULL.
> 
> 2. Removes the need the specially handle the parent having an ACPI
> fwnode, since the generic helpers take care of this too.
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

with some of the changes suggested by Mukes, I pushed your patch
to i2c/i2c.

Thanks,
Andi
