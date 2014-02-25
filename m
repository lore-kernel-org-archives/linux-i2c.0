From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v6 4/4] i2c, i2c_imc: Add DIMM bus code
Date: Tue, 25 Feb 2014 11:54:20 -0800
Message-ID: <CALCETrXhJPHyWP7NAujbshJc_fBYsGxp_MK752G4Nt8r9yMEmg@mail.gmail.com>
References: <cover.1387588711.git.luto@amacapital.net> <15eccfa508fd0f55230c4274e3e968f91a123b73.1387588711.git.luto@amacapital.net>
 <20140219151626.GA13973@katana> <CALCETrVBPzGqaXbZVgUZMw7D5U5YnUMJOEsw1r=TceLYjJ39JA@mail.gmail.com>
 <20140219192646.1a62521d@alan.etchedpixels.co.uk> <CALCETrWEexCqH5486Qfyt22i5+MZjpETJEMTyg6FO6xOwXuraQ@mail.gmail.com>
 <20140221153239.20dbb8c2@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140221153239.20dbb8c2@alan.etchedpixels.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Rui Wang <ruiv.wang@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 21, 2014 at 7:32 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
>> I'm suggesting identifying a range of addresses on a bus with a "port"
>> (or whatever it should be called).  Multiple ports could claim
>> non-overlapping ranges on the same bus.
>
> Which is fine until you meant a mux or a device that can be moved about
> by writing to it, or has a wide range of addresses determined by
> strapping.

For muxes: isn't there already a system in place for dealing with them?

For things with addresses determined by strapping: my vague proposal
is explicitly intended to support them.  (DIMMs are such a device.)
Whoever instantiates the i2c "ports" is supposed to *know* the
topology, including which straps are set where.  In some cases, that
data could come from ACPI or DT.  In other cases, it's enumerated
directly.  The idea would be to allow the code that figures out the
topology (both physical connectivity and straps) to be separated from
the code that talks to the i2c endpoints.

Just specifying the address ranges might be insufficient for things
that are more flexible than DIMMs, though -- it might be necessary to
say "this port has these addresses and this kind of device lives at
this address".

--Andy
