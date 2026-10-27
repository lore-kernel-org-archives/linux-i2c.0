Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094930;
	b=yopsbTdDGAvas47IMVTTQD4zb0RqSvZJ/hQh6Tng/NJzX6zqkii+6AVooQud/N1U6bKm
	 IdS93BK0X0rK55UcygxY8E/1dPJoG+OppL1F5fQWZQSRbgTLq2uz/5avXQI20eJSB7G2H
	 4sc2EWQQpmhaI/TmojvYVTtvBj4+S6Ts0/ZKBeOBT/c6FmsM9sQShhQ6fi7Bp4vz3LZ8E
	 2XkYW4TY/9OwXLZj1LfV44/W37zos/NfVVxZJTnVbQgFDkMG0M4SB65Xwh3Aga9HS4g2F
	 M0RqjcyPPyyNd/8HStkAVpFXujHmf3SNK7xnCf+qdBrIz0+Sg2noO/EbTRDhfLpmKjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094930;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Gq4Dew7AOEXeJiD0yyOgJBKqXm1njeggbkIEMuUJOlU=;
	b=f83tfQ1y+gpv7NFxE8r9CwkC6tYd1JZWJd/2GblbvvXFshUY3lcHSHTzYj7n6nw0ymp7
	 9HBqM2ulLx0eOUeWTdEjLmvXPYpz1ZKQ6S+uRRM93PV5AOvUJDw/gLnEGH5u89F3OT+nM
	 2qEopvftO2tNknEHFW4aIC1cd5JerTSSR2MYKU4Q1weIwK2MBbFIey8LIgVAn4x45ZFvJ
	 rifUWa0up030FgeBfX/XuC9exN3PhuP2oaogYmG+JoUnJogYHg9ifxo/DuK5cwVsSJ9ut
	 1ldBlTAisPyRBaNXuGvxtIpX/cyTJAidDdrRzp6XO4p2K44T17Zn+iEdl2TdVEB+WRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDB8jj6C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCFC606A31A;
	Tue, 27 Oct 2026 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDB8jj6C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99431F01828;
	Tue, 27 Oct 2026 09:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793094929;
	bh=Gq4Dew7AOEXeJiD0yyOgJBKqXm1njeggbkIEMuUJOlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hDB8jj6CU/U6aKsWQehhHrpC18ldQlA1cCqGxirLKarRTPmzm0Dqot2AaqOIsRfJZ
	 IoF2ONn0zZ7CTn6z8qbfKTzEyi6U1HH4PZkSFreo9ThowzHDhRzMvKgWLmwm4L7WDK
	 HM/mre8dDlPH5orFwTJzhCZAGnMFht5ijBRMWRchdPnYIlgFHyVM8GTC6CxKXBrCOS
	 5IxyaX2N1ZCpTBVezrnJGQmiAyK774fCvEZRxgt2QjZaG954Skd69iXoFRDFnAwLyV
	 x6KcoSQaej2hEg+FFU4NjTRsX88pOEdeDFS7ugjSeJylzWcTNn8yKUOxukXy1QolGE
	 u/1my15e+7pKA==
Date: Tue, 27 Oct 2026 10:55:25 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: "Dustin L. Howett" <dustin@howett.net>
Cc: Till Harbaum <till@harbaum.org>, Whinis <whinis@whinis.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c-tiny-usb: add support for the Oops Electronics SFP
 Media Buddy
Message-ID: <at_f_xNsyM3IyUo1@zenone.zhora.eu>
References: <20261017-i2c-oops-electronics-v1-1-ce960f8f1b7a@howett.net>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261017-i2c-oops-electronics-v1-1-ce960f8f1b7a@howett.net>

Hi Dustin,

On Sat, Oct 17, 2026 at 12:56:04PM -0500, Dustin L. Howett wrote:
> The Oops Electronics "SFP Media Buddy" is an open-source USB device that
> provides i2c access, among other things, to a SFP+ network module.
> 
> It exposes a vendor protocol which is compatible with the i2c-tiny-usb
> kernel module. Due to a bug in prior firmware versions, that protocol
> can only be used with devices reporting bcdDevice >= 0x0101[^2].
> 
> [^1]: https://oopselectronics.com/product/SFPB and
>       https://gitlab.whinis.com/oops-electronics/sfp-media-buddy
> 
> [^2]: Devices without the fix will crash and drop off the bus when this
>       module is loaded, which prevents them from being updated.
> 
> ---
> Signed-off-by: Dustin L. Howett <dustin@howett.net>

the tags shouldn't be placed under the '---' otherwise won't
appear in the commit log.

> ---
>  drivers/i2c/busses/i2c-tiny-usb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
> index 73355a56aabf..92a2633a028e 100644
> --- a/drivers/i2c/busses/i2c-tiny-usb.c
> +++ b/drivers/i2c/busses/i2c-tiny-usb.c
> @@ -162,6 +162,15 @@ static const struct i2c_algorithm usb_algorithm = {
>  static const struct usb_device_id i2c_tiny_usb_table[] = {
>  	{ USB_DEVICE(0x0403, 0xc631) },   /* FTDI */
>  	{ USB_DEVICE(0x1c40, 0x0534) },   /* EZPrototypes */
> +	{
> +		/* OopsElectronics SFP Media Buddy v1.01+ */
> +		.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
> +			USB_DEVICE_ID_MATCH_PRODUCT | USB_DEVICE_ID_MATCH_DEV_LO,
> +		.idVendor = 0xc2f9,
> +		.idProduct = 0x0004,
> +		.bcdDevice_lo = 0x0101

I would also use:

		.bInterfaceClass = USB_CLASS_VENDOR_SPEC,

so that i2c-tiny-usb cannot claim the device’s HID interface
(check the i2c_tiny_usb_probe() function).

Thanks,
Andi

> +	},
> +
>  	{ }                               /* Terminating entry */
>  };
>  
> 
> ---
> base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
> change-id: 20261017-i2c-oops-electronics-5dd3659782da
> 
> Best regards,
> --  
> Dustin L. Howett <dustin@howett.net>
> 
