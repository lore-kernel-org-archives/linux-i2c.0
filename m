From: Kevin Fenzi <kevin@scrye.com>
Subject: Re: Issues with touchpad / touchscreen on yoga 900
Date: Mon, 2 Nov 2015 12:47:28 -0700
Message-ID: <20151102124728.52e82bed@voldemort.scrye.com>
References: <20151029112913.1036f00b@voldemort.scrye.com>
	<20151029183032.GA8992@katana>
	<56332316.90506@linux.intel.com>
	<20151030100442.50ac07bd@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/e.BtPzE1oELK4M0B7979af3"; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from scrye.com ([75.148.32.185]:51500 "EHLO mail.scrye.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbbKBTrd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 14:47:33 -0500
In-Reply-To: <20151030100442.50ac07bd@voldemort.scrye.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

--Sig_/e.BtPzE1oELK4M0B7979af3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Oct 2015 10:04:42 -0600
Kevin Fenzi <kevin@scrye.com> wrote:

> On Fri, 30 Oct 2015 09:58:14 +0200
> Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:
>=20
> > Hi
> >=20
> > On 10/29/2015 08:30 PM, Wolfram Sang wrote: =20
> > > On Thu, Oct 29, 2015 at 11:29:13AM -0600, Kevin Fenzi wrote:   =20
> > >> Greetings.
> > >>
> > >> I'm having problems with a lenovo yoga 900 not seeing it's
> > >> touchscreen or touchpad.
> > >>
> > >> Downstream bug:
> > >> https://bugzilla.redhat.com/show_bug.cgi?id=3D1275718
> > >>
> > >> The problem parts of dmesg seem to be:
> > >>
> > >> Oct 26 15:20:08 localhost kernel: i2c_designware
> > >> i2c_designware.1: i2c_dw_handle_tx_abort: lost arbitration Oct
> > >> 26 15:20:08 localhost kernel: i2c_hid i2c-SYNA2B29:00:
> > >> hid_descr_cmd failed Oct 26 15:20:08 localhost kernel:
> > >> i2c_designware i2c_designware.2: i2c_dw_handle_tx_abort: lost
> > >> arbitration Oct 26 15:20:08 localhost kernel: i2c_hid
> > >> i2c-ELAN21EF:00: hid_descr_cmd failed
> > >>
> > >> This is with 4.3.0-0.rc7.git1.1.fc24.x86_64 (post rc7 4.3.0).
> > >>
> > >> Happy to gather further info or try patches. ;)   =20
> > >   =20
> > Could you try this test patch from Mika that prints the parameters
> > it gets from ACPI and forces using calculated ones (your quirk was
> > supposed to be doing the same):
> >=20
> > http://www.spinics.net/lists/linux-i2c/msg21239.html =20
>=20
> ok. That gives me:=20
>=20
> [157408.224530] i2c_designware i2c_designware.1: ACPI SSCN 0:0
> [157408.224534] i2c_designware i2c_designware.1: ACPI FMCN 0:0
> [157408.224536] i2c_designware i2c_designware.1: ACPI SDA hold 0
> [157408.228054] i2c_designware i2c_designware.1:
> i2c_dw_handle_tx_abort: lost arbitration [157408.228061] i2c_hid
> i2c-SYNA2B29:00: hid_descr_cmd failed [157408.235275]
> [157408.250399] i2c_designware i2c_designware.2: ACPI SSCN 0:0
> [157408.250403] i2c_designware i2c_designware.2: ACPI FMCN 0:0
> [157408.250405] i2c_designware i2c_designware.2: ACPI SDA hold 0
> [157408.261255] idma64 idma64.2: idma64_irq: status=3D0x0
> [157408.261284] idma64 idma64.2: idma64_irq: status=3D0x0
> [157408.261319] i2c_designware i2c_designware.2:
> i2c_dw_handle_tx_abort: lost arbitration [157408.261325] i2c_hid
> i2c-ELAN21EF:00: hid_descr_cmd failed
>=20
> Also, if it helps with i2c-hid debug=3D1:
>=20
> Oct 30 12:02:10 localhost kernel: i2c_hid i2c-ITE8396:00: Fetching
> the HID descriptor Oct 30 12:02:10 localhost kernel: i2c_hid
> i2c-ITE8396:00: __i2c_hid_command: cmd=3D01 00 Oct 30 12:02:10
> localhost kernel: i2c_hid i2c-ITE8396:00: HID Descriptor: 1e 00 00 01
> dc 0a 02 00 03 00 16 00 04 00 00 00 05 00 06 00 8d 04 96 83 17 10 00
> 00 00 00 Oct 30 12:02:10 localhost kernel: i2c_hid i2c-ITE8396:00:
> entering i2c_hid_parse Oct 30 12:02:10 localhost kernel: i2c_hid
> i2c-ITE8396:00: i2c_hid_hwreset Oct 30 12:02:10 localhost kernel:
> i2c_hid i2c-ITE8396:00: i2c_hid_set_power Oct 30 12:02:10 localhost
> kernel: i2c_hid i2c-ITE8396:00: __i2c_hid_command: cmd=3D05 00 00 08
> Oct 30 12:02:10 localhost kernel: i2c_hid i2c-ITE8396:00: input: 0c
> 00 01 02 02 ed ff 82 fc 89 fe 00 Oct 30 12:02:10 localhost kernel:
> i2c_hid i2c-ITE8396:00: resetting... Oct 30 12:02:10 localhost
> kernel: i2c_hid i2c-ITE8396:00: __i2c_hid_command: cmd=3D05 00 00 01
> Oct 30 12:02:10 localhost kernel: i2c_hid i2c-ITE8396:00:
> __i2c_hid_command: waiting... Oct 30 12:02:10 localhost kernel:
> i2c_hid i2c-ITE8396:00: __i2c_hid_command: finished. Oct 30 12:02:10
> localhost kernel: i2c_hid i2c-ITE8396:00: asking HID report
> descriptor Oct 30 12:02:10 localhost kernel: i2c_hid i2c-ITE8396:00:
> __i2c_hid_command: cmd=3D02 00 Oct 30 12:02:11 localhost kernel:
> i2c_hid i2c-ITE8396:00: Report Descriptor: 06 83 ff 09 80 a1 01 85 5a
> 09 01 15 00 26 ff 00 75 08 95 10 b1 00 c0 05 20 09 01 a1 01 85 01 05
> 20 09 73 a1 00 05 20 0a 09 03 15 00 25 02 75 08 95 01 a1 02 0a 30 08
> 0a 31 08 0a 32 08 b1 00 c0 Oct 30 12:02:11 localhost kernel: i2c_hid
> i2c-ITE8396:00: input: 11 00 02 02 02 00 00 00 00 00 00 00 00 00 00
> 00 00 Oct 30 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00:
> input: 14 00 03 02 02 9b 06 5e b5 fb ff c3 32 f4 ff c3 71 14 00 03
> Oct 30 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00:
> i2c_hid_get_report Oct 30 12:02:11 localhost kernel: i2c_hid
> i2c-ITE8396:00: __i2c_hid_command: cmd=3D05 00 3f 02 5a 06 00 Oct 30
> 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00: report (len=3D19):
> 12 00 5a ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00 Oct 30
> 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00: error in
> i2c_hid_init_report size:19 / ret_size:18 Oct 30 12:02:11 localhost
> kernel: i2c_hid i2c-ITE8396:00: i2c_hid_get_report Oct 30 12:02:11
> localhost kernel: i2c_hid i2c-ITE8396:00: __i2c_hid_command: cmd=3D05
> 00 31 02 06 00 Oct 30 12:02:11 localhost kernel: i2c_hid
> i2c-ITE8396:00: report (len=3D21): 15 00 01 01 02 02 02 c8 00 00 00 02
> 00 02 00 32 00 a0 0f 60 f0 Oct 30 12:02:11 localhost kernel: i2c_hid
> i2c-ITE8396:00: i2c_hid_get_report Oct 30 12:02:11 localhost kernel:
> i2c_hid i2c-ITE8396:00: __i2c_hid_command: cmd=3D05 00 32 02 06 00 Oct
> 30 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00: report
> (len=3D31): 1f 00 02 01 01 06 02 64 00 00 00 58 1b 00 00 e0 70 72 00 50
> c3 00 00 00 c2 eb 0b 00 3e 14 f4 Oct 30 12:02:11 localhost kernel:
> i2c_hid i2c-ITE8396:00: i2c_hid_get_report Oct 30 12:02:11 localhost
> kernel: i2c_hid i2c-ITE8396:00: __i2c_hid_command: cmd=3D05 00 33 02 06
> 00 Oct 30 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00: report
> (len=3D41): 29 00 03 01 01 06 02 64 00 00 00 01 00 64 00 02 00 10 0e 00
> 00 28 06 00 00 28 06 00 00 10 27 00 00 00 2d 31 01 00 d3 ce fe Oct 30
> 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00: i2c_hid_get_report
> Oct 30 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00:
> __i2c_hid_command: cmd=3D05 00 34 02 06 00 Oct 30 12:02:11 localhost
> kernel: i2c_hid i2c-ITE8396:00: report (len=3D21): 15 00 04 01 02 02 02
> 64 00 00 00 01 00 32 00 05 00 42 0e be f1 Oct 30 12:02:11 localhost
> kernel: i2c_hid i2c-ITE8396:00: i2c_hid_get_report Oct 30 12:02:11
> localhost kernel: i2c_hid i2c-ITE8396:00: __i2c_hid_command: cmd=3D05
> 00 35 02 06 00 Oct 30 12:02:11 localhost kernel: i2c_hid
> i2c-ITE8396:00: report (len=3D31): 1f 00 05 01 01 06 02 64 00 00 00 01
> 00 00 00 a0 86 01 00 10 27 00 00 80 96 98 00 80 69 67 ff Oct 30
> 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00: i2c_hid_get_report
> Oct 30 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00:
> __i2c_hid_command: cmd=3D05 00 36 02 06 00 Oct 30 12:02:11 localhost
> kernel: i2c_hid i2c-ITE8396:00: report (len=3D41): 29 00 06 01 01 06 02
> dc 05 00 00 19 00 ff ff 00 00 53 00 01 00 64 00 20 00 73 00 3c 01 7d
> 00 e8 03 87 00 5a 0c 95 00 10 27 Oct 30 12:02:11 localhost kernel:
> i2c_hid i2c-ITE8396:00: i2c_hid_get_report Oct 30 12:02:11 localhost
> kernel: i2c_hid i2c-ITE8396:00: __i2c_hid_command: cmd=3D05 00 37 02 06
> 00 Oct 30 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00: report
> (len=3D35): 23 00 07 01 02 02 02 50 00 00 00 0a 00 4c 00 65 00 6e 00 6f
> 00 76 00 6f 00 20 00 59 00 6f 00 67 00 61 00 Oct 30 12:02:11
> localhost kernel: i2c_hid i2c-ITE8396:00: input: 0c 00 04 02 02 63 fd
> 08 00 70 06 03 Oct 30 12:02:11 localhost kernel: i2c_hid
> i2c-ITE8396:00: input: 16 00 05 02 02 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 03 Oct 30 12:02:11 localhost kernel: i2c_hid
> i2c-ITE8396:00: input: 09 00 06 02 02 64 00 00 00 Oct 30 12:02:11
> localhost kernel: i2c_hid i2c-ITE8396:00: input: 11 00 07 02 02 00 00
> d9 ff 47 fc fc 0d 6a 04 74 04 Oct 30 12:02:11 localhost kernel:
> i2c_hid i2c-SYNA2B29:00: Fetching the HID descriptor Oct 30 12:02:11
> localhost kernel: i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=3D20
> 00 Oct 30 12:02:11 localhost kernel: i2c_hid i2c-ITE8396:00:
> i2c_hid_set_power Oct 30 12:02:11 localhost kernel: i2c_hid
> i2c-ITE8396:00: __i2c_hid_command: cmd=3D05 00 01 08 Oct 30 12:02:11
> localhost kernel: i2c_designware i2c_designware.1:
> i2c_dw_handle_tx_abort: lost arbitration Oct 30 12:02:11 localhost
> kernel: i2c_hid i2c-SYNA2B29:00: hid_descr_cmd failed Oct 30 12:02:11
> localhost kernel: i2c_hid i2c-ELAN21EF:00: Fetching the HID
> descriptor Oct 30 12:02:11 localhost kernel: i2c_hid i2c-ELAN21EF:00:
> __i2c_hid_command: cmd=3D01 00 Oct 30 12:02:11 localhost kernel:
> i2c_designware i2c_designware.2: i2c_dw_handle_tx_abort: lost
> arbitration Oct 30 12:02:11 localhost kernel: i2c_hid
> i2c-ELAN21EF:00: hid_descr_cmd failed
>=20
>=20
> > Another fix from Mika that comes to my mind is "HID: multitouch:
> > Fetch feature reports on demand for Win8 devices" which is sitting
> > in linux-next. Not sure is it related but probably worth to try.
> >=20
> > https://lkml.org/lkml/2015/9/28/404 =20
>=20
> I was able to patch that, but got confused... that was in
> hid-multitouch... but I don't even have that loaded normally. Does
> that need hid-i2c rebuilt against that hid-multitouch or something?
> Sorry for the dumb questions.. I'm not really a kernel hacker ;)=20

Any other ideas or things to try?=20

It would be nice to have a working touchpad. ;)

kevin


--Sig_/e.BtPzE1oELK4M0B7979af3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJWN73QAAoJEEs3sNgP+7teFTQP/1TdBw7NHKLLCuGVvYykY8Ph
o5uJ5AOrx31h0THiEYvrUdE6MJjGrIYal2A6eJpvSdlHxEVxarSsi7zD2MsT4lsF
LOCyqCT/pu7Gtfan3mhbqbIFtBKLMuadVK6OMzTBSQU4OS7SOvEqJ9F8OY3YoslA
pNPDrehDCOcYmDMlDDSDRHDfID6piAv0IObxCkkVLbWvPkAW/i75NTslJba4X8WC
6ec7p3UZfQCo9dzo5vfOJe42kgRtiwwn+pVIi9tyfF831RM2JTjq3EpjYyOIcTTx
pZOOTIcq/UYP7xrujzW6XazdkJrQbvJTjyCkU6xckVjRPeu3ioUcDZONiZ7ZwtSe
JSC0cMsRr6uOjE2lQ2dn0oZ4Qe32cqRA1nIm49n+uJkj5cElEoaoTpFpqHmpUlHp
2GFd4bbbrE9nK8AbdFv2YMHs26lwQ4sAI48s2kiGMws8B+C5Xlx5tAB1pYmjU5s5
pS37Uzoa3Nzfmj7RCLVQLYjDQ3IOSBdsRD2M/usyEETFewmWX6NbZROep++8cAyx
PKQTa7M5M56ozcEYXdo80oazsX0OwtSwenpamsUwfxf+ntfG1Xb+PD1dOkLrowEs
n3BsIo7eF7nXuxlc/ZfCBNPO8Wyi4XW/JS39EAWjRHrQBS0WYhnccVJmDuujI9Ex
RTxZylEoPXX4KenKlT89
=KBjV
-----END PGP SIGNATURE-----

--Sig_/e.BtPzE1oELK4M0B7979af3--
