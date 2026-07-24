Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6450377AB6
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784874289; cv=none; b=NVguylningeOp6q7i/p0fPN8r6mRtX+qMTumRRdC/ALNqzh1Vub5LhuL5wjrIyIZYRV8NAJL2NmCEQrSjRny8dG6yGF8mcB3ScNxMf218c2zWwfHIEH6nsVQq5+wCEbA0v/DinPj89tCVsDTFD4V1ZiZ1DJLQH1RXcKNZ0TDuOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784874289; c=relaxed/simple;
	bh=FOxqpoJy/A726CwPpj/qGjWc1Xh/yfrH1CaIv+t3Krg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MluR3xTwNuyOAK3bB4bg3m0K79nvmp5WvVFuHoHgCnGwxi7ljAFwuVK8a0EXF8te9kRWyYaJyQMWzu2WODihgM3fnjEyrM01pj+LkN8d7fIg7vJWBq3Al68c8wux4Yb3JbZuTeQA981SuygXh0downx6pUsMLbqiaFISFHIfvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHUpx0p4; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHUpx0p4"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c8dbf4ef0so602511fa.2
        for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784874286; x=1785479086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uk3RmzNM+4HATdUINCImQkM4yBkD8IUy+g/Mgaj5sVs=;
        b=lHUpx0p4IAaujuQzJ7mYdFQ8IRe8Mm44WMu7MAxAh9vYcw75Y8lH1/IhlOBlegosTZ
         5GrhahEJvVglwpNeHIO0O6ibwJXQSw/BV1XPYjlYKVWh1BaKr1GDpv17thNgUotIYLxu
         zionapARLMs2KhilEtTAP1Vt+TEyukcKvVw9N0rmwfpJhEMsJRn05R7ri1QNRSB5g0QZ
         wY9zeI6Lhxrd4zk9kQyoYOuHztplG4Pp8S1HH6h7ju5VgxVyfZB+Fup12nuP1xGPeQA9
         LLZOyCecF9AA2abj75yC9jo0LgICwmPVYWBtV4womYsGjjFCr0Jmpx4suVI+kehq+126
         9nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784874286; x=1785479086;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uk3RmzNM+4HATdUINCImQkM4yBkD8IUy+g/Mgaj5sVs=;
        b=iKgLJ90V8YERESaMXs4H3/Y/Qz7CBRvUMfKO6xagDy0htMavPgUS6BbpFLn7+4iEsv
         zRprz6tn1renw10OMGqFJz0Wmi4aQ0ZTF3DGKT2JOmr3UlKwqIIgy2Nr9oRb9syrFpFu
         iSeERpGfj+Xo9WRqLVk4RHiknK1lSUxhD2CNJ23+naWLT1ZJoEdhRt1SRDcb2kVOHyoF
         Kyw5XHgbUMt3J8swachggnOdJUP6cNkH9R6XO9ZUuZ6OOCsQzbWWDuuKvVKDSiHBGvsi
         cxtWy6WE/lxgWVXzWiSRyrmMNkepdlgxd2r+vHMKckQYpSYzwq7fOgmy4pYcNFk2/Nsl
         05XQ==
X-Forwarded-Encrypted: i=1; AHgh+RpD+5ZqkH2GvzG1YZ2edV+RRFhzCbuJevyOIY14Bqg8gZ7r7p8X3QdMt2xORHQElyq2mh3MUOvqBlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVA4qs0L3Cxs2tHaLA2Aa62qUxiRP93jZo2iU8Y1jkeN7pjGuU
	ECBPDZwIW73km8YtpWpn5I8Nc23giRetqrZO81WtfmhfoZ/1tEnqaTeP
X-Gm-Gg: AR+sD11ady+fmLw/FkVqQAlczr8FURtIaMrwVBWZMJEc/vN5n692y3VQm+mHA2tQX3y
	RfN3nD0JTHerBFbYsDYZ2n6oH9Y25k3CKqf6Y1dSt/u5kKYcTV/msaV7svnIv+3SJCrM84G9USO
	KIjkmsAI085hkj40tbkSsylc9BpqDpJml/5AYFr/PrPX5VQqVcsmVHCtnD5SQ7Ixu4vmZuuPti3
	91pvxe+bfEPxT8ixHQNCWN+BqoIoO4FJ1hcqbd9T2+OkestuydO5TevqtI0sMUfhB9klOzxf1Iu
	ZRUfC/VuTaZh/kV5WXmO5CexEKBhC4fksGLvyPo10mm2vvJJdp0ioCxEajeGjlSgKDQp0vWf1xX
	c481ea2eMsc64Lw4MWu/vQB+P03oWSUxN55XJUr8jy915eOlWfAEhitX0QNHBeGh612FkJG3/Pq
	qgKT9y1tJnwqWzzsm19nlwdZJ86uqGnYeba2gkKRY=
X-Received: by 2002:a05:6512:3f18:b0:5b0:1bef:2e9a with SMTP id 2adb3069b0e04-5b2b2f6c64cmr1248999e87.33.1784874285299;
        Thu, 23 Jul 2026 23:24:45 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9b8cd32sm1402967e87.11.2026.07.23.23.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 23:24:44 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:24:42 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 2/7] i2c: mux: add idle_state property to i2c_mux_core
Message-ID: <amMFKitmfeGqMxXL@gmail.com>
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
 <20260719-i2c-mux-v12-2-a5010d623a57@gmail.com>
 <d76f9802-5da8-4058-a6b6-4a782c1f2e3c@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tTt7g7QxyG1DLvq9"
Content-Disposition: inline
In-Reply-To: <d76f9802-5da8-4058-a6b6-4a782c1f2e3c@lysator.liu.se>


--tTt7g7QxyG1DLvq9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter!

On Thu, Jul 23, 2026 at 01:04:11PM +0200, Peter Rosin wrote:
> Hi!
>=20
> On 2026-07-19 16:59, Marcus Folkesson wrote:
> > Muxes treat their channels differently when idle.
> > Let the mux core have this information to make it available for
> > internal use.
> >=20
> > Possible idle states are:
> >   - I2C_MUX_IDLE_AS_IS: Leave channels as is when idle
> >   - I2C_MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
> >   - I2C_MUX_IDLE_UNKNOWN: Unknown idle state
> >   - <n>: Enable channel n (starting from 0) when idle"
> >=20
> > Default value is set to I2C_MUX_IDLE_UNKNOWN.
> >=20
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>


[...]

> > +/*
> > + * Mux drivers may only change idle_state, and may only do so
> > + * between allocation and registration of the mux controller.
>=20
> This is simply not true. It is a limitation imposed by your series.
> The pca954x driver has a hook to change the idle state at runtime
> (the change takes effect the next time the mux is deselected).
>=20
> Cheers,
> Peter

I see.
I will update pca954x driver to make use of
i2c_mux_set_idle_state()/i2c_mux_idle_state() instead.

As the state may be changed in runtime, I will also verify that the state is
allowed for the current clock configuration in i2c_mux_set_idle_state:


static inline int i2c_mux_set_idle_state(struct i2c_mux_core *muxc, int sta=
te)
{
	switch (state) {
	case I2C_MUX_IDLE_AS_IS:
	case I2C_MUX_IDLE_UNKNOWN:
		for (int i =3D 0; i < muxc->num_adapters; i++) {
			/*
			 * idle_state is incompatible with channels that have a
			 * different clock frequency than the parent adapter.
			 */
			if (muxc->adapter[i]->clock_Hz !=3D muxc->parent->clock_Hz)
				return -EINVAL;
		}
		break;

	case I2C_MUX_IDLE_DISCONNECT:
		break;

	default:
		if (state < 0 || state >=3D muxc->num_adapters)
			return -EINVAL;

		/*
		 * idle_state cannot select a channel with a different clock
		 * frequency than the parent adapter.
		 */
		if (muxc->adapter[state]->clock_Hz !=3D muxc->parent->clock_Hz)
			return -EINVAL;
		break;
	}

	muxc->idle_state =3D state;
	return 0;
}


Best regards,
Marcus Folkesson

--tTt7g7QxyG1DLvq9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmpjBSUACgkQiIBOb1ld
UjL8SBAAn9sqiep2ZxOIZiVpcYjHr3PN9JfZ5tyUvL3BoL6EVfw2m+AD78GkB2Aw
WM3WBkbEhA76yCcRYo4FDe3CmxJEaTzLzhGMoka+CkiMIJVQf3naFrhrJjcvD+bn
i99rZc9nsdPj51hafKHsA2smbMZVyYo6Om+oB5x8hY1uHLlHFStjJryg4Ew8JRIH
nLLAq/ezARds3v8KW9me8232YLZu4hotfQHP9+GJC/b3Xc0R9qNvlTqk5GQ5F1fO
oIs/Zj1aEy/KSpr2JDlpeNbFI0ogCkecrnnB3DSScau3cFao/CEUwu/bArYw/FlU
lfYpECOzt1QhBvzUR9T8be4QI7Tdxe3eLx6DQof8g4taL9nn/P2rTwiEbhHC4px/
kidsEltAj6m19DS3yWPbIsrQCOFy/UhsIX7TH2bci8hzcNXoSUZbnspT5fhkIhuO
JN9s2RrbO/YsIDAhiOWl1jbOM3/QJn8IvTCnYYhmRgnnnxy9f3dJWjcFCAo1148+
1++pE1c8Bec25hstlRNJk9+3ezhFYQNWvbG5TZgrQvGHT7I4uLuiFpK2MOG7P1to
RwZgF35SoabaucJsoRy2DxGYnNrxovPEufrKLJN9YB7D8xfohsnkQ1C4QAYokjcq
AmfIjfjVvK2EPceSpV6mhfOgRrC1ylfbf64SUlDNRdByvnbANiA=
=l99G
-----END PGP SIGNATURE-----

--tTt7g7QxyG1DLvq9--
