From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-i801: Handle multiple instances instead of
 keeping  global state
Date: Sun, 31 Oct 2010 10:28:17 -0400
Message-ID: <1288535297.4570.39.camel@macbook.infradead.org>
References: <alpine.LFD.2.00.1010301445490.7306@dwoodhou-mobl2.ger.corp.intel.com>
	 <20101030182458.0849f295@endymion.delvare>
	 <20101030230052.GP21564@trinity.fluff.org>
	 <1288480327.4570.2.camel@macbook.infradead.org>
	 <20101031105629.109dd2e2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101031105629.109dd2e2-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 2010-10-31 at 10:56 +0100, Jean Delvare wrote:
> ... says the guy who was unable to send a properly formatted patch to=
 me
> yesterday. They had no charset info, and "file" says "ISO-8859 mail
> text".
>=20
> Yeah, I know, sent from your phone, blah, whatever, this just confirm=
s
> my point that using non-ASCII chars is asking for trouble.=20

I don't think we can learn much from the misbehaviour of a mail client
which can't even manage to refrain from corrupting the *whitespace* in
the patches :)

Thanks for pointing that out =E2=80=94 I've now fixed both the format=3D=
flowed
idiocy and the conversion to legacy charsets, so both should be fixed i=
f
ever I have to send patches out that way again.

--=20
David Woodhouse                            Open Source Technology Centr=
e
David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporatio=
n
