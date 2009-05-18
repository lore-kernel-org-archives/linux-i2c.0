From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
Date: Mon, 18 May 2009 16:29:04 +0200
Message-ID: <4A1170B0.5080203@grandegger.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de> <fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com> <4A028182.3040107@grandegger.com> <200905181557.11766.kosmo@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905181557.11766.kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-2?Q?Piotr_Zi=EAcik?= <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Piotr Zi=EAcik wrote:
>> Right. Furthermore, the i2c-mpc.c should be extened to support bus s=
peed
>> setting for the MPC512x, which has been merged recently (see commit =
id
>> f2bd5efe).
>=20
> I have simple question about bus speed setting support. Existing=20
> implementation uses default safe speed if there is no 'clock-frequenc=
y'=20
> property in i2c node. Comments in code suggest that this behaviour is=
 left=20
> for backward compatibility only. Should I make the 'clock-frequency'
> property mandatory for a new type of I2C controller (MPC5121) ?

I don't think so, for the same backward compatibility reason as for the
other boards. But the DTS file might be changed to use clock-frequency.
BTW, when I wrote the code I already had the MPC512x in mind. IIRC, the
=46DR table and the function scanning it for the MPC52xx should work fo=
r
the MPC512x as well. It's mainly a matter of using the proper function
to get the source clock frequency and fiddling with multiple-arch suppo=
rt.

Wolfgang.
