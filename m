From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c-cadence: Do not let signals interrupt I2C transfers
Date: Tue, 11 Mar 2014 09:00:44 -0700
Message-ID: <99d075e3-1694-4132-bdc8-22ea0a6e3521@VA3EHSMHS014.ehs.local>
References: <1394449954-10797-1-git-send-email-mike.looijmans@topic.nl>
 <1394521655-3444-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394521655-3444-1-git-send-email-mike.looijmans-Oq418RWZeHk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Cc: git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Mike,

On Tue, 2014-03-11 at 08:07AM +0100, Mike Looijmans wrote:
> Pressing CTRL-C while communicating with an I2C device leads to errat=
ic
> behaviour. The cause is that the controller will interrupt the I2C tr=
ansfer
> in progress, and leave the client device in an undefined state. Many
> drivers do not handle error return codes on I2C transfers. The callin=
g driver
> has no way of telling how much of the transfer has actually completed=
, so
> it cannot reliably determine the device's state.
>=20
> The best solution here is to not handle signals in the I2C bus driver=
 at all,
> but always complete a transaction before returning control.
>=20
> See for a related patch and discussion on this topic:
> http://lkml.org/lkml/2014/1/9/246
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Acked-by: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

Thanks for the update. I'll take these changes and resubmit the driver
to LKML as well.

	S=C3=B6ren
