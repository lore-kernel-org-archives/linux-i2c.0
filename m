From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/8] arm: add I2C DT binding docs to various platforms
Date: Sat, 1 Jun 2019 13:40:58 +0200
Message-ID: <20190601114057.GD1993@kunai>
References: <20190521082137.2889-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6615525343984428413=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190521082137.2889-1-wsa@the-dreams.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--===============6615525343984428413==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 21, 2019 at 10:21:29AM +0200, Wolfram Sang wrote:
> Some I2C drivers entries in MAINTAINERS miss their DT bindings docs.
> This series fixes that. Because these drivers are all embedded in their
> platform entries, I suggest the respective maintainers pick them up via
> their tree. If you prefer that I take them via I2C, let me know.

Series applied to for-current!


--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzyZEkACgkQFA3kzBSg
KbZBKQ/+J6xdC3F2JIYkJ0e0Ru0FGHiSqVM11jQh/EUyMUWXXwTdyNBO3qyENIEO
sVFLcJSINSMYWAEB2KR1qnhCYC8JVNSmhy5/hbc5Qhl5AOAQ6gv7m2zEnX0R3S0V
dJc0+xXhOQZWQZdG033+MAKdlMcz+1EslOs4JnHCWBQcT9saB3jlk2zEY1VLnJEK
xgM/TvQGA3WL1FNtHBn7hdb0ZmcxBlIeHvW7WefoVLCeK2r+05k/UzfW+pDMhZB5
+K7uU4g9wyXA1U+KSHtnZyqUtv2XxnRHMNdwG7LMHq5oTLynqu168odEkTDMaaI6
lXjqMIN9iZVD5OqNbugLbVHBSdxcmFqcmvUxXtQhL2/+tH0x9c2BFPqqlB0BhcVm
uMwGwkE5AQbO/Foide6AOBtHAXrjCy2pZPbktW2BQIE2Cc7VkIWRo2URZsdrS+nL
t8cgYYMDi3dIlfdU1n1KMyTuO6fspbTPHa8tP0dDlux0o6A38yRLbTWs1VFimhS/
Y0+nkBY0oCbmoBXcEwGr1iSkby4MJRxzwj0m850k6rCtq8kMziBgJVetzHHPoRU3
gjgCgr+LMqwItJ79LeWv9nevjJIwMLhxuq8ivzGMOT/udJTUSZ41laXY2kv9ZXsg
O1jQhoR5bjZrCZ5GIeJ9MJfdSHIG3vUUf1Fl/A0QrzDJFgIgljY=
=zv7P
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--


--===============6615525343984428413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6615525343984428413==--
