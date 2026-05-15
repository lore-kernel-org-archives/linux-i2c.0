Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB232C937;
	Fri, 15 May 2026 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850969; cv=none; b=A/Nyyk7soz0dOR9DZz7rbLDV+6MNR4pEpu4+Ygt/jHFHMfrtC8YMnvhgec6MkIWPu4dT5PYowQ6nldPQ81jVU+XxWF4sLEu9FeSmcFJJBfDJnGjmb3sDqF0mGROXz4QLlRldDKZcD2i1Isl4Kqc2+rSeVZXEicGN180Bhe+H+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850969; c=relaxed/simple;
	bh=2c7uG52xy9qH22gNYh5OhP1yr5biXMZnwZHATqsD++c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amIqqtOSdgdslU8jGysG3rqfwWH2XV5i4uRqeog0C9tkJH4P0WMwHqetw4VefY+gH2c9fteL9BpwGZi9u+vQJm32Cn7rOa6ophBqSMqSXqwCRpGzTXijBCOeEYgWNjAVQaJQfdtGU3EcTQ/Jn3YGYakMlwDoaTKqvaTN8+90FU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TCaEaAwc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TCaEaAwc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VyTIEquFqFfuHxV6IhHCBxuRdbr+JpQQcmqbOA5i2Bk=; b=TCaEaAwc38dS3dOtMX+BczGYmw
	ikIewtgHwAGnezJbSgCwQygvwisD0pC84V8Akm9onuj/OrlgpTlsx3ImF/Yoef30zPM+56a0KtKXC
	KnJVXABGqTfkNTHodAXPwli4hSUUQlCYSz/u07Zb3e5bn3aiuTEYcwZqDC+AjzLjq+gE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNsOb-0034By-9m; Fri, 15 May 2026 15:16:05 +0200
Date: Fri, 15 May 2026 15:16:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: brgl@kernel.org, andi.shyti@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] i2c: davinci: fix division by zero on missing
 clock-frequency
Message-ID: <c67aa3e3-b995-47b8-958a-d655447b59ec@lunn.ch>
References: <20260514103740.5416-1-chaitanya.msabnis@gmail.com>
 <1ce483f8-1d9a-40c3-a45e-6ca536010b20@lunn.ch>
 <CABjkosFHLErOziCrYhJJxtpMg01t36LqAfr-zz1wE4HSZhfzFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABjkosFHLErOziCrYhJJxtpMg01t36LqAfr-zz1wE4HSZhfzFA@mail.gmail.com>

On Fri, May 15, 2026 at 02:12:43PM +0530, Chaitanya Sabnis wrote:
> Hi Andrew,
> 
> That makes complete sense. Updating the macro to Hz is a much cleaner
> approach and aligns perfectly with the expected unit of the device
> tree property.
> 
> I have track down the original commit for the Fixes: tag and send out a v2.
> 
> Thanks for the review!

Please don't top post on mailing lists.

       Andrew
