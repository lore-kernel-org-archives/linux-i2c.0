Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800563A4512
	for <linux-i2c@vger.kernel.org>; Thu,  7 May 2026 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144583; cv=none; b=Qi/6l96tLGLSvDHUKI3uelmcRwS22RNosLq/d2qSZY5CmkcLVYLYZ6+B7mBTtDhDZJ/i5cQ51Ed9orm6eHOhUv0HxFIpsyrud03rWXnNdg+xmxBERw62LS5AkZZy8BxNw7ShljM24xA27ki7rZx8CiaGUCa9SOlMZpq5/FZ5ILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144583; c=relaxed/simple;
	bh=lzGAXpz5VVwRm6k9RC+Er0oVi9WNpDTR6j8dEsP4iC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQu0NalQcY9+V7uoyvsEbqbW+nzYPWBmtP5uKnJoiM4pCteFgIGHWNLK0e00Swtfq4Vrv95wVn/gZbD+i6YNwpA/o2cks2euYslc3sy87Hrd1W8sHscWbZM/oulXQTg39ZlgEmkA0iMxkYMmDN4cb1XHP3LwkQyALT6n4FfHb2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KeHo31qB; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KeHo31qB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=TuMh
	tI+hXthBehxVA73OjNQaI5K8KyhPJ5Dxtrx3thM=; b=KeHo31qBT9EYVyVE88rY
	uy/AStlbmjt7x5hS/rslGfRpF9Ri/wZmDX7WrX1YG+ZLzh49F/pReTJJog/eGwe4
	9RQGy7Mu3RR7vWwPCtSkt5woc1WZp9Vz0TcygDDNGiJ56JiUa2M4WOgp4klfPxmR
	Enn+Gjugp++zW6psrj9oSNAkge0emP/KzfpdHG1fWkEyXCl199cuTWjDAXZr70//
	Wl9VCccBsUGla3Hecx8aXx70Z5PmDIOK/xhV1K2OivZ+Da9zavmle1DfofP32iLD
	BrZWeuQFJPQ+Q2xmZsw+QmiT/pEBn7cK5zXyWjRERZX3yydgGHkYO8d0A3uZQugu
	jw==
Received: (qmail 1041669 invoked from network); 7 May 2026 11:02:46 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 May 2026 11:02:46 +0200
X-UD-Smtp-Session: l3s3148p1@N/Y9izZR6rMujnuP
Date: Thu, 7 May 2026 11:02:46 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v3] i2c: smbus: reject oversized block transfers in the
 common path
Message-ID: <afxVNh1wopdfZdy1@ninjato>
References: <20260505175510.1403736-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/MkjF3vi9J28Fh+c"
Content-Disposition: inline
In-Reply-To: <20260505175510.1403736-2-bestswngs@gmail.com>


--/MkjF3vi9J28Fh+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2026 at 01:55:11AM +0800, Weiming Shi wrote:
> The SMBus block transfer length data->block[0] is validated in
> i2c_smbus_xfer_emulated() but that check runs too late for tracepoints
> and is skipped entirely when the adapter provides a native smbus_xfer
> implementation. This allows user-controlled oversized block lengths to
> reach tracepoint memcpy calls and driver callbacks unchecked.
>=20
> Add an early validation in __i2c_smbus_xfer() that rejects block
> transfers whose caller-supplied length is zero or exceeds
> I2C_SMBUS_BLOCK_MAX before any tracepoint fires or driver callback
> runs. data->block[0] is filled in by the device on SMBus block reads,
> so the check is scoped to operations where the length is actually
> supplied by the caller. This is consistent with the existing -EINVAL
> convention in the emulated path and protects all downstream consumers
> at once: the smbus_write tracepoint, all native smbus_xfer driver
> implementations, and the emulated path.
>=20
> Two distinct bugs are fixed by this change:
>=20
> Bug 1: smbus_write tracepoint OOB (include/trace/events/smbus.h)
>   trace_smbus_write() fires before any validation and copies
>   data->block[0]+1 bytes into a 34-byte event buffer. With
>   block[0]=3D0xfe the tracepoint copies 255 bytes, overflowing by 221.
>=20
>  BUG: KASAN: stack-out-of-bounds in trace_event_raw_event_smbus_write+0x2=
7c/0x530
>  Read of size 255 at addr ffff88800d98fcf8 by task poc_smbus/91
>  Call Trace:
>   <TASK>
>   __asan_memcpy+0x23/0x80
>   trace_event_raw_event_smbus_write+0x27c/0x530
>   __i2c_smbus_xfer+0x43a/0xa40
>   i2c_smbus_xfer+0x19e/0x340
>   i2cdev_ioctl_smbus+0x38f/0x7f0
>   i2cdev_ioctl+0x35e/0x680
>   __x64_sys_ioctl+0x147/0x1e0
>   do_syscall_64+0xcf/0x15a0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>=20
> Bug 2: i2c-stub I2C_SMBUS_I2C_BLOCK_DATA OOB (drivers/i2c/i2c-stub.c)
>   stub_xfer() implements .smbus_xfer directly and only clamps
>   block[0] against 256-command, not I2C_SMBUS_BLOCK_MAX. With
>   block[0]=3D0xff and command=3D0 the loop accesses block[1+i] for
>   i up to 254, far past the 34-byte union.
>=20
>  UBSAN: array-index-out-of-bounds in drivers/i2c/i2c-stub.c:223:44
>  index 34 is out of range for type '__u8 [34]'
>  Call Trace:
>   <TASK>
>   __ubsan_handle_out_of_bounds+0xd7/0x120
>   stub_xfer+0x1971/0x198f [i2c_stub]
>   __i2c_smbus_xfer+0x306/0xa40
>   i2c_smbus_xfer+0x19e/0x340
>   i2cdev_ioctl_smbus+0x38f/0x7f0
>   i2cdev_ioctl+0x35e/0x680
>   __x64_sys_ioctl+0x147/0x1e0
>   do_syscall_64+0xcf/0x15a0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>=20
> Both traces reproduced on v7.0-rc6+i2c/for-current with KASAN+UBSAN.
>=20
> Fixes: 8a325997d95d ("i2c: Add message transfer tracepoints for SMBUS [ve=
r #2]")
> Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Applied to for-current, thanks!


--/MkjF3vi9J28Fh+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn8VTYACgkQFA3kzBSg
KbacaA//cl9fSH4LzevzTuva1b5C5YkZqyLCR8Qk/xwxchJm8ScZRfhvVNuvzdFB
NQ0xA22wxqncxvKsR87leNAv0GX17fLbewhDBJk2MEPNarAO4ezuwigbo3ht2Fs4
oq7oKOFH58qEy7aeBkoRiNGYmh06R3u3PMHhpfFVloKT+cyiYiYBiKIh03g0M0zD
4ej/tI/07AlzR1wrO7bmiHMJIQHAlpfA/DjOM5RR56IzZGdVFrsJtJHgyH8gtbaK
zPgU2WRSVtGjlWTG7beoFSY/JeCWJ1oRcoBj7JChVJ+Kd8C/L7KDhV5p8GgEXGO0
ziltsP3AwdBRFEPcm/oci/eAqKAs8lX4ek06TT9yHWAvmYoGnFv4OZj2tIEukHaI
T1OJzZK/Oy75A3HqIytYOCpqv5QrUhwcBmK7LtyLeLo64o0UJvlqis6P1ml0WV42
CFckuilgbCzfwIMLjUHOMZ07Ebir/EuvNOxF0h5HgohcOE51r8j0aIrNHiV1jeL9
LJAuHHMXwKUZUwFPxMAF8O3vnL+zyC8KGTaE5YV+tUitUtpWv0DT5ew0QfZPbN8Z
faqB566Fnngopoo5pxq+6OoVBNoa0FC5UTPLPt/2kpZpDMaip2YQCT2vtsRnr/BM
606X3eB8q5bHVPvCbiU9MIZQe6fvDnTmzyC5DiRnjD7jJe89pFU=
=oz8X
-----END PGP SIGNATURE-----

--/MkjF3vi9J28Fh+c--
