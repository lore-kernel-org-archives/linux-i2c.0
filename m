From: Piotr =?iso-8859-2?q?Zi=EAcik?= <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
Date: Tue, 19 May 2009 09:47:22 +0200
Message-ID: <200905190947.22972.kosmo@semihalf.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de> <200905181557.11766.kosmo@semihalf.com> <4A1170B0.5080203@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A1170B0.5080203-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Monday 18 May 2009 16:29:04 Wolfgang Grandegger napisa=B3(a):
> > I have simple question about bus speed setting support. Existing
> > implementation uses default safe speed if there is no 'clock-freque=
ncy'
> > property in i2c node. Comments in code suggest that this behaviour =
is
> > left for backward compatibility only. Should I make the 'clock-freq=
uency'
> > property mandatory for a new type of I2C controller (MPC5121) ?
>
> I don't think so, for the same backward compatibility reason as for t=
he
> other boards. But the DTS file might be changed to use clock-frequenc=
y.

In my opinion implementing "backward compatilility" for MPC5121 is not =
good
idea. MPC5121 I2C support is completly new thing in mainline. Simply, t=
here is=20
no DTS with which I have to be compatible. Adding backward compatibilit=
y
with nothing may be confusing.

--=20
Best Regards,
Piotr Zi=EAcik
