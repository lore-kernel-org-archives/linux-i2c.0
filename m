Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5E24886A
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998012; cv=none; b=JH5QidBZiAH0xdcND5J9gZnBO0Uy9cMrnUYgF70dCO3ZUoeB/q8wtLDkhKMwbufZOxI5KMXtC94CKATJnHo8fcQ1GnicLRUmPsE354SOFwizsObYcdg8HeSK9j8nZfPCrBZKNyH8i/0/nWZeIbi+ON9KRwN042NVlqRvCyv70No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998012; c=relaxed/simple;
	bh=Lm9LY4+7tf0AyGUsj8BSlHzK7obtSKWviIeQgXuZ2cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoREFFWjiQfE/uLJiD/XEsgcYOXWAa15q0hdmG7paoFVXtAs3wH5bnxZFV8omi24Wd57snL7AIFF9klN9jxgqO6clEcQ8XDVtRtFEtemCtH+3O+TdCN2lS8z01sP5uIGZMmLCxi8tpxPNlFsCPafM1pQYVhCVkNU0/CZX8WEJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVCZCQ9Q; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVCZCQ9Q"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e4989dacdso1054247e87.1
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 07:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770998009; x=1771602809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLc8bSL3pOampOTk05CBLNSg0vQLHPlJB9I/Kmo5iOY=;
        b=SVCZCQ9Q/BvSzYPa4r2VV8EUWHDaEq6ZGRHJpkked12AaWlsTbNDQCPVq+DxNb0MT3
         mJy+nW6kOOvSGwxe7AlHVAbboE7grV7C9+TtbMZCT9FiJwZLu5c+JVeLv0kcrSUjRYg9
         fxzYgTrrGAsrgEHdyZutddkoE/9xJQ5VfKmC/JGZboK0MQpWoL9Lds6AP4m4PIOT7XV/
         DjaaViHW2VNtQYOUSKpWqYtpmu7SCxDAUoWxiH7GlREf9YCGeynlrBSf463FQE+dnElh
         N89yOXEAKe3L1hb23AxIzDUewtfV36qy0+qxkwBwc7ncmFnECfKNOOBdZWqBFYTt4NFO
         Q4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770998009; x=1771602809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLc8bSL3pOampOTk05CBLNSg0vQLHPlJB9I/Kmo5iOY=;
        b=QgV9O2kpDlryX13Zn2OOWuTqeMdRRYlgtGbVjY+0rV3LZ7MOolq1Npv5ULFv1NJ+4k
         YePMPqXd2/z9jQjlHxQ017ItKkBwxJ6eW5b/BrQN6gEw0UZ/FVJFmuJGd+FOA9zipaJF
         Mf3JUF7D6Qw5AZ36BpHTsHEL86ogrbEYvtRzM/D47k2eW4SvtPR0p0FKk+LxLt6+ZH5C
         Y28gld8vumJRIwS3tFxMMFsxHs/fIz25w/Sw6WrotNwqyZ2e5kd4O2TBm8QMPaLMfqtH
         8My0LU287eAy7GzWDHoyljEzOwZjHClXdaBrdrVMBnPpJnL28CGjpLMBBQo2fQNEC/yh
         hrjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwfIDgBF9rP2MxUJ8dSoTiu73+d1J60ENuvhjPvcQP6C9JT6XZq6sRSf/D8QGnVJav3NpS8tjmakw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylRXxnYIf8GGLOu3P2c3afxT3ixnPPSUmZuPDo+Ddab1NW5MfR
	nvSYaZkd7FjdDGMDK6Xu8auk50OXjlkK1f9eNdpYhJHCYmAKUKz8tVV7
X-Gm-Gg: AZuq6aLmeNaz3Wswkm4o8KQD/PJMydGQmjt5NtZPu0ZPi9u106WFyImSh7hOSLDtWG0
	gFA45jQ2SC2bt9FbuihoWm+jwbK7XCmumBF1gLKoxcQ0mezS0gvUf06Ejpe24OmmQyz03kQYkYe
	WX2dE+9ggCNOb+VDFMzaV+XWDc2oQz4f4trwt09x7UmDLWvlTCkZB6Nwu13IdSzbg3cWQ+QdfY6
	bWOFtd9KwMfCU2RKjEQlQBBeRG0MOTV2TuSGjP3VDDatV/Upi4Lt7ysf/53y+hC58Sn8JBO6G9n
	V/1CuuwQE3zhgwLZX2E03gsjWTCLAmjezBOSN13+XROLHiv9TNKBelFdsmPQM02/vHA7F6vPAbx
	xMDrINSsmubf0vpJTx5XGjaDIwXwaqRr6YJzuz1RUjxw4+PpN3ipRUfLlrnpX76PxLOjknq1CmR
	yZCXx79pyVnbXLj6WC7Wvy9+ByCHlWFCeFQDBLCBYzJpj7f+vd/MA5DYva7WlY
X-Received: by 2002:a05:6512:39c6:b0:59f:6c3b:6d2a with SMTP id 2adb3069b0e04-59f6c3b6f6fmr333275e87.25.1770998009086;
        Fri, 13 Feb 2026 07:53:29 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f568dcfsm1666675e87.28.2026.02.13.07.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 07:53:28 -0800 (PST)
Date: Fri, 13 Feb 2026 16:53:26 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/5] i2c: mux: add support for per channel bus
 frequency
Message-ID: <aY9I9r8Q82HrxEZM@gmail.com>
References: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
 <20260128-i2c-mux-v4-2-dee49ce276c0@gmail.com>
 <2ecbebd8-0842-34fa-a593-25168c91aa6b@axentia.se>
 <aY5KeH3Z1S3MswHI@gmail.com>
 <f38230f2-f74b-cf89-8d15-194d85f341df@axentia.se>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jvosexET//3GfWY0"
Content-Disposition: inline
In-Reply-To: <f38230f2-f74b-cf89-8d15-194d85f341df@axentia.se>


--jvosexET//3GfWY0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter!

On Fri, Feb 13, 2026 at 12:37:29PM +0100, Peter Rosin wrote:
> Hi!
>=20
> 2026-02-12 at 22:47, Marcus Folkesson wrote:
> >>> +static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id)
> >=20

[...]

> > Consider the following chain:
> > Root - P1 - M1 - M2 - P2 - D1
> >=20
> > P - Parent locked
> > M - Mux locked
> > D - Device
> >=20
> > In this case we need to lock both M1 and M2, not just M2 ?
> > I'm not completely sure though, I need to refresh myself on the code
> > base.
>=20
> No, that should not be needed. The reason is that when you initiate a
> xfer for D1 the following happens (xfer is a locked transfer, __xfer
> is unlocked):
>=20
> - xfer using P2
>  - lock(P2, I2C_LOCK_SEGMENT)
>   + take mux_lock for P2->parent =3D=3D M2
>   + P2 is parent-locked -> recurse to P2->parent =3D=3D M2
>    + lock(M2, I2C_LOCK_SEGMENT)
>     + take mux_lock for M2->parent =3D=3D M1
>     + M2 is mux-locked -> no recursion
>  - ***** (see below)
>  - P2->select (commonly __xfer using M2, elided here)
>  - __xfer using M2 (unlocked since P2 is parent-locked)
>   - =A7=A7=A7=A7=A7 (see below)
>   - M2->select (commonly xfer using M1, elided here)
>   - locked xfer using M1 (locked since M2 is mux-locked)
>    - lock(M1, I2C_LOCK_SEGMENT)
>     + take mux_lock for M1->parent =3D=3D P1
>     + M1 is mux-locked -> no recursion
>    - M1->select (commonly xfer using P1, elided here)
>    - xfer using P1 (locked since M1 is mux-locked)
>     - lock(P1, I2C_LOCK_SEGMENT)
>      + take mux_lock for P1->parent =3D=3D Root
>      + P1 is parent-locked -> recurse to P1->parent =3D=3D Root
>       + lock(Root, I2C_LOCK_SEGMENT)
>        + take bus_lock for Root
>        + Root is Root -> no recursion
>     - P1->select (commonly __xfer using Root, elided here)
>=20
>     - __xfer using Root (unlocked since P1 is parent-locked)
>=20
>     - P1->deselect (commonly __xfer using Root, elided here)
>     - unlock(P1, I2C_LOCK_SEGMENT)
>      + P1 is parent-locked -> recurse to P1->parent =3D=3D Root
>       + unlock(Root, I2C_LOCK_SEGMENT)
>        + Root is Root -> no recursion
>        + release bus_lock for Root
>      + release mux_lock for P1->parent =3D=3D Root
>    - M1->deselect (commonly xfer using P1, elided here)
>    - unlock(M1, I2C_LOCK_SEGMENT)
>     + M1 is mux-locked -> no recursion
>     + release mux_unlock for M1->parent =3D=3D P1
>   - M2->deselect (commonly xfer using M1, elided here)
>  - P2->deselect (commonly __xfer using M2, elided here)
>  - unlock(P2, I2C_LOCK_SEGMENT)
>   + P2 is parent-locked -> recurse to P2->parent =3D=3D M2
>    + unlock(M2, I2C_LOCK_SEGMENT)
>     + M2 is mux-locked -> no recursion
>     + release mux_lock for M2->parent =3D=3D P2
>   + release mux_lock for P2->parent =3D=3D M2
>=20
> (Phhew, I wonder how many typos are in there...)
>=20
> So, between the steps lock(P2,...) and P2->select (at the ***** mark,
> which is where you add set_clk_freq), what you need to lock is M1,
> i.e. the parent of the first ancestor that is not mux-locked. When
> you lock with I2C_LOCK_ROOT_ADAPTER, this happens:
>=20
>  - lock(M1, I2C_LOCK_ROOT_ADAPTER)
>   + take mux_lock for M1->parent =3D=3D P1
>   + recures to M1->parent =3D=3D P1
>    + lock(P1, I2C_LOCK_ROOT_ADAPTER)
>     + take mux_lock for P1->parent =3D=3D Root
>     + recurse to P1->parent =3D=3D Root
>      + lock(Root, I2C_LOCK_ROOT_ADAPTER)
>       + take bus_lock for Root
>       + Root is Root -> no recursion
>  - Root->set_clk_freq                  <<<< the new thing
>  - unlock(M1, I2C_LOCK_ROOT_ADAPTER)
>   + recurse to M1->parent =3D=3D P1
>    + unlock(P1, I2C_LOCK_ROOT_ADAPTER)
>     + recurse to P1->parent =3D=3D Root
>      + unlock(Root, I2C_LOCK_ROOT_ADAPTER)
>       + Root is Root, no recursion
>       + release bus_lock for Root
>     + release mux_lock for P1->parent =3D=3D Root
>   + release mux_lock for M1->parent =3D=3D P1

Thanks for the explaination, that makes it much clearer!
>=20
> However, spelling that out makes it clearer that Root->set_clk_freq
> will be inserted in more places in the "call tree". It will be added
> before every ->select call, e.g. at =A7=A7=A7=A7=A7. Since any of these
> additional set_clk_freq calls happen after the one at *****, they will
> take precedence and ruin the whole thing if any of them should request
> an intermediate frequency (1MHz at Root, 400kHz for any intermediate
> mux and 100kHz for D1, for example).
>=20
> I don't immediately see how to reverse that such that the set_clk_freq
> for the top-most level happens closest to the xfer on the root
> adapter.

I've now experimented a bit and think I've landed on this solution:

- i2c_mux_select_chan() will only lower the root bus frequency, this to
  ensure that no intermediate mux will be able to change the frequency
  (all muxes in the middle must have a higher frequency).
- i2c_mux select_chan() store the original bus frequency
- i2c_mux_deselect_chan() will restore the original bus frequency


Something like this:

static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id, u32 *=
oldclock)
{
	if (priv->adap.clock_hz && priv->adap.clock_hz < parent->clock_hz) {
		*oldclock =3D root->clock_hz;
		i2c_adapter_set_clk_freq(root, priv->adap.clock_hz);
    }
}

static void i2c_mux_deselect_chan(struct i2c_adapter *adap, u32 chan_id, u3=
2 oldclock)
{
	if (oldclock && oldclock !=3D priv->adap.clock_hz) {
		i2c_adapter_set_clk_freq(root, oldclock);
    }
}

static int __i2c_mux_master_xfer(struct i2c_adapter *adap,
				 struct i2c_msg msgs[], int num)
{
	u32 oldclock =3D 0;

	ret =3D i2c_mux_select_chan(adap, priv->chan_id, &oldclock);
    __i2c_transfer(parent, msgs, num);
	i2c_mux_deselect_chan(adap, priv->chan_id, oldclock);
}

I will do more testing during the weekend.
I now have a virtual i2c bus with virtual mux drivers and virtual
devices so that I can setup different combinations to test with.=20

>=20
> Cheers,
> Peter

Best regards,
Marcus Folkesson

--jvosexET//3GfWY0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmmPSPEACgkQiIBOb1ld
UjL9nhAAoWXpn7BR5ktipf8OeHDmccv+zlZeihJJjvfLz+woIz3DjpZlBicZIJB2
/3SDKjT5jLJYgynI9uRRw3LH/Nte8DYaZ+IvvZ8c1cRlHVAAaaOFr5ffjLZafMSP
GUWtop0BmIcfiwvLPCCeKvqnZNPmxM/XzpcXnOkf1llOU2hlpHLV4rPr5F5fJ94Q
P4ViEjceKPli6D/17JmQdcYh7SRm5bsmJ/rj9vfJbVLsVecWgElx645k5KLMTeGI
9U744hb2eHfc2fupF00VJhRIDH/cOLI2Yo9me1LvZB2qB+9qmVLTjMzOPJF36rPK
LRE9Ei/L9jAivUryEOy4GVUFYkpixQ9YIcvVtn+tXUPpWRoY/aC7C8EuIL7mkDiV
IYEcZCqL8se8FLze3KQNq07SUuodmBMFG9pJWUsZt8dvDxirDYIsJ9wgxpiQT8zI
Er2VzjQpccC5DkG54wrC392KrLWp2V30g41Lg/DtbzXZ87XNRcjDqDajvDoVbq1I
P2dNSpWPXeeV3G4+g5i1VmFaulnV0mCt/2XqMQd5TiIasydH6ns9ftexaXVNWPhW
XA0W2ZuSiR1DKERm60A1vu+rW2O3Cx6BWdn5UHN31byBnqWbe+1VqFJtZXb1qcEK
K+EpMQ0tXCQLHFiU7N1eKd6uMZbLNDezoylr/Md3PzZWR+eRnew=
=I/TP
-----END PGP SIGNATURE-----

--jvosexET//3GfWY0--
