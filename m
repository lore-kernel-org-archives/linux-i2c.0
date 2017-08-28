From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/1] i2c: i801: Restore the presence state of P2SB PCI
 device after reading BAR
Date: Mon, 28 Aug 2017 17:33:40 +0200
Message-ID: <20170828153340.cp7negyixh756uoj@ninjato>
References: <20170814160450.21978-1-qiuxu.zhuo@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k4cypdeaha3oo3iz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40978 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751259AbdH1Pdm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 28 Aug 2017 11:33:42 -0400
Content-Disposition: inline
In-Reply-To: <20170814160450.21978-1-qiuxu.zhuo@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: jdelvare@suse.com, tony.luck@intel.com, mika.westerberg@intel.com, bp@alien8.de, linux-i2c@vger.kernel.org


--k4cypdeaha3oo3iz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 12:04:50AM +0800, Qiuxu Zhuo wrote:
> Sun, Yunying reported the following failure on Denverton micro-server:
>=20
>  EDAC DEBUG: pnd2_init:
>  EDAC DEBUG: pnd2_probe:
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_tolud_pci=3D00000000_80000000
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_touud_lo_pci=3D00000000_80000000
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_touud_hi_pci=3D00000000_00000004
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_asym_mem_region0_mchbar=3D00000000_000=
00000
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_asym_mem_region1_mchbar=3D00000000_000=
00000
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_mot_out_base_mchbar=3D00000000_00000000
>  EDAC DEBUG: dnv_rd_reg: Read b_cr_mot_out_mask_mchbar=3D00000000_00000000
>  EDAC pnd2: Failed to register device with error -19.
>=20
> On Denverton micro-server, the presence of the P2SB bridge PCI device is
> enabled or disabled by the item 'RelaxSecConf' in BIOS setup menu. When
> 'RelaxSecConf' is enabled, the P2SB PCI device is present and the pnd2_ed=
ac
> EDAC driver also uses it to get BAR. Hiding the P2SB PCI device caused the
> pnd2_edac EDAC driver failed to get BAR then reported the above failure.
>=20
> Therefor, store the presence state of P2SB PCI device before unhiding it
> for reading BAR and restore the presence state after reading BAR.
>=20
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Reported-and-tested-by: Yunying Sun <yunying.sun@intel.com>

Applied to for-next, thanks! I don't want to apply it to for-current
or stable without Jean's ack. So, let's get more test coverage first. It
can still be backported later. Hope this is fine with you.


--k4cypdeaha3oo3iz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmkN88ACgkQFA3kzBSg
KbZdVA/8DN6/9bUNu5BR9QvsXObPlb/uta2oqm3UtpwDJtG0D3ES1uwPqmS4cxH3
AIJsuFkN50UiyEGYSBY7ODaeW1dn/E3pm5Et6FuUMkOfsBu6fsIOgCUGk38Gx+TP
AxQaTFXEQlPBd62APt4QyeczFbVa4/fUa+iRvD3lycqmw9Y2O4xAlOmb/eEtp7B3
/rPZrLbZQENBPwiLx5eziZTam8/5cPFYyXX+PggI3806agd0FHtYADvUwn9sHwY+
/d8mv7aVQFIjwMspgSzA+Q3vfS5WKJzk5rCafFsoBhieXwcfOAjVn8tXjTmacG5S
9S2F9da6PT2ooMdDZ1A/jlr/0Nu96bplt4KtNArE8ipj6/tsyijf31zdwS7ymJbx
6ZZ0pmV+AodAR8nQjFCUWYg6bKozq8LfiO51+k+9T0g50Cx+iYyioOtcA+9GyfAn
xlKOqsAz4QCdNAfwxsnOOYs18jnf69uTUHsZSdRg2coMMjAQaBnbs3DhFltDV9Ck
Eco2QRnK15yQq/6ENUaM4CLJfvpRhfZCfLpuMGWmgshyY8ufphvvHMmNTOT2NbLw
+8nkfYVGY5q1ia6PR6pw80hfoyeYt1hzJ5PgBIMq32vU/85RO+Pl7uaxlZjwdMjJ
11v+v+PiOGT2heLLOPJ6BjPfalaOKALF5m7rhd6gbl/Qt4Q5c6o=
=dUNh
-----END PGP SIGNATURE-----

--k4cypdeaha3oo3iz--
