From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: Need help on selecting one (and only one) i2c bus
Date: Wed, 11 Mar 2009 10:47:52 +0100
Message-ID: <20090311094752.GE25824@buzzloop.caiaq.de>
References: <000001c9a0c6$bf92af80$b23e81a4@par.st.com> <20090310163044.571e4aff@hyperion.delvare> <fd6b62c10903102327u426a4262meeabe2c581d7107b@mail.gmail.com> <20090311101513.271f5464@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090311101513.271f5464-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?5LyK5rO9?= <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ayman KHAMOUMA <ayman.khamouma-qxv4g6HH51o@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pramod gurav <pramodforum-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 11 Mar 2009 14:27:33 +0800, =E4=BC=8A=E6=B3=BD wrote:          =
                                                                       =
             =20
> > As you said,i2c address 0x00 is not allowed for common i2c slave de=
vice,it
> > is reserved as broadcast address.Unfortunately,our project has a se=
nsor
> > cy8c201a0 on i2c-bus,it use 0x00 address.

Not true. You need to provide a firmware for that device and this
firmware selects the I2C slave address. Read the datasheet again.

 (page 5):

 "The I2C address is programmable during configuration. It can be locke=
d
 to prevent accidental change by setting a flag in a config-uration
 register."

> > We met much phone hang problem with i2c,errors such as "waiting for=
 bus
> > free" or "exhausted retries" are all with this sensor.

Same reason. Without a firmware, the chips does not have its I2C core
set up and hence it's blocking SDA and/or SCL.

Daniel
