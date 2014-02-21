From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v6 4/4] i2c, i2c_imc: Add DIMM bus code
Date: Fri, 21 Feb 2014 15:32:39 +0000
Message-ID: <20140221153239.20dbb8c2@alan.etchedpixels.co.uk>
References: <cover.1387588711.git.luto@amacapital.net>
	<15eccfa508fd0f55230c4274e3e968f91a123b73.1387588711.git.luto@amacapital.net>
	<20140219151626.GA13973@katana>
	<CALCETrVBPzGqaXbZVgUZMw7D5U5YnUMJOEsw1r=TceLYjJ39JA@mail.gmail.com>
	<20140219192646.1a62521d@alan.etchedpixels.co.uk>
	<CALCETrWEexCqH5486Qfyt22i5+MZjpETJEMTyg6FO6xOwXuraQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrWEexCqH5486Qfyt22i5+MZjpETJEMTyg6FO6xOwXuraQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Rui Wang <ruiv.wang@gmail.com>
List-Id: linux-i2c@vger.kernel.org

> I'm suggesting identifying a range of addresses on a bus with a "port"
> (or whatever it should be called).  Multiple ports could claim
> non-overlapping ranges on the same bus.

Which is fine until you meant a mux or a device that can be moved about
by writing to it, or has a wide range of addresses determined by
strapping.

> In this particular case (Intel LGA2011 systems), there's only one sane
> way to wire up the busses, since the memory controller *is* the smbus
> master.  According to the JEDEC spec, each DIMM slot is has three pins

Ok that helps a lot for the specific case, and you have at least in
theory got a flag between the OS and BIOS to avoid things like SMM
throwing parties on the smbus while you are using it.
