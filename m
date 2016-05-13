From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V2 1/2] drivers: i2c: qup: Fix broken dma when
 CONFIG_DEBUG_SG is enabled
Date: Fri, 13 May 2016 13:47:17 +0200
Message-ID: <20160513114716.GI1778@katana>
References: <1462534274-28925-1-git-send-email-sricharan@codeaurora.org>
 <1462534274-28925-2-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJWb33pM2TcUAXIl"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462534274-28925-2-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nkaje@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--uJWb33pM2TcUAXIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 06, 2016 at 05:01:13PM +0530, Sricharan R wrote:
> With CONFIG_DEBUG_SG is enabled and when dma mode is used, below dump is =
seen,=20
>=20
> ------------[ cut here ]------------=20
> kernel BUG at include/linux/scatterlist.h:140!=20
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP=20
> Modules linked in:=20
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0-00459-g9f087b9-dirty #7=
=20
> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)=20
> task: ffffffc036868000 ti: ffffffc036870000 task.ti: ffffffc036870000=20
> PC is at qup_sg_set_buf.isra.13+0x138/0x154=20
> LR is at qup_sg_set_buf.isra.13+0x50/0x154=20
> pc : [<ffffffc0005a0ed8>] lr : [<ffffffc0005a0df0>] pstate: 60000145=20
> sp : ffffffc0368735c0=20
> x29: ffffffc0368735c0 x28: ffffffc036873752=20
> x27: ffffffc035233018 x26: ffffffc000c4e000=20
> x25: 0000000000000000 x24: 0000000000000004=20
> x23: 0000000000000000 x22: ffffffc035233668=20
> x21: ffffff80004e3000 x20: ffffffc0352e0018=20
> x19: 0000004000000000 x18: 0000000000000028=20
> x17: 0000000000000004 x16: ffffffc0017a39c8=20
> x15: 0000000000001cdf x14: ffffffc0019929d8=20
> x13: ffffffc0352e0018 x12: 0000000000000000=20
> x11: 0000000000000001 x10: 0000000000000001=20
> x9 : ffffffc0012b2d70 x8 : ffffff80004e3000=20
> x7 : 0000000000000018 x6 : 0000000030000000=20
> x5 : ffffffc00199f018 x4 : ffffffc035233018=20
> x3 : 0000000000000004 x2 : 00000000c0000000=20
> x1 : 0000000000000003 x0 : 0000000000000000=20
>=20
> Process swapper/0 (pid: 1, stack limit =3D 0xffffffc036870020)=20
> Stack: (0xffffffc0368735c0 to 0xffffffc036874000)=20
>=20
> Change allocation of sg buffers from dma_coherent memory to kzalloc=20
> to fix the issue.=20

This description describes what you do. But not why it is the correct
solution to the OOPS. The OOPS  neither describes it. Please add some
more explanation.

>=20
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>

--uJWb33pM2TcUAXIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNb7EAAoJEBQN5MwUoCm2DksP/1J0Sc5DKbPZBAW9nt9Ifh9R
Tfjsz0zwj3F+NcYcOB03ZsxvK6iXOUu/1OYBJDwWIbRbP98HJLyNlk5dHs2X6Vje
POIEuzGFsyU2z5xdOBBl7TBjqzUBYP+X89ZSWIOMipoZAaz0OT95M3oSUYHg8XM4
00/hWo2M/0PYIgZSWerZhR69pCbvWpXy+7pHERNCzj+5Ua5BJ+5+fPgcFdEdeK/T
XEV1tSaOeVLgR63+61l0/IF/d08BL2mDVU2E4G230KdxAvu8+UzvPWoUavPDDg+I
nJjOlTao2t2Ie4lqBN5/EWTuUMr1DRxTe1nAsFZdT11VgGrUA977lgR100d5oA+V
Bf+gFSgXEnCGiRHXavXDCbQGA2+sxWR0a/BsDPBm5omUc9oLe2b+Fs+Wtc14iZ3M
uA7HHYOQ7g4+6XaDYzrZy6E/F+eoAQwB1YzIB0p57Tuj64MGePL5rz1vz3neBSqC
JID4k7RPXflF0ndSaBKx1KZpxXVEqoedYoyK53GC+0svDk9eg2t7b4TO9ZqE2wW+
DSrCF7YLhZAhtPPVjwDB8nt2EpLTqfrtkVJm/1M0I3tXVCvYpKSYEiC68r3P+B7x
HkPFqQ+mJ4zUXDRfAfoQUMRQeGJds8XhGrZCljtd1qP4vxN6SfB+MkncdffYYMk6
43UyC40rLdrHYiJoEwXP
=8RYs
-----END PGP SIGNATURE-----

--uJWb33pM2TcUAXIl--
