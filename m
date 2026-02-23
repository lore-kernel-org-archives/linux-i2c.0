Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1EB34A765
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831756; cv=none; b=HcByL/2tdhh2gcsO0F07ySJ9znUH6YmqeNpV0d+RoWN0OfqkFo/3GeUiQ52zvstHEKlOdwGayoWIbaGAgUq8qDDU1kaOaO64C78rbrxGe6z4uZq0qUGcYuIhyoOwc1N4anm/iac3cV0Jod1MqzKc78gFWC99jh8LVux+SdwV6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831756; c=relaxed/simple;
	bh=bFi8UYq+Jz7bZ8mRheKvygjYVrr12Us6LVK+gr5p+RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz9s1cUDeMRu6FSsoqQBZe9hXQUgtTCaKAm4s6iSqt/wfvwLRA/H/aTJzIsglRlDROTujc3gNPSCQ421I0mkY5V1+JUkX3Jx9nDTP5qFAIaXzU1yqUYYt64lpOOqBwkqCt3/PbJ4ssrtmpYSjmtul23tc+j6EbIYyXYQKnoM7Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAi108jF; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAi108jF"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-387114fdbedso32619391fa.2
        for <linux-i2c@vger.kernel.org>; Sun, 22 Feb 2026 23:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771831753; x=1772436553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hbZ5b7ao+DiagEDcdfKn3Bm3NVsuaQOHTS0dAlMskSs=;
        b=PAi108jFDs0oGTTkZTYAfZaQI7PJDC7H7NlS5HaX3uYKPuAChkyGhBDnYYVy5QMF5w
         3/6FtPa7rBGIltxetI6c7TRlv1DlLMklzg6McuVe2jGk8vRtAGLFh2GarMvKy2L08a/E
         7MNwa+xOl2kICE3nggfhQ87812exOEn7+DMh8r8AmhXZiw+4zMHAqAbdTYptkhR1W3/b
         FTEAh4nHBoQ3wdI3e88bS38+FiZGFkFSSIB6P7F6LXE6VeuDNprApLsFlkZLfOn1GCDp
         5LHpym0CitHcc/EuRPMVMD6X+ziIZ6pt1z7rFPy4FMzAinro61YHRgmKwhpwxtazsGmL
         QPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831753; x=1772436553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbZ5b7ao+DiagEDcdfKn3Bm3NVsuaQOHTS0dAlMskSs=;
        b=WSW3FlBrhZ6o/qhjVD8vcLDWh4udHVFCEQBc+ShK6xqQWXJ0B5nEFCDH/lPFvTvxr6
         Dr4ui5/nbFojvvlzlTk4XzyN16HnriOEyNEYqdZtRrsaVGzlavIp+3FwyFeh8K95DFNa
         o4AcTy9xPKcQ2pAb/vjtkCsIPnHF6cVLLrlrgNJbtNf9tR2aitZX4apz3pt8n6qXjjwA
         ICZUvYNfbyKqQFcgh2ElmYrPsPi4abTFYbr/L4um4MsoTTJNXUmvndfb3YsccHBNO1gK
         39BAThYUuQspak+InWMTZpWyKIvKD4UDNF6Rrib2+NxcIXumk0bjLq0K4WzmtuUlpGgx
         R2fA==
X-Forwarded-Encrypted: i=1; AJvYcCUvvJniEs31DI69faf8ucLW74/zlIBg20czr731lER8hQ/MA866P52VqtWRPLAppsBHrnWIICMek28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9rqlAgt4jFdlFH1ITLbFL5b0wCbd7uAA5GVxg2Yh315jRE34
	tDrlPaQqr13pAGNTGDadhMGWN3ZG/b3ozcx/itTBB692ZCMPoKNGoS16
X-Gm-Gg: AZuq6aI4pnwgk6gJWsXXn0jniYxqqg8hixAdHh5IWAXp1kc99PqPtLZ31VuXVwJk+1Y
	he9h0y/9mSEgEhlAXRSzIMzMR3B/JqYQVq93uAt5mijQaQJttww3idLADUfuYbgTPIL42NQP1vJ
	brxAB78LQhPRkkG22+Nx2T0+csi6VQGulZidkcr9938f9dEQGXjqaIrOnt0E5NMlhM3fGjq5Zpt
	9VkTRqt3iI8NjM3nGc0epneBMfTKSMGoGdPLc0FsquAADnfARTSLVJj1/11Sh1JslzFHgRONYha
	03tYcFYGIKVTRQghVYUt5OHCQ3a4L7xck7CeMGUzGYX+oMVQz97QO1d6cSgtnwF56OTmA6QQaqB
	k3RrRBgbDunz1YDD5DMVxQATPTxM2Cuj5Sm5liBS3ReOYVoX87MJkaIsKLMOCste4gEQKwmjZBo
	JlqKQYLe0fP40WEbSC7oLnScr69e9Tz6rQNkmHeW7ioMw2uJfRZ3Q+Aqo4Cu6R
X-Received: by 2002:a05:6512:1599:b0:59e:645d:192c with SMTP id 2adb3069b0e04-5a0ed99c6admr2114208e87.24.1771831752661;
        Sun, 22 Feb 2026 23:29:12 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb45813sm1367725e87.64.2026.02.22.23.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 23:29:10 -0800 (PST)
Date: Mon, 23 Feb 2026 08:29:07 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/5] i2c: mux: add support for per channel bus
 frequency
Message-ID: <aZwBw4vSNO5YNQ1d@gmail.com>
References: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
 <20260216-i2c-mux-v6-2-9be28ecfd7e3@gmail.com>
 <ab7090f3-4c03-098b-b118-4cd7a68af8f0@axentia.se>
 <aZNm6LSK9C8DHC8U@gmail.com>
 <e21781e7-0ba2-19ce-3c0c-bd198e73c03c@axentia.se>
 <aZVkHoDsJc6CPszz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MoMPLdIF9j3bHqVN"
Content-Disposition: inline
In-Reply-To: <aZVkHoDsJc6CPszz@gmail.com>


--MoMPLdIF9j3bHqVN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Wed, Feb 18, 2026 at 08:02:54AM +0100, Marcus Folkesson wrote:
> Hi Peter!
>=20
> On Tue, Feb 17, 2026 at 10:37:39AM +0100, Peter Rosin wrote:
> > Hi!
> >=20
> > 2026-02-16 at 19:50, Marcus Folkesson wrote:
> > > Hi Peter!
> > >=20
> > > On Mon, Feb 16, 2026 at 05:40:37PM +0100, Peter Rosin wrote:
> > >> Hi!
> > >>
> > >>> +static struct i2c_mux_core *i2c_mux_first_mux_locked(struct i2c_ad=
apter *adap)
> > >>> +{
> > >>> +	struct i2c_adapter *parent;
> > >>> +
> > >>> +	while ((parent =3D i2c_parent_is_i2c_adapter(adap)) !=3D NULL) {
> > >>> +		struct i2c_mux_priv *priv =3D adap->algo_data;
> > >>
> > >> This assumption does not hold, making the cast pretty wild indeed. T=
here
> > >> are other i2c_adapters with a parent besides muxes. See e.g. i2c_atr=
=2Ec
> > >=20
> > > I see. Hrm, not sure how to decide if it is a mux or not. The best I
> > > could come up with is to look at the i2c_adapter.lock_ops. E.g.
> > >=20
> > >=20
> > > 	while ((parent =3D i2c_parent_is_i2c_adapter(adap)) !=3D NULL) {
> > > 		/*
> > > 		 * Check if this adapter is a mux channel by verifying its
> > > 		 * lock_ops. Only mux channels use these specific lock operations.
> > > 		 */
> > > 		if (adap->lock_ops =3D=3D &i2c_mux_lock_ops ||
> > > 		    adap->lock_ops =3D=3D &i2c_parent_lock_ops) {
> > > 			struct i2c_mux_priv *priv =3D adap->algo_data;
> > >=20
> > > 			if (priv->muxc->mux_locked)
> > > 				return priv->muxc;
> > > 		}
> > > 		adap =3D parent;
> > > 	}
> > >=20
> > > Or do you have a better idea?
> >=20
> > That looks fragile. My recommendation would be to avoid trying to
> > guess how a potentially diverse adapter tree should be handled
> > locally in the mux code. To me, it would feel better to introduce
> > locking/recursion in i2c_adapter_set_clk_freq() for muxes (and
> > address translators), i.e. take inspiration from i2c_transfer()
> > and i2c_smbus_xfer().
>=20
> That would be a more robust solution indeed.
>=20
> >=20
> > I guess an unlocked __i2c_adapter_set_clk_freq() is needed.
> >=20
>=20
> Rethinking the whole locking approach;
> If I follow the same locking logic as in i2c_transfer/__i2c_transfer, do I
> really need do take any more locks than the root adapter with
> I2C_LOCK_ROOT_ADAPTER?
> As the frequency can only be lowered, an intermediate i2c message will
> not mess anything up?
>=20
> If so, do you think  i2c_root_adapter() should be moved to i2c-core-base.=
c?
> Then i2c_adapter_set(_root?)_clk_freq() could lookup the root adapter
> and take the lock there.

I've reworked this during the weekend and think I've got some my
answers. I will send out a new version later today.

Thanks!

Best regards,
Marcus Folkesson

--MoMPLdIF9j3bHqVN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmmcAb4ACgkQiIBOb1ld
UjKEDg/+IBFMAKiHUARtHOWdNvNXagaezYzxvlG9U7d8nSHCg+2eZpqJYyjyBb1j
WGlrRz1xUjCVcP46qy0OOMof5l0tyra6E2+bVwBJ2V8Rg4msHLQ6Fq4mQZ0H2bKG
sGQyy0YOVzi3OppgDVthHyEbYB6h1PPKpGzyzHfdCoAbU2vlbhoK5ta/SNu49Hsj
RG7XoX66PCKEi8VIMmb+RbUHgzOVVmBe6Ycv7IvvDjMze92oudNu3BhUJugi6y7A
45WsilJKAC2SR6Wc6lWQPSZ/JH6bii9vCCealITbv1xdOGRWG7AJtnGXB0T86jPP
JyB0wguefWE8O1WmR+wZ+MFBdUQZyQ54fr3LNBcX3gkze82Yay3zhMCNbDToqYHl
o2aWR2LjMW0skWna3a6FlhEDh/reoNavq7ARKv+ANEP7VrZYEXZgrAfMSQZ0iy0p
AVZOEPVPilfnoaGo7DD40v6Gd41yHqjLuabIEfvb/A6VdTq/MZcV30eBeV/EyqVe
wdGTLFY+Ivm/GNJ2MMak/ju6zmfWzzVRj1ibZjEq5KtWaxiPSCY/ewxNWXXh+yQu
XQRqo643UB3plS3w4oTWGO4JtKDZ3B6vJKPKLlT4D4nUjOCCO70mxENNnfoSGOwn
DjPonu0VeDuVcASuSOJQ4/9bJaQ6sBWCtqn/EHWfKzi0mcfx2e8=
=514b
-----END PGP SIGNATURE-----

--MoMPLdIF9j3bHqVN--
