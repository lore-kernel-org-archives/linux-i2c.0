From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-mpc: make mpc_i2c_pm_ops static
Date: Tue, 11 Jun 2013 21:29:57 +0200
Message-ID: <20130611192956.GF3376@katana>
References: <006601ce243e$200a47c0$601ed740$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <006601ce243e$200a47c0$601ed740$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2013 at 10:07:28AM +0900, Jingoo Han wrote:
> mpc_i2c_pm_ops is not exported. Also, CONFIG_PM_SLEEP is used to
> remove unnecessary ifdefs.

I guess we should use the new pm_ops_ptr macro which is scheduled for
3.11.

Thanks,

   Wolfram


--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRt3q0AAoJEBQN5MwUoCm22PYQAJJy25NbGDSYfHpLdEFobSY3
1qq5b6gGJ22VmYG/8pyhpntziA64PSAUXBPUmTMaqLZljKQcvQm1vbU9WVUh+Wca
4y2207+SB128F2KTsv46lRVUd59ut10kbOICXtSLO3SP0XAt3WgT4yBAagkVEkz6
xeWSALwtiklfE/yJRW4Ln98H9MY/OwA8xRf5MO+KOyZ+xYGFk40LSvPadYrXFyS8
3gamUgVoArIIjgfhiUwWhvyGGmYn/74v15UGrH0TzyGCHGBdYPAUitidCIZRj7i1
pvS6EacAZxGFL6v09FiekV5l1yyil345S23gVssosmw2sHaBIT4g5MhrG/aqq5gp
Ues3tS5b5H7aEXnOdxAhNEu152jowZlxdsK8ODiw8lN6vIX9n//adErgOlKEV6Dk
YxFOorzkU2YHgl/G9J52bZi/XTihriFgsH4TnAqMjy9OZdPhKKYbUixiHKhlE3T1
RqMVQ+uIcwngb0aGu+Ybt0fUfDVKYxbRGIh1maCsLE6ihKvxNMPdomayzJshLlG0
DDcvDU1jQCOGVN3vl3NlF/NNFgLGDJfLMBo+umAY4rMUGNSxOGEr5XLU0/dMIMlE
pGPfa+4Cou/mu89WfSNNW3uYTLwfxqUFC6C6hsuWa+zYI6WwCvjoMYowUW2yIqYV
zlqxyY4pDyeUs8fDOfDv
=+p5i
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
