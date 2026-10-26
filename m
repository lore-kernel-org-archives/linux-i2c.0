Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.217
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793041611;
	b=uEaAU0ByZ0qaoQmV8gbkRMZ6q9MoWn2YORbCGv/NefEL3SwVmu0PZbPmpvQhY00xUY/J
	 JN/C3SfyIOsLmMWM0XV6G/ZMz5SvgnThXEQQJjFX7K2NHB5UTeGY35JnwTUR/CatkYIad
	 drzWHqgR6Ml//c9J5GMncCX7u2NfkGiIoDnoJ1cIITjXZAv6eN0UmOJw1EPLDFPT57OMm
	 BBEs0tTJQazuT9vVvaNYd19PoX1x2RFyl72kHoA38WUUak98Lwldlq6A50HCOdGDECJeK
	 3JSo1WoxOCUorzbNrmcI9L4CW85oImujxSbELMGGltReVD9V7sJMbgqksVFeOFcAKiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041611;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=Vz6y83AD+r4x77tu1IdoFHhXiD1cfS1IBhV1BQp0e4Y=;
	b=J04JFuaQ4cXvQ8DFxXZG2rw2cR97uTHwD60WgBj1Y6+bw13Xzo0z4m6NBqXmoF29FjEb
	 UasJ5TlBfX3s6ee4SBmoo5JOk607ZMmVl6aNTNJYgwgxFWruZpzO+AZn9ORVbbhfgif5P
	 mYE5AcfJ0txFow+br8CFbo1Z9GDFHut10Ani/kzDikvTKiMEhgjlymQ3YzaK/WjomOkN7
	 GiZTW1qPF5E/oMmWpO02ppQf31RD1HP1zROsfnhrXTMtB7H2MQEERlgTK81WEHqBqpWJq
	 kI8Ad+AiIMUGtNl7gAGwlnqsoMEVN5sXkvDKNiK9R1u2X7u63IZS+5m8T7Y5pwL2JPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=harbaum.org;
	spf=none smtp.mailfrom=harbaum.org;
	dkim=pass header.d=harbaum.org header.i=@harbaum.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=nsde1148;
	dkim=pass header.d=harbaum.org header.i=@harbaum.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=f9i5E4eV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.217
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A19606A31A;
	Mon, 26 Oct 2026 19:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A19606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=harbaum.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=harbaum.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=harbaum.org header.i=@harbaum.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=nsde1148;
	dkim=pass header.d=harbaum.org header.i=@harbaum.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=f9i5E4eV
ARC-Seal: i=1; a=rsa-sha256; t=1793041602; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=f2BbZa93HXdP2pgGyXt/g3nN01qwz8lNvPcFeLWxNYFSWn8ws96PuUxmQNHf70rtjF
    UEm0kirKBd9lPZ/hIr1BuBzbgvrS4H5rn6YbMVvGqHaFd3zBqLwjOW0PJ6PeZ+6zX4iL
    jlz0PlgVMGxwMcw2K2hCIX+utYG/OQtIZ/UiJ6YyVfnk2kHEg3gTy5Q6VejLGhW4PqJg
    3l+mvJzsQbpirftVSA5qCOQWmNRz79F1Kukce52Jhcaj3XzpJ9g34SIswudV8lSKQ8o7
    hUQACD0JoIm+PYzWchTL3PYXVnSySqbwjpSTHGxKTvv+02eAFcnhJeGVnG+t9h26ZPY9
    ufow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793041602;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vz6y83AD+r4x77tu1IdoFHhXiD1cfS1IBhV1BQp0e4Y=;
    b=bMqOkxiAjbP3iUTa4VjGlWrvZEa/pmahiVjO4ojLZqLtEp9ddiFvvvHqqLaLEYM0zo
    kN8zxuWuw6FwUXsoJQxdh4apwmXz7e7/09+DsW2rKO/9cxI3bpAhAUVGPtmFnjgD5DMx
    zXBeN/Gb6ee+zwi6kfpgqmwkH4l7e96fWp0UrGx5Msw+2+/HJOh6SnvYxw3Wt8Hzdpb9
    oouNRlgCC4GnrynTN8hHV0nNOwfTsgdvNXkfO0mestbig+sXs0jz6vt/GQKwfGJjcKZF
    2wzTnwDSQXTlyrLrGoi9edpmh26lccQPACs4wRXGZwEpBmIi/bOt0g6Ql/5vCEcfegaH
    7eJw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793041602;
    s=strato-dkim-0002; d=harbaum.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vz6y83AD+r4x77tu1IdoFHhXiD1cfS1IBhV1BQp0e4Y=;
    b=nsde11484ru0Imck/DcM9tQfib8BlxWWQasM//1egdSkxLeDdMiGUWoYZSU2dLZMR3
    ldz+U1zUTHxr+Neft8kdueSuEzTDeaHO6PDcnSWU3mjAoqGe1C0TatnQ6GVJFiz13yd7
    m46bVC7ZoWIy5V5vosTteZSR1kjadgk4P6hcJuE276I6HJe9WFjas96zs4a6xBy/xruS
    Ltkl+1FoO3/CfiY0SenM/vfrVXSAHPgNDAl+uL3s/8fjJlrV1uSu+b2dSFPOuviJJCGE
    rjgEE18hdwTc4ZcvoFWoHrLMCEz8vrsKqWmwqOoLq3Xz4FbodwhTOBbw4clkV6ma20Jd
    licw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793041602;
    s=strato-dkim-0003; d=harbaum.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vz6y83AD+r4x77tu1IdoFHhXiD1cfS1IBhV1BQp0e4Y=;
    b=f9i5E4eVZDOOCDbCwmZZHnRD/WosfXU2gCC38FZKpGOeSMhyB8joVUaF+3g6QhBz2v
    ebXl4UFSPQxawaxFkZDg==
X-RZG-AUTH: ":OGUIeWCgeu1cUM8LNN+8Lq3lm9FT7eDMWDB13B7h3B8JKs4bAOhjwd49ZkhB6+gvHccm3l5QQzqHeSsfhr3cecZAAmwOp94="
Received: from titan.localnet
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id g2e32829QJ6fE37
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 20:06:41 +0100 (CET)
From: Till Harbaum <till@harbaum.org>
To: Andi Shyti <andi.shyti@kernel.org>, "Dustin L. Howett" <dustin@howett.net>
Cc: Whinis <whinis@whinis.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Dustin L. Howett" <dustin@howett.net>
Subject:
 Re: [PATCH] i2c-tiny-usb: add support for the Oops Electronics SFP Media
 Buddy
Date: Mon, 26 Oct 2026 20:06:40 +0100
Message-ID: <2856078.mvXUDI8C0e@titan>
In-Reply-To: <20261017-i2c-oops-electronics-v1-1-ce960f8f1b7a@howett.net>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

I am fine with that.

Regards,
  Till

On Samstag, 17. Oktober 2026 19:56:04 Mitteleurop=C3=A4ische Normalzeit Dus=
tin L.=20
Howett wrote:
> The Oops Electronics "SFP Media Buddy" is an open-source USB device that
> provides i2c access, among other things, to a SFP+ network module.
>=20
> It exposes a vendor protocol which is compatible with the i2c-tiny-usb
> kernel module. Due to a bug in prior firmware versions, that protocol
> can only be used with devices reporting bcdDevice >=3D 0x0101[^2].
>=20
> [^1]: https://oopselectronics.com/product/SFPB and
>       https://gitlab.whinis.com/oops-electronics/sfp-media-buddy
>=20
> [^2]: Devices without the fix will crash and drop off the bus when this
>       module is loaded, which prevents them from being updated.
>=20
> ---
> Signed-off-by: Dustin L. Howett <dustin@howett.net>
> ---
>  drivers/i2c/busses/i2c-tiny-usb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-tiny-usb.c
> b/drivers/i2c/busses/i2c-tiny-usb.c index 73355a56aabf..92a2633a028e 1006=
44
> --- a/drivers/i2c/busses/i2c-tiny-usb.c
> +++ b/drivers/i2c/busses/i2c-tiny-usb.c
> @@ -162,6 +162,15 @@ static const struct i2c_algorithm usb_algorithm =3D {
>  static const struct usb_device_id i2c_tiny_usb_table[] =3D {
>  	{ USB_DEVICE(0x0403, 0xc631) },   /* FTDI */
>  	{ USB_DEVICE(0x1c40, 0x0534) },   /* EZPrototypes */
> +	{
> +		/* OopsElectronics SFP Media Buddy v1.01+ */
> +		.match_flags =3D USB_DEVICE_ID_MATCH_VENDOR |
> +			USB_DEVICE_ID_MATCH_PRODUCT |=20
USB_DEVICE_ID_MATCH_DEV_LO,
> +		.idVendor =3D 0xc2f9,
> +		.idProduct =3D 0x0004,
> +		.bcdDevice_lo =3D 0x0101
> +	},
> +
>  	{ }                               /* Terminating entry */
>  };
>=20
>=20
> ---
> base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
> change-id: 20261017-i2c-oops-electronics-5dd3659782da
>=20
> Best regards,
> --
> Dustin L. Howett <dustin@howett.net>


=2D-=20
Dr. Till Harbaum <till@harbaum.org>


