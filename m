From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v3 06/33] drm: Minimally initialise drm_dp_aux
Date: Fri, 10 Jun 2016 13:26:24 +0300
Message-ID: <20160610102624.GG4329@intel.com>
References: <1464964636-3877-1-git-send-email-chris@chris-wilson.co.uk>
 <1464964636-3877-7-git-send-email-chris@chris-wilson.co.uk>
 <20160603145911.GZ4329@intel.com>
 <20160609205724.GA26250@nuc-i3427.alporthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6609 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299AbcFJK03 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 10 Jun 2016 06:26:29 -0400
Content-Disposition: inline
In-Reply-To: <20160609205724.GA26250@nuc-i3427.alporthouse.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Rafael Antognolli <rafael.antognolli@intel.com>, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On Thu, Jun 09, 2016 at 09:57:24PM +0100, Chris Wilson wrote:
> On Fri, Jun 03, 2016 at 05:59:11PM +0300, Ville Syrj=E4l=E4 wrote:
> > On Fri, Jun 03, 2016 at 03:36:49PM +0100, Chris Wilson wrote:
> > > When trying to split up the initialisation phase and the registra=
tion
> > > phase, one immediate problem encountered is trying to use our own=
 i2c
> > > devices before registration with userspace (to read EDID during d=
evice
> > > discovery). drm_dp_aux in particular only offers an interface for=
 setting
> > > up the device *after* we have exposed the connector via sysfs. In=
 order
> > > to break the chicken-and-egg problem, export drm_dp_aux_init() to
> > > minimally prepare the i2c device for internal use before
> > > drm_connector_register().
> > >=20
> > > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > > Cc: Dave Airlie <airlied@redhat.com>
> > > Cc: Rafael Antognolli <rafael.antognolli@intel.com>
> > > Cc: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > ---
> > >  drivers/gpu/drm/drm_dp_helper.c | 26 +++++++++++++++++++++-----
> > >  include/drm/drm_dp_helper.h     |  1 +
> > >  2 files changed, 22 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/dr=
m_dp_helper.c
> > > index 4b088afa21b2..9b4ec65e1de6 100644
> > > --- a/drivers/gpu/drm/drm_dp_helper.c
> > > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > > @@ -791,15 +791,16 @@ static void unlock_bus(struct i2c_adapter *=
i2c, unsigned int flags)
> > >  }
> > > =20
> > >  /**
> > > - * drm_dp_aux_register() - initialise and register aux channel
> > > + * drm_dp_aux_init() - minimally initialise an aux channel
> > >   * @aux: DisplayPort AUX channel
> > >   *
> > > - * Returns 0 on success or a negative error code on failure.
> > > + * If you need to use the drm_dp_aux's i2c adapter prior to regi=
stering it
> > > + * with the outside world, call drm_dp_aux_init() first. You mus=
t still
> > > + * call drm_dp_aux_register() once the connector has been regist=
ered to
> > > + * allow userspace access to the auxiliary DP channel.
> > >   */
> > > -int drm_dp_aux_register(struct drm_dp_aux *aux)
> > > +void drm_dp_aux_init(struct drm_dp_aux *aux)
> > >  {
> > > -	int ret;
> > > -
> > >  	mutex_init(&aux->hw_mutex);
> > > =20
> > >  	aux->ddc.algo =3D &drm_dp_i2c_algo;
> > > @@ -809,6 +810,21 @@ int drm_dp_aux_register(struct drm_dp_aux *a=
ux)
> > >  	aux->ddc.lock_bus =3D lock_bus;
> > >  	aux->ddc.trylock_bus =3D trylock_bus;
> > >  	aux->ddc.unlock_bus =3D unlock_bus;
> > > +}
> > > +EXPORT_SYMBOL(drm_dp_aux_init);
> >=20
> > This doesn't feel very safe to me. To me it looks like the i2c core
> > wasn't designed to have the adapter be used before i2c_add_adapter(=
)
> > is called. I guess it might work in this case since you provide you=
r
> > own lock vfuncs.
> >=20
> > I think someone should fix the i2c core to split i2c_add_adapter()
> > & co. into init and register phases. Cc:ing i2c folks...
>=20
> As you've seen, I sent the patches to split i2c_add_adapter() to allo=
w for
> us to call i2c_init_adapter() here instead. It still requires the sam=
e
> basic review that this init (the same as above) is sufficient for usi=
ng
> i2c_transfer().
>=20
> I would like to get the regression fix completed without much futher
> ado - in particular, not depending upon landing an external patch.

What regression is this?

--=20
Ville Syrj=E4l=E4
Intel OTC
