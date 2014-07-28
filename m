From: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c: removal of s6000 driver
Date: Mon, 28 Jul 2014 16:43:32 +0200
Message-ID: <20140728144330.GA31207@emlix.com>
References: <20140521113029.GT2708@katana>
 <20140523131722.GA28143@curry>
 <537F8652.1090807@zankel.net>
 <20140524154727.GA20634@curry>
 <20140527223557.GA9594@minime.bse>
 <20140609220635.GA3329@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140609220635.GA3329@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Marc Gauthier <marc-66fqrpuXKgGB+jHODAdFcQ@public.gmane.org>
Cc: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl-hi6Y0CQ0nG0@public.gmane.org>, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 10, 2014 at 12:06:35AM +0200, Wolfram Sang wrote:
> On Wed, May 28, 2014 at 12:35:57AM +0200, Daniel Gl=F6ckner wrote:
> > On Sat, May 24, 2014 at 03:47:27PM +0000, Oskar Schirmer wrote:
> > > On Fri, May 23, 2014 at 10:33:06 -0700, czankel wrote:
> > > > I might have asked you before, but do you still have the overla=
y for
> > > > the S6000 somewhere laying around?
> > >=20
> > > No, but maybe Daniel has?
> >=20
> > At work we still have the overlay as part of the board support pack=
age
> > we created for the s6105. But I'd prefer to talk to someone at Stre=
tch
> > first before handing out copies. Unfortunately I'm on vacation righ=
t
> > now and will be without internet access from tomorrow to Sunday.
>=20
> Ping. Is that the only known platform for the s6000?

After exchanging some mails with Stretch (now Exar), it is still uncert=
ain
if the Linux port ever made it into a product. As the chip is out of
production, there won't be any new s6000 devices. Google turns up three
press releases of companies using the s6000 in DVR devices, but these
appear to have the chips on add-in cards.

The good news is that Exar doesn't mind me sharing the overlay.
You can download it from this page: http://www.emlix.com/download/

I removed some files from the tarball:

create-config-pkgs
	had a restrictive copyright header requiring written permission from
	Tensilica. It's a simple shell script grouping the other files for
	building various toolchain packages.

src/gdb/reg-xtensa.dat and src/binutils/xtensa-config.sh
	had no license header and Exar could not easily determine the original
	licensing conditions. The first file basically contains the size
	and name of the first 176 registers in the "rmap" array. The other
	file just defines MAXPAGESIZE to a huge value. Well, it's nommu.

gnu-xcalibur/
	Appeared to contain old copies of GNU libstdc++, libio, and libiberty.
	Most files were four years older than the Xtensa core headers.
	I doubt anyone would want to use these today.

Marc, according to the tarball someone with your name at Tensilica was
involved in the creation of the overlay. Maybe you remember if any of t=
hese
files is needed?

Trying to build CONFIG_XTENSA_PLATFORM_S6105 in mainline will fail.
Mainline never accepted all of our patches and this apparently led to
two arrays being mixed when 759c67e87bce was merged.

Best regards,

  Daniel

--=20
Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11,
Bertha-von-Suttner-Stra=DFe 9, 37085 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
