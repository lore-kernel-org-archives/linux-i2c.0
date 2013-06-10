From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
Date: Mon, 10 Jun 2013 15:45:36 +0200
Message-ID: <20130610134535.GB2987@katana>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
 <20130516093846.GA2927@katana>
 <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
 <20130525201032.GD32043@sirena.org.uk>
 <CAGsJ_4y6SY6nNkbW+Yh8jx0WB4Pi9MO1W3xVZcrQcedGeD5ogQ@mail.gmail.com>
 <20130527121658.GA3660@sirena.org.uk>
 <CAGsJ_4w867BhFvVze5BNaYheW75pMcOGhscz3wSZiia-neP59w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4w867BhFvVze5BNaYheW75pMcOGhscz3wSZiia-neP59w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org, Xiaomeng Hou <Xiaomeng.Hou-kQvG35nSl+M@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2013 at 11:36:14PM +0800, Barry Song wrote:
> 2013/5/27 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> > On Mon, May 27, 2013 at 09:54:56AM +0800, Barry Song wrote:
> >
> >> Mark, the case is not that deferred probing is slow or not. deferred
> >> probing is pretty good.
> >> the case is that we want to i2c and media connected with i2c probed
> >> earlier than other devices.
> >> in auto infotainment devices, we actually do some hacking in kernel
> >> that makes rear view work earlier than other device driver
> >> initialization with a kernel thread which take care of backing-car
> >> policy not only mechanism. that means, we make camera work to see
> >> backview image even earlier than other drivers' initialization.
> >> we don't want media deferred to wait for i2c. we want make some early
> >> jobs ready earlier.
> >
> > So this change makes no practical difference in mainline and exists to
> > support out of tree hacks for performance?  It doesn't seem like that
> > big a patch to carry along with the out of tree stuff...
>=20
> yes. but i don't think we are easy to make those out-of-mainline hacks
>  be in mainline. but this patch is both ok to mainline and local tree.
> making local tree and mainline same as many as possible decreases our
> maintaince efforts totally.

I understand that, yet I agree with Mark. The mainline idea is to use
deferred probing to make sure all components come up correctly. In fact,
I wish for patches removing subsys_initcall with deferred probing.


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRtdh/AAoJEBQN5MwUoCm2QN8QAJv/1gsEURIttsuY1ei5DJDF
lYDJCnRxkrVjR8FsykzLxWzwGm4E+27ojbc9ClVSpnRcBVcVtNvaGiPEtZr4/l2C
y/2hzfP4RU/1pHIfWyQ5u2p0g1kZPX64w2klnQNb5ZT5YlWN2l4xDXF/qZhGxAio
AdCVdtKmqog8K/h4QY7+FKa/rGInLX/Em2VTfxHuZT0rFnc/2JqDFmOWkz3GsC7p
QHcNRSg+Toh+NfJ7V86RHSU59Y8vAIngGdlWNDeR7xigPOD/T5qwSOUVIiNe2yF4
mYj4HgKkpaLqt2xuxF1wwGhr/Ol3mQaOofYyencVhICx0NQvtj/ZH6hqGGgyoEq/
s88oz45fE+xB2P8JT0aPdrSR6PkrCP/l2eAyDZPqP7ICAi6ZfGfmpKnqGU+Bvs6B
H+H6ktuHJ280tX5tOghPo5pRHyVTokrO0EorElf1Hyd4n4p0e2bItADuiNK60yP8
shIVr9XyKKEYff5hbtuM3pUaxjBP4Jc3/KYSJ5sOhmt3rbKWhhx0WeTZhqQ0IrF0
7hBDAsWsApx6qG8ZwXcj7e5Hj2Qi4FlCK3ze1PMhTnAHmvJHF2IjURG3W6lTokuV
/cS23NjAvxSqZIlfm/OuXtecpju8Awf12Xzyo3YSEb+xTsK4heSM7Y8Iw8jXNnlb
jWKLb4Zw7jsfm23qPkPI
=XBh7
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
