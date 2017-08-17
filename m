From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/1] i2c: i801: Restore the presence state of P2SB PCI
 device after reading BAR
Date: Thu, 17 Aug 2017 18:05:58 +0200
Message-ID: <20170817160557.dvhvkoprszbehos5@ninjato>
References: <20170814160450.21978-1-qiuxu.zhuo@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctpb6qm5zl6yzm6f"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60321 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752830AbdHQQF7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Aug 2017 12:05:59 -0400
Content-Disposition: inline
In-Reply-To: <20170814160450.21978-1-qiuxu.zhuo@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: jdelvare@suse.com, tony.luck@intel.com, mika.westerberg@intel.com, bp@alien8.de, linux-i2c@vger.kernel.org


--ctpb6qm5zl6yzm6f
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

Looks good to me, but I'll give Jean a chance to comment...


--ctpb6qm5zl6yzm6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVvuUACgkQFA3kzBSg
KbYDKg/7BMMBc5VeE2rDd0yEpb5fWhyCHU7KfvxsSuGhei+PCiOdmPySPwattB+y
hYgC58yzs3RbcTtSpI6ucB0aS6tqPP3K+7FwoSAXlHqMKB92i729nJqhUncqiEK0
1Qj0TAPZuTE2had2smw9nXgKs2g6lCwPyEkl3QYJg0x+I1oLbqarDy5d08VHSoE6
lMh8xgljtGQRqjQxxAeP7TOtu1hIm6yRGIDrS4HtrNNEpJZNgO771Bxz7hHbc4tp
VLlQmk2VZQhmf99qgzaVpLya+dEgYKXSULBKHvFx2oog7P6ixnpxhMJTpQBEscrV
aTBZnLMZfbaZaFUzSMHaGRSrhwFyeGqjDZhkXdVh6il7icKLEDAXAu3VJCD01Uv9
4jgFyGlNKTqBE3UAlUtKcu9G535TFxBy0NKuwLPpVRA2o0grKqhulgBNP/KgtlIS
x0exJcBwR/g526yrIjTsLESDFEDIPymSdD28A6A7i89dommVgU5g1Em/+4OqNDGa
OCeIN4Wpr3R2vJirKw/uGYqzcAcgkdzPYUiNiRUmdN9wMh5lC1W2qaue9dexw3VL
1Icouc6bBJuPc3+3x1Q2QSghjj+9763HawlUB0Nl9WlPNCTTQ/uGpu7bmiJx/y+3
TIvHBk62KS/1yeNQE00oPz/7SDI9/BUQicfnvy2DkKJI/Qf/IYQ=
=qKrN
-----END PGP SIGNATURE-----

--ctpb6qm5zl6yzm6f--
