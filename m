From: Michelle Konzack <linux4michelle-qCYv2r+mE47ltxMxsNcu6w@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 18:27:47 +0100
Message-ID: <20090123172747.GB24751@tamay-dogan.net>
References: <20090122150230.GA10952@enneenne.com> <20090123095110.7b0c7b82@hyperion.delvare> <878wp2ml52.fsf@macbook.be.48ers.dk> <20090123134833.GH12256@enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_samba3-22455-1232731836-0001-2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090123134833.GH12256-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_samba3-22455-1232731836-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 2009-01-23 14:48:33, schrieb Rodolfo Giometti:
> On Fri, Jan 23, 2009 at 10:23:05AM +0100, Peter Korsgaard wrote:
> > Not only that, it's afaik about doing i2c bus multiplexing where the
> > multiplexers are themselves i2c devices - E.G. stuff where you might
> > need to recursively call into the i2c core.
>=20
> I did exactly as you say. I have a custom board with a PCA9540 which
> is a i2c multiplexer controlled by i2c bus.

Here too, but using a Maxim MAX7367 and MAX7369 and here  you  will  run
into trouble, because the first one  is  a  Switch/Multiplexer  and  the
second one a Multiplexer only.

Runing an Atmel AT91SAM7S and doing RAW coding is no problem, but using
my Atmel AT91SAM7SE (64MB NAND, 32 MB SDRAM) using Linux is (currently)
the hell.

> > I have been doing i2c multiplexers where the multiplexers themselves
> > are not controlled through i2c for years without problems.

So you use those Multiplexer only for  level  switching  where  even  on
different ports the Address is unique?  This is working with  the  Maxim
chips too.

But in my "24V DC modular ATX PSU" (like a striped down UPS) I  have  on
the first Port the standard ATX outputs and the other  three  Ports  are
connected to Expansion slots...

Since no one know, which Expansion modules are connected, I can not have
unique addresses for the I=B2C devices...

Used Devices are:

DS1780		Hardware Monitor
DS28CZ04	4kbit EEPROM	(stores module infos)
MAX1036		4-Channel 8-Bit ADC
MAX1038		12-Channel 8-Bit ADC

but not limited too.

> However I'm going to publish my job on i2c multiplexers ASAP, maybe
> you can take a look at it and verify if it fixes your needs.

I hope I hear you soon...

Thanks, Greetings and nice Day/Evening
    Michelle Konzack
    Systemadministrator
    24V Electronic Engineer
    Tamay Dogan Network
    Debian GNU/Linux Consultant


--=20
Linux-User #280138 with the Linux Counter, http://counter.li.org/
##################### Debian GNU/Linux Consultant #####################
<http://www.tamay-dogan.net/>               <http://www.can4linux.org/>
Michelle Konzack   Apt. 917                  ICQ #328449886
+49/177/9351947    50, rue de Soultz         MSN LinuxMichi
+33/6/61925193     67100 Strasbourg/France   IRC #Debian (irc.icq.com)

--=_samba3-22455-1232731836-0001-2
Content-Type: application/pgp-signature; name="signature.pgp"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFJef4SC0FPBMSS+BIRAuefAJwJz7aemhlmZ60uGtq+ryJiWpmltgCePAa7
pg23sgqWmRK73zyoCdmzAoY=
=UDQ7
-----END PGP SIGNATURE-----

--=_samba3-22455-1232731836-0001-2--
