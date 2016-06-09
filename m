From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH v3 06/33] drm: Minimally initialise drm_dp_aux
Date: Thu, 9 Jun 2016 21:57:24 +0100
Message-ID: <20160609205724.GA26250@nuc-i3427.alporthouse.com>
References: <1464964636-3877-1-git-send-email-chris@chris-wilson.co.uk>
 <1464964636-3877-7-git-send-email-chris@chris-wilson.co.uk>
 <20160603145911.GZ4329@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.fireflyinternet.com ([87.106.93.118]:53531 "EHLO
	fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751765AbcFIU5b (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 9 Jun 2016 16:57:31 -0400
Content-Disposition: inline
In-Reply-To: <20160603145911.GZ4329@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Rafael Antognolli <rafael.antognolli@intel.com>, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On Fri, Jun 03, 2016 at 05:59:11PM +0300, Ville Syrj=E4l=E4 wrote:
> On Fri, Jun 03, 2016 at 03:36:49PM +0100, Chris Wilson wrote:
> > When trying to split up the initialisation phase and the registrati=
on
> > phase, one immediate problem encountered is trying to use our own i=
2c
> > devices before registration with userspace (to read EDID during dev=
ice
> > discovery). drm_dp_aux in particular only offers an interface for s=
etting
> > up the device *after* we have exposed the connector via sysfs. In o=
rder
> > to break the chicken-and-egg problem, export drm_dp_aux_init() to
> > minimally prepare the i2c device for internal use before
> > drm_connector_register().
> >=20
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Rafael Antognolli <rafael.antognolli@intel.com>
> > Cc: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> > Cc: dri-devel@lists.freedesktop.org
> > ---
> >  drivers/gpu/drm/drm_dp_helper.c | 26 +++++++++++++++++++++-----
> >  include/drm/drm_dp_helper.h     |  1 +
> >  2 files changed, 22 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_=
dp_helper.c
> > index 4b088afa21b2..9b4ec65e1de6 100644
> > --- a/drivers/gpu/drm/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > @@ -791,15 +791,16 @@ static void unlock_bus(struct i2c_adapter *i2=
c, unsigned int flags)
> >  }
> > =20
> >  /**
> > - * drm_dp_aux_register() - initialise and register aux channel
> > + * drm_dp_aux_init() - minimally initialise an aux channel
> >   * @aux: DisplayPort AUX channel
> >   *
> > - * Returns 0 on success or a negative error code on failure.
> > + * If you need to use the drm_dp_aux's i2c adapter prior to regist=
ering it
> > + * with the outside world, call drm_dp_aux_init() first. You must =
still
> > + * call drm_dp_aux_register() once the connector has been register=
ed to
> > + * allow userspace access to the auxiliary DP channel.
> >   */
> > -int drm_dp_aux_register(struct drm_dp_aux *aux)
> > +void drm_dp_aux_init(struct drm_dp_aux *aux)
> >  {
> > -	int ret;
> > -
> >  	mutex_init(&aux->hw_mutex);
> > =20
> >  	aux->ddc.algo =3D &drm_dp_i2c_algo;
> > @@ -809,6 +810,21 @@ int drm_dp_aux_register(struct drm_dp_aux *aux=
)
> >  	aux->ddc.lock_bus =3D lock_bus;
> >  	aux->ddc.trylock_bus =3D trylock_bus;
> >  	aux->ddc.unlock_bus =3D unlock_bus;
> > +}
> > +EXPORT_SYMBOL(drm_dp_aux_init);
>=20
> This doesn't feel very safe to me. To me it looks like the i2c core
> wasn't designed to have the adapter be used before i2c_add_adapter()
> is called. I guess it might work in this case since you provide your
> own lock vfuncs.
>=20
> I think someone should fix the i2c core to split i2c_add_adapter()
> & co. into init and register phases. Cc:ing i2c folks...

As you've seen, I sent the patches to split i2c_add_adapter() to allow =
for
us to call i2c_init_adapter() here instead. It still requires the same
basic review that this init (the same as above) is sufficient for using
i2c_transfer().

I would like to get the regression fix completed without much futher
ado - in particular, not depending upon landing an external patch.
-Chris

--=20
Chris Wilson, Intel Open Source Technology Centre
