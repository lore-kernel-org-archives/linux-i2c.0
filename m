From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv2 0/9] i2c: xiic: cleanups
Date: Tue, 14 Jul 2015 13:59:54 +0200
Message-ID: <20150714115954.GH1517@katana>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
 <20150709173501.GE4744@katana>
 <CAKfKVtE5qfQjxJNDOBXfVLncVYXJjgfXe6Anb6M=dSFkHsTt8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKfKVtE5qfQjxJNDOBXfVLncVYXJjgfXe6Anb6M=dSFkHsTt8w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 10, 2015 at 10:43:18AM +0530, Shubhrajyoti Datta wrote:
> On Thu, Jul 9, 2015 at 11:05 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > On Wed, Jun 17, 2015 at 08:48:10PM +0530, Shubhrajyoti Datta wrote:
> >> This is a series of cleanups for the axi iic.
> >> tested on zc702 and microblaze.
> >>
> >> Changes from v1
> >> Updated the commit message.
> >>
> >>
> >> Shubhrajyoti Datta (9):
> >>   i2c: xiic: Remove the disabling of interrupts
> >>   i2c: xiic: move the xiic_process to thread context
> >>   i2c: xiic: Do not reset controller before every transfer
> >>   i2c: xiic: Remove the disabling of interrupts
> >>   i2c: xiic: Remove busy loop while waiting for bus busy
> >>   i2c: xiic: Add a debug msg in case of timeout
> >>   i2c: xiic: Remove the Addressed as slave interrupt
> >>   i2c: xiic: Service all interrupts in isr
> >>   i2c: xiic: Do not continue in case of errors in Rx
> >
> > Commit messages are a lot better, thanks!
> >
> > Two minor comments. If you agree to them, I can simply drop patch 6 and
> > fixup patch 2
> I agree anyways 2 was like a debug patch.

Applied patches as discussed to for-next, thanks!


--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVpPm6AAoJEBQN5MwUoCm2+1MP/0xOa73RF6JeSANmh1ETaB4o
w67GtU0UdlGT7Eq65skoIxGjw8qIqflkrRLKFAXCd2+LVqL9Zpew2Xoa3hDqQyUL
B7xFar4cVgKYA14Dj/RN32Q33oQEMybOQ+b8NqDnlbaCYssTwGMFENwYbdjdu89Y
KF8HPKWZAzhRTbsk1s4HRuIfPTxZhPprAQ1ErfG3XlJWFnfV3mJkRBLFlSmuAfZM
uVWNYGdnMmNtBKc9LHEnsN5fQfryP6Z479WSLmugzL8BCdN6aigcg8b4ToBHZzbt
90BtfaG8XJA2g3xzl64AoTMalICsdoYVncYQIryyXSNyZWTvGx3RhMCClu+1lwOk
G3FIDxsB25gar99Cx1W1vKCQLdLZyALznVZgcFHb96TM59BJik7C4Kro1tTLehsh
HbmXv3NzqCqWzroQ5/bMnrlOs8Jr3QxtfTg3XLM0nUF29la77PlSVOviu5Z4yXzT
qu32vLGMyWXWB9THaU6nxlV8eW/SgEdWodDp4Z4CevB7b+ETsdVdHM94ZXeQSAvv
Wc/QDhP2+TICykhOsKD+3TyzKrJ6PvEZ9H1PNC8YOENM5VSQYCbxKqUCWjJy7FYK
ssiKsa67TUZOLf+lFB0xTsCDv+U55NKr0UXmRNZPd5mFBRUx8pIvQBIRaADhda3X
nvMN++rZAhyXwrbN3WfY
=OSBs
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
