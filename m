From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] misc: Drop owner assignment from i2c_driver
Date: Sun, 2 Aug 2015 00:57:44 +0200
Message-ID: <20150801225743.GC1528@katana>
References: <1436509397-27721-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436509397-27721-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Eric Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 03:23:17PM +0900, Krzysztof Kozlowski wrote:
> i2c_driver does not need to set an owner because i2c_register_driver()
> will set it.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>=20

I took the liberty and applied it to my for-next, thanks!


--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvU7nAAoJEBQN5MwUoCm2zFYQAJyXCSwEKbtJ942h5bGE7Kej
sXlGj6Tslx0cfzZTUrZzf1DPmowUBREjyZkNWBo3H8LrJwne7dIZ9D8KOmK/eDkN
1enBQpAQDmFis7XdnEy0Dxdgl5UmZ4lYjFgw8JJzrVYGP6n18jzPjq8bRfxNZoYw
lk2/6X/oMXxegB253bl6GPS2mnBkLRx99TuxMcXNlVcP6amUrFi+HaxkFDGikisR
IJbVjoVBX48WiFMwEY4W/kdBavZMxG4YNdbzXm71JPA0U9hMUeNopHdumaOQRyAP
Q0CfJO98J1wr20MK1ENeWpxXHeRVGqz7j0eQPuE+CMDZoXvDr3+mv+TaDYgO1f6E
7TMMJ/4ozg3FOWJmfiEoBHcCmvlcXmir7hn3/0PIFL4BaJReupLy2qhKH32dEc2j
yJFuJy7cRLCxWBuCQEIOPSpTNPc09TcGog1amltFOsX0dTlVtfNBGr6CrjrqszPT
hCJ56bVK4O/l7aI7ogMt/Wi7iQeQvUByYg3wOq02YPR6YPM3772QnQVtn+M91Ugn
vqD++QmAoTiAqMlmhdwgmlEB7Smhslikqd6HgE8j6kOzN5WjUM4HRKu9SB5iJN1M
MkjCLMBJn64OQ0IXUeC8djehM8wjlUPn/CxlgoIBnmq1cuQ0+pzDU5t5Yc3YKvn5
0qid8j54yn1exUTB1C/c
=+d7h
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
