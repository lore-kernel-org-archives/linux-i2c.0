From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [PATCH 3/3] Add support for PCA953[4-8] I2C GPIO extenders to
 the pca953x driver
Date: Thu, 31 Jan 2008 23:13:19 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801312308110.3704@axis700.grange>
References: <Pine.LNX.4.64.0801311453470.8478@axis700.grange>
	<Pine.LNX.4.64.0801311500240.8478@axis700.grange>
	<200801311320.57437.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200801311320.57437.david-b@pacbell.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: David Brownell <david-b@pacbell.net>
Cc: Jean Delvare <khali@linux-fr.org>, video4linux-list@redhat.com, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 31 Jan 2008, David Brownell wrote:

> On Thursday 31 January 2008, Guennadi Liakhovetski wrote:
> > +/* This is only temporary - should go with 2.6.26. Only introduced n=
ow
> > + * to avoid a sequence of strcmp() calls and just compare in a loop =
*/
> > +struct pca953x_desc {
> > +=A0=A0=A0=A0=A0=A0=A0unsigned int=A0=A0=A0=A0gpios;
> > +=A0=A0=A0=A0=A0=A0=A0char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*name;
> > +};
>=20
> This is a bit sub-optimal; if it were the same as i2c_device_id then
> less code would need to change later.  So I'll probably tweak that bit
> before sending it on.

Well, you said i2c_device_id is going to look like

  struct i2c_device_id {
        char name[I2C_NAME_SIZE];
        kernel_ulong_t driver_data;=A0=A0=A0=A0=A0/* Data private to the =
driver */
  };

And I only have a (const) statically initialized array of such structs.=20
So, what would be the difference?

Thanks
Guennadi
---
Guennadi Liakhovetski

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
