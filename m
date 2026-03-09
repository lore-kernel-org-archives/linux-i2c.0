Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16F396D0B
	for <linux-i2c@vger.kernel.org>; Mon,  9 Mar 2026 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054861; cv=none; b=J6MxISJM0kfW7uFYyAnzcZAiIwGKdg1wVMcckNXDhtAa5EdlLEZJa7NKK7KWpnAF7jrBXUOO6w+f81FrGK72NyZIORAkd7x3ieAL+f8snXz/mckuWWCbh08ZEnStP0HrjI43+DOwFV/SceGkSAWm06loJXI2Jqec3dSoRpbsOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054861; c=relaxed/simple;
	bh=GuuVYNrc1TFjU7BPxFDcNqIfIpVLYd7YEp3Uxr43OFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/DgCcFLF2HwWdjFEpr5HsczkDddrsYUOLeNaJJJ3SiPjUlNnJbB6i5IwSawrFRNbEWAPfb02la+8osw/RyOOCOUsumm3BV/sBY6/vZop2iFiO3ZMdsGJamcONMtgDCOyd2+T//kPIjBNE3ZeZXA5d6oN0/dxmUakhv8BF1Y6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py3GAl+j; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py3GAl+j"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a42a0d7f7so18938481fa.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Mar 2026 04:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773054859; x=1773659659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5Bl4X7yI81ScRHLniRdDiy4Lg39CIQtHgwg3me+MHc=;
        b=Py3GAl+jHJygwOv8yxt/zNzl0xaTa3JXKaAXZoDx2rB040HjYOM8HRx+SDDmBee5oF
         e1IDHRxiKPnNo7zNfg/LH48ERKXIV4GvGfteH+2EVtfbrgurxhYreR00u5z4XgrFlc8/
         DrprndaQ2AQGdsJkafKeMqrqnjdtSxeEV729TAfMXx6iV84u77eDLiCf4Voad9bbwETJ
         4v/dhv3B6YcNCke5f0gC8bHBnWW3A2T+o+HhZkxHXzhFg8axcQ91Gdu7UBs0JzG1KQxo
         SkXy6cKewdIKwi39ZnvLy3NAScZXlFQf4SiXfjHCzi9IlmBZewYoRG+ADERXqnf7ErR3
         NYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773054859; x=1773659659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5Bl4X7yI81ScRHLniRdDiy4Lg39CIQtHgwg3me+MHc=;
        b=psqEASfQV6IlQJFY0yEZ09rqyewMObIscNl+7R6zH9Tf0tnTlelxqulYLAtp0jZGJL
         G41hcd03/5I6iu6cMWjPk2KUjVCk6f07pXrSeX7L74rbSlIgh+7v+8tvIyP/0sV6lxVk
         A8JLzF6aTIQ40t2TELFEGdGzl6w1nrQWXRycuuNvDUDgbwSKAYYOoZkjEswCQ+vFKYYl
         OPlo+7MTTW9BhYZHWs3unpR5rDMeBve1QMKQtOXftsW/1woJdn665gyTwX/2Vi1KukgN
         vlW0jZ8p4sKMuCaqXfiiIA7AlOKJewsyNvdjie7DejB1zHAP6Wi1WeG1hArIxk++YTUr
         BZmw==
X-Forwarded-Encrypted: i=1; AJvYcCWPtrAKnI5NsMrTYrH5+4l7m5LEOBW5qa0oGkpRX0zisNhXR6OzY8K9YyVZJFYlc+hWfxSwDZiQRI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxcmq4YNMcpFiPHyGJgPGRbbcAVagvrkZGFVF+gwcobYl2bz83
	AC4nfmWSeuDZwqpRLxsoZA4jZcjcL1YsRBrZ+Z9W56F1cvgmnlSNmQDL
X-Gm-Gg: ATEYQzxK5IAk73+qAawrjJOlD4Ye9sadXdgpLobF+tVJ6qFaaPdgUL34QxODc6BqnCX
	qfgQ1q3KV3/dD9cYztjFbxaac2BxjTN0r8AYQCOt7+k94JEaPD7SZloAM/yQfmGgk1QrqDF/5v1
	HQme3IXzo/sJwYy3/WruFCRF4k92mQa4efaFzFGCLuJIjLmQLmvJumHFDjlNIeTcw9i+ik4K6ch
	GvJPIuWSZR56wPWO2fz3kMsOfqV0622KQIGWOinVidZ2J2esHbaw6tZTpg6KEJjIntOQ1MtROqU
	pNSu1CYfdZpjft337zqwj6caeU+5i7K6cstARqdWIiI9e8WZMXOamBJnCfCXHS4pNpFR5UC9fM9
	MVs0SRFhol8ANXRK0WffvLInLENqLdG2QyqprMVxKVh16Yt/QLesNy4d5IVlX/sXAALgMzZLV1S
	UVcBD5pe7Uia6rUX5QEp3c+e/wW28rteOF2so8Acsef9UczXFwP2UZtLKmpsxa
X-Received: by 2002:a05:651c:41dc:b0:38a:29ea:ee48 with SMTP id 38308e7fff4ca-38a40e6c046mr29974411fa.18.1773054858535;
        Mon, 09 Mar 2026 04:14:18 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a4203ea59sm15213891fa.33.2026.03.09.04.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:14:17 -0700 (PDT)
Date: Mon, 9 Mar 2026 12:14:15 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 3/5] i2c: davinci: calculate bus freq from Hz instead
 of kHz
Message-ID: <aa6rhyZLhPY7aE-D@gmail.com>
References: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
 <20260223-i2c-mux-v7-3-ec75b214718a@gmail.com>
 <aZxrZbbXxm31q62s@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mJq/Dl0uaZftLsjw"
Content-Disposition: inline
In-Reply-To: <aZxrZbbXxm31q62s@smile.fi.intel.com>


--mJq/Dl0uaZftLsjw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 23, 2026 at 04:59:49PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 23, 2026 at 03:33:52PM +0100, Marcus Folkesson wrote:
> > The bus frequency is unnecessarily converted between Hz and kHz in
> > several places.
> > This is probably an old legacy from the old times (pre-devicetrees)
> > when the davinci_i2c_platform_data took the bus_freq in kHz.
> >=20
> > Stick to Hz.
>=20
> ...
>=20
> > -	clk =3D ((input_clock / (psc + 1)) / (dev->bus_freq * 1000));
> > +	clk =3D ((input_clock / (psc + 1)) / (dev->bus_freq_hz));
>=20
> Two pairs too many parentheses!
>=20
> 	clk =3D (input_clock / (psc + 1)) / dev->bus_freq_hz;
>=20
> ...
>=20
> > +	dev_dbg(dev->dev, "bus_freq_hz =3D %dHz\n", dev->bus_freq_hz);
>=20
> %u ?


Thank you for your comments, both this and the other.

This driver has a a few  other style & formatting issues, would you prefer
to fix those in a separate patch in this patchset or in a following one?

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

Thanks,
Marcus Folkesson

--mJq/Dl0uaZftLsjw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmmuq4MACgkQiIBOb1ld
UjLTwRAArYUfraX/TF6LW2865GGn5YoXBr+d3Bibi69zxz4WYBQsXuAIjRfA2yl/
yed43OaeOBalpxCnHrdbbEEnA31IVB1dm9IO1PLT855x5EwCc+JXv+NAQGTt6tFC
PPxPZiajK7/odFHYxUA3jEDzlWwdPv9Km9Pa7QkK/Gri4uxLt+VKq94qPJiAKVIk
Tx/1ffT31ymNAbynHH7xd9wIlo+8frHKdrKI0hVLXq8/s+UDJxZMsO9TcO/KKnhH
a38tYWwNq3Mj7sHi0cmK1axsOKCMtPBf4feh/mxRIxQ++45gBg3MvXQ8vHihVFUE
ntLiJG8QVJyL/h7cxTEDCefP5xLFR0hc+vrtYQxrhN5NZearOdvjAIuO0UDRNNw3
YW748qAtEWw17MBZDz4bEAoY/slfoTWPyov2IOhkQAiuaqKRLdaDyav76EtrvG7M
4glgspLbv8NtQzJq3zfvuYqwJughPVx4FRf2+52u+6JxRwEzQnN6nhe/DQEWtFb0
V/1bbVhaHd7raU2+liFFoJpqfmlDyVc9xYJ22EiD3txBJzO4dv3owV90DF5J1wli
ZSR91NN0pQ6oMw5G67cg2u5RKukk1vvI8vs0e+3yoh74QqImHZV5SNcHZWNmmfdC
nDc0eShyJUTPn/qNE7BjGH0858/P2uwhSH1r6E0uIgHbll8l2Fg=
=mhhV
-----END PGP SIGNATURE-----

--mJq/Dl0uaZftLsjw--
