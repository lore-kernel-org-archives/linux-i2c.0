From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: Regression (gdm no longer shuts down) - 2.4.24.x and 2.6.25
Date: Tue, 1 Apr 2008 20:05:52 +0100
Message-ID: <20080401190552.GB10046@deepthought>
References: <20080325200714.GA25487@deepthought> <20080326161934.7eae544f@hyperion.delvare> <20080326173701.GA16882@deepthought> <20080326201031.7c2cefb2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758868AbYDATGV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080326201031.7c2cefb2@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Dave Airlie <airlied@gmail.com>, I2C <i2c@lm-sensors.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 26, 2008 at 08:10:31PM +0100, Jean Delvare wrote:
>=20
> The fact is that there is no i2c-viapro change in 2.6.24.2 nor .4, an=
d
> in fact no i2c change at all. So if anything changed in this driver,
> this has to be a side effect of some (non-i2c) header file change.
> That's a long shot, though.
>=20
 I've been attending to more-urgent non-kernel problems.

 In fact, i2c-viapro is not contributory, and drm may have nothing
to do with it - the problem seems to happen with any kernel > 2.6.24,
but not always.

 So, to be clear, 2.6.24.4 with the drm patch reverted, and
2.6.25-rc1, and 2.6.25-rc7 ALL intermittently fail.  I'll start
bisecting.  Actually, I suppose I'd better try 2.6.24 itself a few
more times, so that I have a little more confidence it was 'good'
for this (fortunately, no other users on that box).  Apologies for
attributing possible blame to i2c.

Ken
--=20
das eine Mal als Trag=F6die, das andere Mal als Farce
