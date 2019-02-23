From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: cadence: try reset when master receive
 arbitration lost
Date: Sat, 23 Feb 2019 10:48:43 +0100
Message-ID: <20190223094842.GF1018@kunai>
References: <20190219012447.5900-1-sxauwsk@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219012447.5900-1-sxauwsk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shikai Wang <sxauwsk@163.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 09:24:47AM +0800, Shikai Wang wrote:
> When the adapter receive arbitration lost error interrupts,
> cdns_i2c_master_xfer return to the caller directly instead of resetting
> the adapter which resulted in the adapter being out of control.
>=20
> So when driver detect err_status such as arbitration lost,
> then try to repair and fix it.

Just checking because resetting looks like a big hammer to me: there is
no way to gracefully recover form 'arbitration lost' interrupt?


--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxxFvoACgkQFA3kzBSg
KbZIOw//X4tPGtaKdCAKY08zneHiiw2dqMHmf69zg2wD7wYcSKApFyY0SdxqehEm
Zv68Ud90qMfJ+Aecvv1t5zRgwWQPNJSB6f45ujlRAdn45VKtHlMAeiyk6VYelNwX
Bx2GXX7ZedpfkmdMGEjiPRsKuHX84kug+xlAHeT5mjGJCjDIrGkZdOSuP3DTDCCM
wzLQ1U8yo9DyfNr8DerZ+co07r5Bi7JXwZdHJ1CoI59DS0gf1MnyLj1+dhv3eVU2
TVz13o0m6QO3kT1eGrDaVl4SskXBAL848Lc6r0DnkxynQs/EiosI+QwbziLZkPr2
FZBFk93NoHVJAlSYSFgpbzvWSxiHUy9pknoPTIgz0f0c1/3XmMjH2ziFALy7Uar7
T++7N8amNhDdt8GbsyEmAzIyLuZcaulLk2vS30cjTJG+Ve9crSpSDJRiMyJ/436U
WU70k9WuIVG7gwiO3PgXrxon/bu4O3bhQAIJT+Tj2lC6iOj183GJW/sxwj1Pbtb0
/iPQA38/G94zqD9lIyhfdTmsXIOJaGgaCXGlqK2TiK3idxqOuvoxVMRJFhoUb0xJ
hKHB8QVoMX0K6SCMh9Lsif6ubum0wrkP4+LFoDq1PDSDU5zlpv0fxUjrJW8p9qhm
Gp7eN5oepPgSVV51IHbbAxu8h5X8wkt2Pho8WjvZY5xwlvmty0k=
=arbP
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
