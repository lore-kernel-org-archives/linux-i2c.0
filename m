Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9D3ECBD2
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065790; cv=none; b=AOjIVjPPzdjZqYuI1Xg08mtzVFpnn2vKEXJe+fOg0IzTYH7fFcWY+khWvf4qOqAegM53AKzNUQXIoHEOfOORMHsa9gkoaKNbvLYhEI7Ux+yEz9glIJxzH96OyDCuaVpHdVryWb51OhyLt8lfFRfFKpy8aAf9VT3qedL57rUZaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065790; c=relaxed/simple;
	bh=yQD4zNdD2BSQB3lNfcLeJ6QlNPagJdo7n0UyJ5bpvv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ5apjKWqBRDRqMrer+HW/JpduwuwUomgtZWWGlLjpud1lh/d+H0cEHgE5JZUn+WZji/KJxSAuEK2WvpaxnnVMKQQxZ1kbsRK8HpaiTlDgbLGaou1ckyL4ToE6uCL7C3mxF13QrzcQJ0YBQXE/y6hZp1tAjQB50v2OyQsG4vqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ItBsgM13; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ItBsgM13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=9fuA
	9ouBqsdEcreA7yo7YyXa6zUnUxq7AwI0ZtAUbTI=; b=ItBsgM13P/zNIPQRayRF
	Pa3Ht8cJKgP/MdY2lqVLJMOTvEjvlpteEdH1E0qlVfSaqV/jwIn0V0oI37BxUMHr
	LIb4BzARp9waDW+tnV3haQKYbGf6UAIY5dCgWv5jAgTcZ1ayuDI95qY2oyYM3e/2
	4dqF+awk/OlZNomEP10PDR1DwJ11GvCwpDU3qeh6t1GFZKcFz/zqcFFc2zGIsD7U
	A8YOYxM5MgAO5b6ELnBZRqO+DD16zhW6CZkz+GY0hXFZqTr6fo/BUUEnGZiccxr2
	qARR4l7R0tv4rSTW9Ejclb/P/LVjO/YGT7K4Z4LRiTaEkOoo8h4n+ozO5fMpzdtN
	Sg==
Received: (qmail 1451240 invoked from network); 29 May 2026 16:43:06 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 May 2026 16:43:06 +0200
X-UD-Smtp-Session: l3s3148p1@OcDf3PVSYtsqAQ4KEBW5QLbOwWyJKVt/
Date: Fri, 29 May 2026 16:43:06 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org,
	andriy.shevchenko@intel.com, mario.limonciello@amd.com,
	brgl@bgdev.pl, basavaraj.natikar@amd.com, linusw@kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
Message-ID: <ahml-rVa2PIA5DDC@shikoro>
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="by5s9rhg/cFjelNc"
Content-Disposition: inline
In-Reply-To: <20260529100838.8896-3-hardikprakash.official@gmail.com>


--by5s9rhg/cFjelNc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 03:38:37PM +0530, Hardik Prakash wrote:
> I2C controllers may have child devices with GpioInt resources that
> depend on GPIO controllers to be fully initialized. If the I2C
> controller probes and enumerates children before the referenced GPIO
> controller has completed probe, GPIO interrupts may not be properly
> configured, leading to device failures.
>=20
> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> occur before the GPIO IRQ quirk in amd_gpio_probe() has run, causing:
>=20
>   i2c_designware AMDI0010:02: i2c_dw_handle_tx_abort: lost arbitration
>=20
> Add a generic dependency check in i2c-designware that walks ACPI child
> devices, identifies any GpioInt resources, resolves the referenced GPIO
> controllers, and defers probe if those controllers are not yet bound.
>=20
> This ensures GPIO controllers complete initialization (including IRQ
> setup and quirks) before I2C child enumeration begins, fixing the race
> without device-specific quirks or DMI matching.
>=20
> The probe ordering race was confirmed via dynamic debug tracing:
>=20
>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
>   2.348157  lost arbitration
>=20
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Assisted-by: Claude:claude-sonnet-4-6
> Assisted-by: GPT-Codex:gpt-5.2-codex
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605240959.Kcf1lIg4-lkp@i=
ntel.com/
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221494

In case this goes in via some other tree:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--by5s9rhg/cFjelNc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoZpfoACgkQFA3kzBSg
KbYsXA//a0KHp2oMOf5p21QFIErW4mnS69Af+62AnfRC8A8VaN6cH25QldulJkuc
N81nuK1o7WvfC/7UrObBsal2l1fDc1TzQrwhJR6fWygUpxk76tEkt7ICVTs0dWMO
ZmEpq0LS8tyImJyNATycz3IlF7rRdIo/+mqFS1A38UpghjNePCgpJNPpej2A6BG3
7gl5PpL88m22gHs4tytpBStf0n58jjj3QGgNSExb33ssDptpM9mXIJCiFu38zXbp
mj4tCkCKhlA8NybALor2zoRwieo7cHk1YCiJgDVxTKiKUW8g+k0qi6qzLu52UAfj
Md1/UF+DhLFuZLiB5zm/l6p+nCdUljqyKlFWl1SgNUQKocbwa96sZd8CEDMuPJkC
z0BO8fOAVHbo3tj3GDPhR65ybg0a4xLCj0kUEnmZI1GHmkmzF5Yp/ETJqKfTsBjS
c0C+9bPzBRkUplpOJhAsF4AMiBqD4ED2sHuzbKqChvRgrD6D88rbsliB/8LJJIRS
NN23kjE7BCtjdSjwDNM0AjUPf5UV1WwKShFf9OE7/cDV36gJeRfKWmerzFsHurAe
4/xm0ck5OpaPUk9jnB5OaoYNLYgup42FFMf3SPxbOncL1ZIU+9irzH7JyQnsaJCG
fcL1XyEF7HXKaFDU0zgbASOt98L9b4svNqKxmu12cji4z9QwS3g=
=fXLA
-----END PGP SIGNATURE-----

--by5s9rhg/cFjelNc--
