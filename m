From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V2 08/13] i2c: bcm2835: Avoid clk stretch quirk for BCM2711
Date: Wed, 14 Aug 2019 21:36:28 +0200
Message-ID: <20190814193628.GA9756@kunai>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
 <1565713248-4906-9-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2035514635061752623=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565713248-4906-9-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============2035514635061752623==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>  static const struct of_device_id bcm2835_i2c_of_match[] = {
> -	{ .compatible = "brcm,bcm2835-i2c" },
> +	{ .compatible = "brcm,bcm2711-i2c", .data = (void *)NO_STRETCH_BUG },
> +	{ .compatible = "brcm,bcm2835-i2c", .data = (void *)STRETCH_BUG },

What about simply putting a pointer to the quirks data (or NULL) as
match_data? Then the code should be:

adap->quirks = (cast)of_device_get_match_data(&pdev->dev);


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1UYrgACgkQFA3kzBSg
KbZicw/8D/a+41Fd2Vuyx+MJvKd29Kzaki6F06fwRq1DQJHiDcdT2eo/uY/EOfQu
efWgwaXvbFL54rj9z9u7MnV3xiImwyBDVQcJxetbTiZm5Jo97aX0cxH0CgeoF28+
q/sW/LZrLjWkfkPFQfDeV59OjvZJzc08AE/MAxiKj7dESO04mseoSCOYgRfcVLYS
mxbciN02zVQoVjpjzO+hgMCH44dkxIVJc2Xlf7NaotrVIzNYxBPzr3D2IjGqL125
WwHQUohUIxATEeTvipI6sob6/J5DGhoOCQL19fgBM7zAZas6V1kvu0lXGGhPXiCI
3d8ncudBanDh8Foqok0Fk0nC8jrtAfr273XRtMBlyQinD6BbAHGUeUBF437r82Tk
OSHL4lCCPUpT/sIthYcrRZGo5c1MKzWuVmdAE7pv2fYgM0GfozIfrHVZgsg30vNl
m/JIbmBjhE9rdhKcCCZMRkuOA0Q85ow5Jdj7z0xoXEn1ZGJdrJnuGjWyclsF85wP
wWMJD3vU8kllp+TobcsNPUUBzV51UuaQjHR7Is3/tM3ObCnJPlxKQ8ZiSfFJwAVs
oOKTpUihBtF5vOyxZlpXWumZhS08zGNrkz4nx8M27vP/TlcrNqV6gyM4QuHBt1TE
fcLZNAzsbxJHjquINMgTchfVqB3tqlIAuwK5nCs31kKojAWmxN8=
=K5pw
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--


--===============2035514635061752623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2035514635061752623==--
