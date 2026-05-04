Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517453AB29E
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893933; cv=none; b=NOZTg942p7Kfd/FkXHShalxvAN3k5sZsA6nmpalmNteghARU/1vme7PvLWP1QM2cffT9lYY/WI9YnRw+kbyuqwn56bZQ2ixBL1lBs6T60BQc/VjTLbGAjC2PBENWKj2HGiSH5fm6a4Y4IVF75xnB0JbiiICYPG3xcTkVKsBr5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893933; c=relaxed/simple;
	bh=C5w+EcdmvgVdC09jlWjXS/wK5N6XobZJ4t+7kGl8Ovw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkeAW1r+lVn0LBCKdlsnCyFPXdCYbK7V0tflPQF0me+XMmo5zt2D++/3j1nW/n6nE9gKgCak48wJ8qBckePLeNUjPKBxPwx9dHGQ851shQ6BxTwBEYVxnyu8ceuH/ONcbRtMntDwmfW+U5azzsEMZkLRYVazbjp3RfXnYpKIALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Nb4zmqGA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Nb4zmqGA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=b3I2
	xhGOkRitVsVg13z7zosVMuzCmIwvUg9hS+WqGYc=; b=Nb4zmqGAjdiiaxtET9qe
	Wfmu0++THkghpnsQgWspAa7GLvySjpig69dYAG/WMw9rk+LdQzJobwckWBa7UobB
	igDP0YdQFTF6VGgHKN5PVOoQBsLzTYQS5G75z5PEC8VS02ZVZ2yEVc7Ztam+mgSX
	c/RN1fyP+dLks79wt6l5xfHLjbXgzVQzJc5zB+C9igpRwcdeFrHJTYjv/qGZpeDF
	Eh8P6jVmbs3LXF58vJppT6SlfH+oZI3QAdXCOPxZ+PWRPyHBenjvG6KPwwxGJGJp
	0kC0LVMTuQouJcbhYSjYNlT/wu51wAm3noQoK9ek1YxF8K/vOvSxhRnAp6+EvPUP
	xw==
Received: (qmail 2174646 invoked from network); 4 May 2026 13:25:26 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 13:25:26 +0200
X-UD-Smtp-Session: l3s3148p1@oZvsL/xQ7pIujnvR
Date: Mon, 4 May 2026 13:25:25 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v2] i2c: stub: Reject I2C block transfers with invalid
 length
Message-ID: <afiCJQkF4-cRFrrf@ninjato>
References: <20260414172338.110830-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qVj9iCGRljNAszug"
Content-Disposition: inline
In-Reply-To: <20260414172338.110830-2-bestswngs@gmail.com>


--qVj9iCGRljNAszug
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 01:23:39AM +0800, Weiming Shi wrote:
> The I2C_SMBUS_I2C_BLOCK_DATA case in stub_xfer() uses data->block[0]
> as the transfer length. The existing check only clamps it to avoid
> overrunning the chip->words[256] register array, but does not validate
> it against I2C_SMBUS_BLOCK_MAX (32), which is the limit of the union
> i2c_smbus_data.block buffer (34 bytes total). The driver is a
> development/test tool (CONFIG_I2C_STUB=3Dm, not built by default)
> that must be loaded with a chip_addr=3D parameter.
>=20
> A local user with access to /dev/i2c-* can issue an I2C_SMBUS ioctl
> with I2C_SMBUS_I2C_BLOCK_DATA and data->block[0] > 32, causing
> stub_xfer() to read or write past the end of the union
> i2c_smbus_data.block buffer:
>=20
>  BUG: KASAN: stack-out-of-bounds in stub_xfer (drivers/i2c/i2c-stub.c:223)
>  Read of size 1 at addr ffff88800abcfd92 by task exploit/81
>  Call Trace:
>   <TASK>
>   stub_xfer (drivers/i2c/i2c-stub.c:223)
>   __i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:593)
>   i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:536)
>   i2cdev_ioctl_smbus (drivers/i2c/i2c-dev.c:391)
>   i2cdev_ioctl (drivers/i2c/i2c-dev.c:478)
>   __x64_sys_ioctl (fs/ioctl.c:583)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   </TASK>
>=20
> The bug exists because i2c-stub implements .smbus_xfer directly,
> bypassing the I2C_SMBUS_BLOCK_MAX validation in
> i2c_smbus_xfer_emulated(). The I2C_SMBUS_BLOCK_DATA case in the same
> function correctly validates against I2C_SMBUS_BLOCK_MAX, but the
> I2C_SMBUS_I2C_BLOCK_DATA case does not.
>=20
> Fix by rejecting transfers with data->block[0] =3D=3D 0 or
> data->block[0] > I2C_SMBUS_BLOCK_MAX with -EINVAL, consistent with
> both the I2C_SMBUS_BLOCK_DATA case in the same function and the
> I2C_SMBUS_I2C_BLOCK_DATA validation in i2c_smbus_xfer_emulated().
>=20
> Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Applied to for-current, thanks!


--qVj9iCGRljNAszug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn4giEACgkQFA3kzBSg
KbZlcg//RNHv+9PnYKvaAd291fQuYij8615Gygp8VLmenLaw36Oo7apYtezb/oyq
yNPsLJB7xCnk+9jNd5qC1xUWzOJQvE+efvTLsoXsiXPGOCphJQ8uHmabOvNMcSa1
bp6J47Mgo8RxwOvUsYH/sr6qYbXtUo4ci6JiB826zsk2PtRBi+c1srD0aJkSRZ9S
n3rnH2kHj0rJBpXQgS+pezdBS2ZqQbjgoxKSVQ23lxaafAfIxIKqW0ToGvKcvesm
CPGO0eJVn7Wf3KIj99Z4aGTzCesAAhtGWuQzCtsZrXTIgYxxmzSlI1PXyE1neWmL
cC1CHDMXCLupWv95x256JDHaxOEIAfqraQk8l3IMBq9gpLd5POWd1bTe3I2TfqLm
j0DSY7M/k43JEuN2isQ8ugm0d/X2MHCY664AuSDSc8OJxUSFGPECxhYEQ+zYtYWJ
zHl0Tm6Zlbmn2JjSWwP/GSC9JAXKlalAkCEfGxjIZUk0zqX7kQ+uMpQwMbB8T0V2
QjwRVdnNkktSYjBDWC6Se9pynORpUa8PYzN6jrSfBKgbe0jdB9adNgNUfcXGEMm9
PjBl4lUbLofXxXzDtAkXotuwo86ed1IsyoTPWR1c9vFbx5cvdK9sJL/fd7SMBAgN
2a5bSJpNkDMZm83YmrRodqiLYDMzkK4H8S9aYEbp1AnH5hKK/Kc=
=ujjL
-----END PGP SIGNATURE-----

--qVj9iCGRljNAszug--
