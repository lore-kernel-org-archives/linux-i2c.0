Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794065860;
	b=sJiDkNkcp2HexfHBUpCWU1qvU+2Zm7z66qX1eSmC4sZb/M9ixdyX75BPQRtxyxyeW6rQ
	 b4tNzvZi+vbHQbTK9m4AlD3AwOd7HdoFyjf9+VhZhceeiY+OPaUnLUVd6bN7jtMUoqLP5
	 exOmrlYc5dqXrIf8CB0fHMZlojJ7qG+827fHczZYsJ2A0P2HR6F/Pw3ZaPo5t0fsj+ZEa
	 UW2exfqkZxgY7U5FrOis8yrh4I0rW0f+DQ8GKnm56T/Dn7v7nJE5CDsrT4clkNrg/CRMO
	 PpYEc59DmeqhsTdZNNKeyizbJQby5lokLgtC37pIeeRNMywL04yk2GtFXqvx5lSwPoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794065860;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=kNaslowQoeUv0bfP4j0Xm9HOBoRuR1efd9BxtBHbpGQ=;
	b=dlTSNuhYKSf5MPFN1Ahftch9vhnSZBUth2AR6XHhpSURPTkNRUkmrrPXaYXjGxGU27qv
	 pkLFDgeNFkTkfVPnNHIRZ0tX4bGPdYkzH5cKYw4mnUBxRPCe+vgOkN9aQI8taS1Puv/B/
	 S8MV1qJeXCPwb9UQt3FMYLopAhCSgZSKG0xdoRvo7N4G6LuZGOSGVmVWVm4s+qYTIOYTZ
	 THX9KcC3f2oadPndcuaBTuH99be13y2mNijJkxyyRhyMyHTgDgi5wU/V3UsEMqvJRU0lP
	 d3cClU3zlu2v39R3VYvLiIXBpl9ffGMGy6DKdXOUOTeYPyykfBoZ9xH0N/3R9zzbYPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=AeaqMbG8;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D160A260B
	for <linux-i2c@vger.kernel.org>; Sat,  7 Nov 2026 15:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D97D160A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=AeaqMbG8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=kNas
	lowQoeUv0bfP4j0Xm9HOBoRuR1efd9BxtBHbpGQ=; b=AeaqMbG8y/YS9tomKvny
	XqNLEBDcn0nymD5CDoJ/H246icerH6id8jJ6b9N3gy8tEb8eLT8QZlGIC2FL49yD
	Z6XvzB5gvZKAf/+3SvT+hMO/kjoPYZY2m24vg8L+RuViClFxGJqBQFZTySXG89gU
	kNDjx2FCCM9BzcMrEmEr9Tuj+ySo2Qr/y17KCoyOvQZlu/+A4g1VYfqowLCVyTMs
	3Rj+8hsT1bssxPFdI8f7jUdub39By8xq5ArEsE84f3FxAturutSNy+Ugcus/bm0u
	DvILwGR/X9cTfcgnnyTQkiB9lEdwV8edjwNot568thRB4Of3DQWALax+XWHqqxa4
	og==
Received: (qmail 2547555 invoked from network); 7 Nov 2026 16:37:32 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Nov 2026 16:37:32 +0100
X-UD-Smtp-Session: l3s3148p1@kO/RgbFf/MQFFu4l
Date: Sat, 7 Nov 2026 17:37:31 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Umesh Kumar <ukumar@marvell.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	bbhushan2@marvell.com, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] i2c: designware: Enable SAR in slave mode for
 Multiple SAR controllers
Message-ID: <au9FtxBvemLIa7S_@shikoro>
References: <20260804041842.3205356-1-ukumar@marvell.com>
 <20260818144306.357243-1-ukumar@marvell.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="otxvpO2v3blHEoyL"
Content-Disposition: inline
In-Reply-To: <20260818144306.357243-1-ukumar@marvell.com>

--otxvpO2v3blHEoyL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 08:13:06PM +0530, Umesh Kumar wrote:
> DesignWare controllers synthesised with the Multiple SAR feature (e.g.
> Marvell CN20K) gate the primary slave address behind IC_ENABLE.SAR_EN
> (bit 19). Per the Synopsys DW_apb_i2c DataBook v2.03a (Multiple SAR
> feature), when this bit is set the core acknowledges the address matching
> IC_SAR; otherwise the address is NACKed. The slave enable path writes only
> IC_ENABLE.ENABLE (bit 0), so on such controllers the target never ACKs
> its address and a remote master cannot reach it.
>=20
> Set SAR_EN together with ENABLE when entering slave mode. The bit is
> reserved (and ignored) on single-SAR controllers, so existing users are
> unaffected.
>=20
> Signed-off-by: Umesh Kumar <ukumar@marvell.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Rebased to top-of-tree and applied to for-andi.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--otxvpO2v3blHEoyL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrvRbcACgkQFA3kzBSg
KbZ0kA/9HOpfN/5gR7JFrLk4jTuxgQt+7c1i1XxW67VAhV5ZKDSofwJDgnWSbfen
OZWWLEob2CoM0NKUrzebP+rRFG5MoCGEZIgEqCvX7OrhBRRDyIzcqd/FrC/PKOSs
kwlnQZlzkB4j2Jf4CIxaufvnFahkUQ2b/INcKSJuD7qnddNDw9GVhFMJfZSZ+Pmm
NQ4qYcc53O5jflaFVcA9lSnW/mDpHZm1dVnvH0IH2kj3dlJC/loPczOnK1KGquNN
h6/v50uTNdav4298nBbMo8igleloGUNS6QjlkVO6+UTG5KkKr5pu+/SVnV5iojSK
16cWgx4LLC5ndiw7I7JCpkdPEahpKytY1cpJmt9rlYWuuepUe7/nLdk2HUlmor8V
iLrY1HrqvBbrDtbsMAyRkSX+mHSpS+7v2tNwQkuPjPW7rJs1CrQ57jU3lYChzoau
s/LfzBL+Sxb3UhdgSWnkvifrYLCVHr7XoL9yzhjr0afpsUEZx0MVaBS5bw546Aax
G7ZKh/BLJQsy9sDzVbgSaJmZfD/liTfJ4nZJKVB7aNljAGyZfMvnFvGeJsRPFkbV
GCXFkN+WL/H8PerQ8H4Wp2AA5+xJHNzDra9PmVWakLlHS19C4CbkOaQvK/qGaplz
hFp+x2qdz8a5s/lr1gV/LJsgGamCd7b2UrCi84Ae3d5lN0teoGs=
=DoK9
-----END PGP SIGNATURE-----

--otxvpO2v3blHEoyL--
