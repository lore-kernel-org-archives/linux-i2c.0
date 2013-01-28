From: Amaury =?iso-8859-1?Q?Decr=EAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 6/6] Cleanup
Date: Mon, 28 Jan 2013 22:10:25 +0100
Message-ID: <20130128211025.GC29409@gentoo>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
 <1357305215-17643-1-git-send-email-amaury.decreme@gmail.com>
 <1357305215-17643-7-git-send-email-amaury.decreme@gmail.com>
 <20130128194007.3d3c0d4d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130128194007.3d3c0d4d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 28, 2013 at 07:40:07PM +0100, Jean Delvare wrote:
> > Some "80 columns" warnings have been expressly omitted to keep read=
ing
> > easy.
>=20
> You can get rid of these too by splitting the affected lines. You do
> not have to split the strings themselves, but the other parameters ca=
n
> be on different lines. checkpatch.pl will be silent once you get this
> right.
>=20

Thanks for the review.
"80 columns" warn removed without string splitting in v3.

--=20
Amaury Decr=EAme
