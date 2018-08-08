From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/3] i2c: Add helper to ease DMA handling
Date: Wed, 8 Aug 2018 22:57:53 +0200
Message-ID: <20180808205752.llowh4bvu2wkuhga@ninjato>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
 <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rp4jubaesdmneqdp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--rp4jubaesdmneqdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 07, 2018 at 05:29:54PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> This function is needed by i2c_get_dma_safe_msg_buf() potentially.
> It is used to free DMA safe buffer when DMA operation fails.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

Right, we need something like this. This leaks in the sh_mobile driver,
too :(

I am still thinking if there is a nice way to put this functionality
into i2c_release_dma_safe_msg_buf() itself somehow...

Thanks!


--rp4jubaesdmneqdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltrWUwACgkQFA3kzBSg
Kba6Tw/+Iimt7Umis4CVLfglXlJM8cOcQwzHzSmtfK88GLGEPybXuZuk6hJ+2G1m
p964DyDxJy+DCrdA7jIU64RdFOuf62+nZVRS0xt50Ycl+OhayWr9FL5teoFZ+uSn
EKU5MnhgnO0MPG05JciJGS7SM5hFbT86n70ktre589BT8g7QnV7sO1BVi5LDoyPL
9zCSYFCYZZ/+gfP2oMtSJT8LkHgSEYz9JXCWmANs/HhWepbtemQRJ5rvPens7yCa
xq/OkH7NoIJ9Ipewv/J6RJJsZBw7bXPnfp4WaHIvZog0WZHYJkSbQk5DDNgIYu3T
Z1lRM8P1eWn2dhYSPrjv8k+FFFX1O5rM2uCkATDZierjJSa4wgYVanizY7TP28km
dfXlL/Vb92KZICGQBBG3gbe3ueWoNxUmSljMn7rUKPybJ+P1MYZHk6TF/momdpDx
SLKwhU9PaKy/9dukiU8L+vWcgw69ic7RHbKV84EwxhjDX6XhexPI2H4L+uOfyJZo
UplbqRhIOXk1h5tbk1m6NJAVlFFSGcWNvdR28+CQl9LBBnOWR6vWYspYrERLrXlu
+rISW9VO/G5F0CZfZ0Eka335h8c1f5ybq84pWk1nPRn8RmSmn+hgWiHEdzZJV632
4WmPNIK4ZcTX85fahz06Z+RRk6Mn60mQZzjzzgDr9Q+PimU+e08=
=9FC3
-----END PGP SIGNATURE-----

--rp4jubaesdmneqdp--
