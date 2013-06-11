From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
Date: Tue, 11 Jun 2013 13:10:03 +0100
Message-ID: <20130611121003.GC1403@sirena.org.uk>
References: <20130516093846.GA2927@katana>
 <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
 <20130525201032.GD32043@sirena.org.uk>
 <CAGsJ_4y6SY6nNkbW+Yh8jx0WB4Pi9MO1W3xVZcrQcedGeD5ogQ@mail.gmail.com>
 <20130527121658.GA3660@sirena.org.uk>
 <CAGsJ_4w867BhFvVze5BNaYheW75pMcOGhscz3wSZiia-neP59w@mail.gmail.com>
 <20130610134535.GB2987@katana>
 <CAGsJ_4y4svi0TbUKK1aAW1McM5rFoo5Vb9rGPweq-sHJ2NN5cQ@mail.gmail.com>
 <20130611084827.GS1403@sirena.org.uk>
 <CAGsJ_4wH=mNxBTqizKjJR2YhmVQa=iprfUmVYy8oz7MZeLfkqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+RqgOR8y65RRYhVY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4wH=mNxBTqizKjJR2YhmVQa=iprfUmVYy8oz7MZeLfkqg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org, Xiaomeng Hou <Xiaomeng.Hou-kQvG35nSl+M@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--+RqgOR8y65RRYhVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2013 at 07:13:33PM +0800, Barry Song wrote:
> 2013/6/11 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:

> > It's not that people don't care about these users, it's that people
> > don't care too much about out of tree users.  Part of the goal here is
> > to convince people working on such applications that they should make
> > mainline better for everyone so that you don't need external code to
> > make the kernel useful.

> Mark, then this is really confusing me.
> for this reason, the target should be making this out-of-tree stuff be
> inside the tree. to make i2c-sirf "mainline better and not need
> external code", the target should be making this external code not
> external but become internal. otherwise, my mainline users will always
> need this external code.

It's not just this one bit of code that they're relying on, this also
gets built on with other things that are also out of tree.  The thing
we need to do is figure out what problem the solution as a whole is
fixing and then make sure that mainline can deal with that.

--+RqgOR8y65RRYhVY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtxOYAAoJELSic+t+oim9LXsP/jPGtv5uF3jUpN7Cr+e/Z7WX
YKX7EoNrOzakgdEwaLVfIvoKz/wfqBQk9sCwyqSPY9OhDSLH7jg19K2JtkIXEX7L
vB7m2BITXr+TWGC3aEzsElrDZYQYITKWRxLAowMbEPaTALDFoyAChN/1/6SdDUV7
bUuyATuZbtIK5zvIDnZuT2qHYZz9oKIuwjOZQ0UHpN4MVF7wYouvQ+LMU58X28fE
+Bi78RbhM/NghH8rsQUWwXS78ZlXX4mAxpV8peQDLeLrsndfnmZqRUAqnxKF2dFk
DDchhcayvwxzapCyylaPRuBzIQMmVc4QzTjBX0QyVL5mojBWyPGtX6t2Bfu+37dw
9iq75snIbDUE4kl7ryw9kOhd66VS+B0PDJX8czc+BgPj1+cQH1mgdFkesFTGD922
ujeydRnlrR15z7B+ikqXFAyPXUgT6aQVznedFtsVB3cScWKZVVFDR5GMD91TQ4Pw
+w1ko6YemLV6krtsA9I+iuvaAesEOq+pdRGtSNRe5Xzcm0YNSkbqDQnPsqOBIZSr
Wj/exbaoUdY8mPgThDYqKx5Tfr65bcmXH7D0ZdDE6xYI6s1ks+R/AdczMJUNF1bk
AjCXHdQpykRwZsFWDunDDd/y9hDvc9g+5BHpDQ8SEOmCe4BclKJrP5gH5gCfhFYx
rKhjBrSEUdHMC5V7L+Bl
=wBuR
-----END PGP SIGNATURE-----

--+RqgOR8y65RRYhVY--
