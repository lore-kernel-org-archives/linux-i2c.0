From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Questions about i2c_transfer() usage in timer context...
Date: Mon, 20 Feb 2012 14:11:12 +0100
Message-ID: <20120220141112.1e633beb@endymion.delvare>
References: <4F424440.300@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F424440.300-g4cQ8AsIbFbL9ATBNaCtXw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephane Grosjean <s.grosjean-g4cQ8AsIbFbL9ATBNaCtXw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Bonjour St=C3=A9phane,

On Mon, 20 Feb 2012 14:01:52 +0100, Stephane Grosjean wrote:
> I'm facing a deadlock regarding a timer callback which is only callin=
g=20
> i2c_transfer(), and I wonder if this comes from that call: I first=20
> googled and found that i2c_transfer() may sleep (which is forbidden i=
n=20
> my timer callback) but when I have a look the beginning of the functi=
on,=20
> it starts to check if it is in any atomic context, before trying to=20
> acquire  a lock...
>=20
> So I'm afraid I'm lost and I hope someone will be able to understand =
to=20
> that question: might i2c_transfer() be used in a timer callback or=20
> should I handle my periodic call to i2c_tranfer() by means of a delay=
ed=20
> work?

Depends on the underlying I2C adapter driver. One of the sleep causes
is indeed the acquisition of the mutex in i2c_transfer(). However the
function then calls a driver specific callback function
(adap->algo->master_xfer) which may or may not sleep too depending on
the implementation. So if you want your code to be portable, you have t=
o
assume that it may sleep, which means you indeed have to use a delayed
work.

HTH,
--=20
Jean Delvare
