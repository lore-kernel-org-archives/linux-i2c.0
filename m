From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
Date: Thu, 5 Oct 2017 14:01:25 +0200
Message-ID: <20171005120125.nnhomwg2e2twbaqm@ninjato>
References: <20170916030252.10680-1-amworsley@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zklvukmqjq6mzyph"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39148 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbdJEMB2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 5 Oct 2017 08:01:28 -0400
Content-Disposition: inline
In-Reply-To: <20170916030252.10680-1-amworsley@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andrew Worsley <amworsley@gmail.com>, michal.simek@xilinx.com, soren.brinkmann@xilinx.com
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org


--zklvukmqjq6mzyph
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2017 at 01:02:52PM +1000, Andrew Worsley wrote:
> The i2c interrupt handler was not checking against the length of
> supplied buffer so if the hardware supplied more data than requested in
> the i2c transfer it happily copies it right past the end of the buffer!
>=20
> Signed-off-by: Andrew Worsley <amworsley@gmail.com>

Thank you for the bug report. I don't know the hardware in detail, but I
am a bit confused...

> ---
>=20
>   This bug reliably caused a stack corruption when the hardware provided =
more data than
> asked for in the i2c request. The hardware (a tpm) very occasionally appe=
nds a burst of
> 0xff to the end of the data requested and the i2c interrupt handler mindl=
essly copies all
> the data right past the end of the buffer and in my case across the stack=
=2E :-(

=2E.. because you as the master should have control over how many bytes
you want to have. If you are done, send NAK+STOP and the message is
over. Is it really the device (which one is it BTW?)? Or is the FIFO
handling of the master driver buggy?

Michal, S=C3=B6ren?

>=20
>   With this patch the transfer now terminates with an -EIO but with out v=
oilating the
> buffer boundaries. I would prefer to just make the transfer succeed while=
 not retrieving
> additional bytes but I wasn't able to find an easy way to do this. As thi=
s is definitely a
> fault that causes a kernel oops I just wanted to get a fix out there for =
others to avoid
> the problem as it has taken me a few weeks to chase down this oops. If so=
meone has a
> better or nicer fix I would appreciate it or a pointer to how to do this.
>=20
>     Thanks
>=20
>     Andrew
>  drivers/i2c/busses/i2c-cadence.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-ca=
dence.c
> index b13605718291..c1f61ca6843e 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -234,6 +234,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
>  	if (id->p_recv_buf &&
>  	    ((isr_status & CDNS_I2C_IXR_COMP) ||
>  	     (isr_status & CDNS_I2C_IXR_DATA))) {
> +		unsigned char *p =3D id->p_recv_buf;
>  		/* Read data if receive data valid is set */
>  		while (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) &
>  		       CDNS_I2C_SR_RXDV) {
> @@ -246,6 +247,12 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
>  			    !id->bus_hold_flag)
>  				cdns_i2c_clear_bus_hold(id);
> =20
> +			if (id->recv_count =3D=3D 0) {
> +				pr_notice("%s: i2c receive buffer filled : %u aborting transfer %p -=
 %p\n",
> +					__func__, (id->p_recv_buf - p));
> +				break;
> +			}
> +
>  			*(id->p_recv_buf)++ =3D
>  				cdns_i2c_readreg(CDNS_I2C_DATA_OFFSET);
>  			id->recv_count--;
> --=20
> 2.11.0
>=20

--zklvukmqjq6mzyph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnWHxEACgkQFA3kzBSg
KbZhMA//TYM+nPLVCCZ/aiJihpm3iVszslW8aE+Royk7/EXne0gW6/NkIUgmUISU
SRAwd/bQsqvGRzDFcY18Dv0YM/my9x0Xm3PyuJy/SIB22njzgZs0txJtVcgFPD8o
dKpU3K2l07c6OEFtdD5Rcj/gtb4wscdn0iS+KJxyRdjNkVrPPUT+hiPJHiccZFIK
hRRk3z5dMIVGXQkxB/ZZRS+5CONm1pSpCtV3XIZsfZgPO78Lvox2GbpjZSqqe+y8
hCymhgawxLanzcEdNvo38hzXG7ZLmdJ6w6A2fmOD1cqJLOzYTkj2iHf/sTQsio51
+ovwj3OdxfzNR5ct2KAJaLYTBFSmj0RXPhIaQZEqV2gtOtk3Rse1EThIkqtY1qZw
1PWehFqmtkgo2wKnJ+z4JCgSj7Hy1zEJX4goIMK0MEKj5Y88/5RP+3/BlE2ZMU9u
6SRoaOE8BtyoRFxMxCm66NuGENTSozHZdFEwDFzxgnR4SQx7fNwFEWcnJ0hHKJzI
sktGd65OOdF89n9BP6Jcno5nK36rAWjXSL58jbNZ+n/7kUibb1yTsyYauFbCC3v1
TcEfD3fkSP9VoZubJNaj7B2tfo4N3Oy5Gc45tMgsVboLgy+7EwKDFQ3WT8DqpZ1T
lP8NEl7UuNytEMqxUpOhQ6kPXIe7v14B0CwZtxy8HDpLaDNCi0U=
=6w6Q
-----END PGP SIGNATURE-----

--zklvukmqjq6mzyph--
