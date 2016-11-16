From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on Octeon
Date: Wed, 16 Nov 2016 10:38:55 +0000
Message-ID: <21144795.sM34J9FN6K@np-p-burton>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com> <99500824-4c63-b769-ad66-c136529b14b2@cavium.com> <20161115130314.GC2772@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16091310.oYW5glKaQc";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:37219 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752835AbcKPKjG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 16 Nov 2016 05:39:06 -0500
In-Reply-To: <20161115130314.GC2772@hardcore>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: "Steven J. Hill" <Steven.Hill@cavium.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>

--nextPart16091310.oYW5glKaQc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Jan,

On Tuesday, 15 November 2016 14:03:15 GMT Jan Glauber wrote:
> On Mon, Nov 14, 2016 at 01:53:40PM -0600, Steven J. Hill wrote:
> > On 11/14/2016 12:50 PM, Jan Glauber wrote:
> > > Since time is running out for 4.9 (or might have already if you're not
> > > going to send another pull request) I'm going for the safe option
> > > to fix the Octeon i2c problems, which is:
> > > 
> > > 1. Reverting the readq_poll_timeout patch since it is broken
> > > 2. Apply Patch #2 from Paul
> > > 3. Add a small fix for the recovery that makes Paul's patch
> > > 
> > >    work on ThunderX
> > > 
> > > I'll try to come up with a better solution for 4.10. My plan is to get
> > > rid
> > > of the polling-around-interrupt thing completely, but for that we need
> > > more
> > > time to make it work on Octeon.
> > > 
> > > Please consider for 4.9.
> > 
> > Hey Jan.
> > 
> > This does not work on Octeon 71xx platforms. I will look at it more
> > closely tomorrow.
> 
> Paul, can you confirm this? It doesn't make sense for me, since patches #1
> and #3 are unlikely to break anything... And patch #2 worked for you.

For me v4.9-rc5 plus these 3 patches boots fine on a Rhino Labs UTM8 system 
which previously hung whilst probing the I2C driver & devices. Feel free to 
add:

    Tested-by: Paul Burton <paul.burton@imgtec.com>

Thanks,
    Paul
--nextPart16091310.oYW5glKaQc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYLDc/AAoJEIIg2fppPBxlz30P/juxVVkqQExUAWrogbfsaN/5
RlSM6ZOmZPfZfjWq77ViiN2SxglMhNnK2BBkzFYnKpULlbELHwIOtN7KKMfQXuLU
zv28nW2fithDim/57aoQ0tf0fD3+rsfcPfL+4i+5RT1mD/NYaoYrLiGRhb+0wPWY
TTk9H14nHh+sbsanatuLHAFrMdKvUTWRkB6K7vDfzwBvu8ZiT0cbIrmirUl6l0AD
SJeZRM/LhiIQyaObQpg/6Ssfsk/ThDAQPXF/Vi/InpIxmainbJUTPVpxK1xnW0OJ
Dg5DgCyBSipZ06BE/BOqnWzXE9HjEnuvAXYZ6r/SdfVJXsWMVC5WJpLNPrgJc5QX
SUh0KKCyAVETFeteSJJRxazM2eJhCSdez8eRDBPnFq+61KaGcEmlyNvdD3ijtQXr
k3O6f3v0zE0lfBrU4VnOTZfSzQHpvqhKY7hKAXasDAvUGXqsId+FQyTwkf55OjdE
XMBQQEKtoS3a5OowWfBhm0x11qQMx1JNWn5GSdw8UB3UVU+fxlTHC8E7BZW8YHeT
1oUYKY1crxYa1EGcX6cVoyaL1pSWpuqdlUYRLkoa9db4DkgNj80rmQaEn8peRy0x
iSec+j5xLgJhO8GZfULpKM6JuMizotAY8qvEZKWK7BAhIR0PxXdE60vGwWtA1lSZ
SqjA9aqDfmG/D2Rkq1WD
=XlJW
-----END PGP SIGNATURE-----

--nextPart16091310.oYW5glKaQc--
