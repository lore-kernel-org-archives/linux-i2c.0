Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACF2D592D;
	Sat, 10 Oct 2026 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643482; cv=none; b=MQdH8U6KmlkoxNKb3koutr+G+0cDwsa0rXNSteCKnjk7IlC45zPtAWKfmy9RGelRQWf+0vsvFvYNOK5bJy7T4/K0tQIt7a3+7/T1YT09KMnjVE+EWW22k49dJ8h9M4Qch5B/2pMZB9jz4PkN1qEuyNP8ZPD/Bkye1mHKY6wxpy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643482; c=relaxed/simple;
	bh=Vdlnp+XgefEeSchxpb36GPxsLXPq5vkIeGrVjEuGj2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEVLK9+M+dwxfpFs4Yqfmb9p2QFRItFn3awSMdJHbZKEbUT8MlwpJB+dnsp39xbLG5HD9cYV6HQk4AwzXZt8zkcjGXH1BXEStIhVbQtfJ3s3XKXoOJCqbKSnvXr1qDzaFv7DKYi3TqxHwiuA2SztFgJXB0McrWz9TCAl9yhWT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h52j+75W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h52j+75W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7386B1F000FF;
	Sat, 10 Oct 2026 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791643481;
	bh=LdZvMjyIj7HU28oM3OOtUs/KIaW6JY9grEWxWl70N8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h52j+75WoQyhE8XnKgMjhJniX4S4LJ17im0LtkrRQf50NTztHhwaapTKQpLS66JhO
	 p36U+BcxPZzqJiSvM2LCUwE0xNvcA1/zGSUz2hqPUS1Kk0aY8dBVNH7NSnoEbJb8g3
	 bhXH8LdXC4x1ErrcBHrPk8SUfRBmP7+tJmtAXRKG4QZY1mHNPBxHOeLC/SfsTo3Ksr
	 MQvdxNexSupSOevva7jpEav26iRlQvaNpHjC1UjebLEwu3LIOnDtNqVP8UjrBUTdoI
	 xu2fbwHGFeyVkIGSjd4LOA9WLOTRSTyS+9QNnCdPrA6/wRJpXzAa8h4zpWFeyjFi83
	 RWXMCWe83QGBw==
Date: Sat, 10 Oct 2026 16:44:36 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: size the RX FIFO threshold to the
 queued transfer
Message-ID: <aspPNnJR5lUW4Fja@zenone.zhora.eu>
References: <20261007191911.502428-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007191911.502428-1-navonjohnlukose@gmail.com>

Hi Navon,

On Thu, Oct 08, 2026 at 03:52:31AM +0530, Navon John Lukose wrote:
> i2c_dw_xfer_msg() leaves DW_IC_RX_TL at the 0 that i2c_dw_configure_mode()
> writes, so the controller raises RX_FULL once per received byte. Program
> RX_TL from the reads already queued, capped at half the FIFO until the last
> message is queued, so there is room for the rest.
> 
> On an Arrow Lake-H LPSS core with rx_fifo_depth 32, a 22-byte HID input
> report costs 2.00 interrupts instead of 21.43, and a 452-byte descriptor
> 0.14 interrupts per byte instead of 1.64. Polling the touchpad with
> HIDIOCGINPUT at 142 Hz draws 1.58 W less platform power (psys, 32 paired
> runs).
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Assisted-by: LLM
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

pushed to i2c/i2c.

Thanks,
Andi
