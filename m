From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
Date: Sat, 25 May 2013 16:10:32 -0400
Message-ID: <20130525201032.GD32043@sirena.org.uk>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
 <20130516093846.GA2927@katana>
 <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org, Xiaomeng Hou <Xiaomeng.Hou-kQvG35nSl+M@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2013 at 06:25:39PM +0800, Barry Song wrote:
> 2013/5/16 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:

> > What about deferred probing?

> deferred probing could work but could not work for automative.
> what we really want is that devices begin to work as early as
> possible. we want i2c clients like lcd, camera begin to show images as
> early as possible as an automative requirement.

Probe deferral should have at most a mimimal impact on the boot time -
it's pretty much just changing the order providing the probe functions
aren't excessively slow to defer.  If the probe functions are taking a
long time to defer that's probably what needs looking at.

If it really is probe deferral itself that's too slow then we ought to
be looking at improving that rather than boding around it.

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRoRq1AAoJELSic+t+oim978YP/3RZL9Ig84upKgyBavw0EWT3
Mb9i6Wss8ciiS385iyrNYLMBJCgKHnpIjP/gve/ctRRwdv+OuYsSAv+fHjlyKB/v
IygRheAvJPHBVZGQP7qK1QFI5ukOIbBB1JqOeJ/agDcYA9pl5E7M2M3Z3G23cdhZ
OaBREv17MPtQgHMDG8qNkGs2v3FykFNWoXyEVOL/jx+nqfPnpZDObcjNM+6zqx/G
FCNQd1MM86ID7yb0AR221HDdmzeO9OJpE/TSo8PoEkRcMNE+lak5ZoVDlRTgpQ8E
2JAG5YPO8fzBOQqTBs2mhOo+fXp0QW9gLeV1XfRX83qZP2dHRq4m9xLZJhVlofLU
JIObf5dVwAdnFfafygonkmFegJzNY0N3nLx+5TCJfkixv15BIUMnA7LxjlfVjVKa
FOIzU3t0ZY3BV5lzKBOyS/YGujxbgZNPBSBB2ULbBiQb8T9NTZX9SNDWAHuYsUdu
4JOWAFzru9v78SSPVMwqPAazulX147/FFXQxaVAWCUtCylwKEK0tUc1uJmBr6vpd
G6J2Bbyr8xB/0lIur8QltmFF4Mk4EtaUl29zhHSGPXPNdWnpUtIbK9FNHs4Wa8ZO
ix+XG6PJ52NE4TqVF8pPOdbY0224V9VwaRtOQ57fJkntlgwv3zT/e0is3RjnjtWm
EKWn3CVJWy2gZbwI3xc0
=GGml
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
