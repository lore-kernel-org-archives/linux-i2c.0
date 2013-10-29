From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 03/19] i2c: sh_mobile: Enable the driver on all ARM platforms
Date: Tue, 29 Oct 2013 10:43:56 +0100
Message-ID: <2015733.JNqH7MboLG@avalon>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1383004027-25036-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20131029050337.GB2643@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2262444.VxEEmQHS6F"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131029050337.GB2643@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--nextPart2262444.VxEEmQHS6F
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Tuesday 29 October 2013 06:03:37 Wolfram Sang wrote:
> On Tue, Oct 29, 2013 at 12:46:51AM +0100, Laurent Pinchart wrote:
> > Renesas ARM platforms are transitioning from single-platform to
> > multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> > driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> > and ARCH_SHMOBILE_MULTI and increase build testing coverage.
> > 
> > Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> 
> I wonder if those two Kconfig patches couldn't be squashed, but other
> than that:
> 
> Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Thank you. Please feel free to squash the patches together when applying if 
needed.

-- 
Regards,

Laurent Pinchart

--nextPart2262444.VxEEmQHS6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSb4NcAAoJEIkPb2GL7hl1UyAH/28uKvrf5Mt6qVWkpO/jzfDw
SWYHRdiGk6rf5L4aQw1E8wFHCCBXfQJrhidBEmr4BwtJjCfafZypSATQhpoZBmNb
ATxWQB2kzsGDlWR7yri5DDWVfsOUiKo2zHwIsAutVsvxWWKBWWuLKq7eAVctPRAX
uZbejuJC4JIqlEXLTcgUmgvDkVFPZXt1q8WxeNMtoVTkXfAYrN568GrMEa0FGNpx
rgB4TacNzYdChrFamZcYWdcNwn2XNGsNSwPIPnGoSN9IuqWPgVBh+G0uPaMVuPlx
ozIogWsXulK8KaHkjJqXkO6fw2uzCIHNpNdCCeFqFGiTPNc0Um+UBTF7neyWi3M=
=VHgb
-----END PGP SIGNATURE-----

--nextPart2262444.VxEEmQHS6F--
