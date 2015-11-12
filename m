From: LABBE Corentin <montjoie.mailing@gmail.com>
Subject: Re: [PATCH] i2c: taos-evm: replace simple_strtoul by kstrtou8
Date: Thu, 12 Nov 2015 08:54:42 +0100
Message-ID: <20151112075442.GA9850@Red>
References: <1447313194-23931-1-git-send-email-clabbe.montjoie@gmail.com>
 <20151112074643.GB24008@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37350 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbbKLHyq (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Nov 2015 02:54:46 -0500
Content-Disposition: inline
In-Reply-To: <20151112074643.GB24008@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, jdelvare@suse.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 12, 2015 at 08:46:43AM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Nov 12, 2015 at 08:26:33AM +0100, LABBE Corentin wrote:
> > The simple_strtoul function is marked as obsolete.
> > This patch replace it by kstrtou8.
> >=20
> > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > ---
> >  drivers/i2c/busses/i2c-taos-evm.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses=
/i2c-taos-evm.c
> > index 4c7fc2d..fe2b705 100644
> > --- a/drivers/i2c/busses/i2c-taos-evm.c
> > +++ b/drivers/i2c/busses/i2c-taos-evm.c
> > @@ -70,6 +70,7 @@ static int taos_smbus_xfer(struct i2c_adapter *ad=
apter, u16 addr,
> >  	struct serio *serio =3D adapter->algo_data;
> >  	struct taos_data *taos =3D serio_get_drvdata(serio);
> >  	char *p;
> > +	int err;
> > =20
> >  	/* Encode our transaction. "@" is for the device address, "$" for=
 the
> >  	   SMBus command and "#" for the data. */
> > @@ -130,7 +131,9 @@ static int taos_smbus_xfer(struct i2c_adapter *=
adapter, u16 addr,
> >  			return 0;
> >  	} else {
> >  		if (p[0] =3D=3D 'x') {
> > -			data->byte =3D simple_strtol(p + 1, NULL, 16);
> > +			err =3D kstrtou8(p + 1, 16, &data->byte);
> > +			if (err)
> > +				return -EPROTO;
> >  			return 0;
>=20
> This is nearly equivalent to the probably more correct:
>=20
> 	return kstrtou8(p + 1, 16, &data->byte);
>=20

As reported, by Jean Delvare, kstrtou8 could return -EINVAL.
It is why I "drop" the return code from kstrtou8 and return -EPROTO as =
suggested by Jean.

I have hesitate to put a comment for this, and it seems finaly necessar=
y.

Regards
