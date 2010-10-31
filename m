From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] i2c-i801: Handle multiple instances instead of
 keeping global state
Date: Sun, 31 Oct 2010 20:39:36 +0100
Message-ID: <20101031203936.2025b2c4@endymion.delvare>
References: <1288538382.4570.48.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1288538382.4570.48.camel-uXGAPMMVk8bAQYKIod7YupZV94DADvEd@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 31 Oct 2010 11:19:42 -0400, David Woodhouse wrote:
> It's poor form to keep driver state in global variables rather than
> per-instance. It never really mattered in practice when there was onl=
y
> one controller on the chipset =E2=80=94 but the latest chipsets do ha=
ve more
> than one controller, so now we care.
>=20
> Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Applied (after fixing 6 checkpatch.pl warnings), thanks.

--=20
Jean Delvare
