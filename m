Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4A30C629;
	Thu, 22 Jan 2026 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088822; cv=none; b=EdKG0srXdt8IOQYQSfxTA9Lh0eCfgkC3nHHYHFzf9Fz3o82u1BBMCdOo38Gd9Ls+qXtW2qMWEBsMiNqcNKwQbhAWerzSHiwPHzgxaG76iOvUxDgiH1x9pc/329f9TrNGO+wVtZQGKRHnHX+azsVRBKOUWbEKulu0ykVwe3q9jdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088822; c=relaxed/simple;
	bh=myBEZuREDGnd31a8dGBMcUMSMskFid8Rcgneal2KRCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBQ1DluJN6sao7v4Nz8P7QuxHiZFD+GT7f0KnHymSdt+vq5w08o81Y9m3hunxpveYs37nhl2XrZLmup4mK4h6+5k2+9PDsc1Eop4aPcB8kQB+vdNcleYCSXKgM4qAfzkhWID3Ai0Jmokf2TY+EsFZOLH9NI/se+8uk9mMnAIotc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuY+qoMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuY+qoMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEA9C116C6;
	Thu, 22 Jan 2026 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088822;
	bh=myBEZuREDGnd31a8dGBMcUMSMskFid8Rcgneal2KRCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AuY+qoMXm2B0P4yiNyjhb5sHlxEjlvVKVo4Z9mJKIwhessPIN95+QDqXKcY05aoJv
	 d9vXpq49PrONjd65phkocbIhKarhLXc3hejOlKvsa87w46TO4LzB8s5A530eWoEajb
	 9T0AAeERVA3qBWP5Adehlj4L9VkYx2KwUfH69R4HrcRVkj5v52HiwgN3X6SVXm/80O
	 KLx7gp3cYtJF+1mvXV9U8j9DCla3WuGueCHu2JvSwVHJc+1991rW8HYmfkQpRF7IPc
	 sg4inFbYgOI58z+BB5EasdfH6gZFSbwocYesGOt5exCBIYbSnz24udSEq2cB7GlIsi
	 y46504KtbrrhA==
Date: Thu, 22 Jan 2026 14:33:38 +0100
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
Subject: Re: [PATCH v5 0/6] i2c: designware: Improve support of
 multi-messages transfer
Message-ID: <aXImuRJqAmWE1fml@zenone.zhora.eu>
References: <20260120-i2c-dw-v5-0-0e34d6d9455c@bootlin.com>
 <20260120100129.GH2275908@black.igk.intel.com>
 <27275605.1r3eYUQgxm@benoit.monin>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27275605.1r3eYUQgxm@benoit.monin>

Hi Benoit,

On Tue, Jan 20, 2026 at 04:17:46PM +0100, Benoît Monin wrote:
> On Tuesday, 20 January 2026 at 11:01:29 CET, Mika Westerberg wrote:
> > On Tue, Jan 20, 2026 at 10:28:00AM +0100, Benoît Monin wrote:
> [...]
> > > Changes in v5:
> > > - Rebased on v6.19-rc6 and fully retested on EyeQ6Lplus.
> > > - Drop dt-binding patch: already merged upstream in v6.19-rc2.
> > > - From Andi Shyti's review:
> > >   - __i2c_dw_xfer_one_part() now returns 0 on success instead
> > >     of the number of messages transferred.
> > >   - Drop inline keyword from i2c_dw_msg_is_valid() declaration.
> > > - Link to v4: https://lore.kernel.org/r/20251126-i2c-dw-v4-0-b0654598e7c5@bootlin.com
> > 
> > Why you dropped my ack?
> > 
> Sorry about that! I somehow forgot about it and b4 did not catch it either.
>  
> @Andi: Should I resend the series with Mika's acked-by or you handle it on
> your side?

The ones I have applied so far have Mika's ack. If I write:

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

b4 will take it automatically for all the remaining patches :-)
No need to resend unless required by other reasons.

Thanks,
Andi
