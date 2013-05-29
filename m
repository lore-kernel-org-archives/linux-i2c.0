From: Mihai Buha <dralexanderkovalev-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: License for the libi2c
Date: Wed, 29 May 2013 02:07:43 -0700 (PDT)
Message-ID: <1369818463.42609.YahooMailNeo@web141202.mail.bf1.yahoo.com>
Reply-To: Mihai Buha <dralexanderkovalev-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello list,
=A0
I have just read the Plans for I2C Tools 4 and I saw that Jean (khali) =
intends to release the new libi2c=A0under the=A0LGPL. I wonder, however=
, if that is legally possible, since the=A0functions in i2c-dev.h are s=
ubject to the GPL, and only the original implementor is allowed to chan=
ge the licensing terms if I understand the GPL correctly (the file was =
originally added in the i2c-tools repository by Kyo:sti (kmalkki), but =
he may have copied the functions from somewhere else).
=A0
The only ways I see to change the licensing=A0are the following:
1) GPL'd code can be relicensed as LGPL by any user (I don't think it's=
 possible);
2) Kyo:sti wrote the code, so=A0he should give his written permission t=
o relicense;
3) Kyo:sti copied the code, so the original author should be tracked do=
wn and asked to give his written permission to relicense.
This process should be performed for all the code that is to be relicen=
sed as LGPL.
=A0
What do you think?
=A0
Disclaimer: IANAL.
=A0
Thanks,
Mihai Buha
