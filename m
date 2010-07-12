From: florian.wohlrab-hi6Y0CQ0nG0@public.gmane.org
Subject: I2C-Bus at QM57 not detected
Date: Mon, 12 Jul 2010 18:28:29 +0200
Message-ID: <20100712162829.305240@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear All

I'm new to I2C. Actually I try to connect some LM75 Temp Sensors to my =
new motherboard (i7-660 with QM57). My problem is I can=E2=80=99t see t=
he SMBus (on my former board it was connected over SMBus. I=E2=80=99m w=
riting to I2C because I think it=E2=80=99s some initialization problem.

I=E2=80=99m sorry if this is a stupid Question, but can anyone give me =
a hint what I could check?
I load the kernel modules with =E2=80=98modprob i2c-dev=E2=80=99 and th=
en call from /usr/sbin =E2=80=98i2c-detect =E2=80=93l=E2=80=99 and I ge=
t following output:
i2c-0       i2c   intel drm CRTDDC_A       I2C adapter
i2c-1       i2c   intel drm LVDSDDC_C      I2C adapter
i2c-2       i2c   intel drm HDMIB          I2C adapter
i2c-3       i2c   DPDDC-B                  I2C adapter
i2c-4       i2c   intel drm HDMIC          I2C adapter
i2c-5       i2c   DPDDC-C                  I2C adapter

I used Kernel 2.6.32. So far I tied Ubuntu 10.04 and also Fedora.

Can you give me a hint which documentation I should read or how to get =
it working?

Thank you in advanced for every (also if just small) hint!

Best Regards
=46lorian

--=20
GRATIS f=C3=BCr alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
