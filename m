From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Thu, 15 Jan 2015 11:23:10 -0800
Message-ID: <20150115192310.GA21344@roeck-us.net>
References: <1421346798-17148-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150115185545.GA20251@roeck-us.net>
 <18134341-FA1D-4ED6-8ED3-E4BF8F90B47E@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <18134341-FA1D-4ED6-8ED3-E4BF8F90B47E-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 15, 2015 at 09:12:36PM +0200, Pantelis Antoniou wrote:
> Hi Guenter,
>=20
> > On Jan 15, 2015, at 20:55 , Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrot=
e:
> >=20
> > On Thu, Jan 15, 2015 at 08:33:18PM +0200, Pantelis Antoniou wrote:
> >> Mark (and unmark) device nodes with the POPULATE flag as appropria=
te.
> >> This is required to avoid multi probing when using I2C and device
> >> overlays containing a mux.
> >> This patch is also more careful with the release of the adapter de=
vice
> >> which caused a deadlock with muxes, and does not break the build
> >> on !OF since the node flag accessors are not defined then.
> >>=20
> >> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> >> ---
> >> drivers/i2c/i2c-core.c | 18 +++++++++++++++++-
> >> 1 file changed, 17 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> >> index 39d25a8..1d44e3a 100644
> >> --- a/drivers/i2c/i2c-core.c
> >> +++ b/drivers/i2c/i2c-core.c
> >> @@ -1122,6 +1122,10 @@ EXPORT_SYMBOL_GPL(i2c_new_device);
> >>  */
> >> void i2c_unregister_device(struct i2c_client *client)
> >> {
> >> +#if IS_ENABLED(CONFIG_OF_DYNAMIC)
> >=20
> > Hi Pantelis,
> >=20
> > I thought I read a note somewhere a couple of days ago suggesting t=
hat
> > CONFIG_OF_DYNAMIC would go away soon. Also, of_node_clear_flag is d=
efined
> > in #ifdef CONFIG_OF, and AFAICS none of the other callers set OF_PO=
PULATED
> > in the context of CONFIG_OF_DYNAMIC. Given that, wouldn't it be bet=
ter
> > to use CONFIG_OF ?
> >=20
> > Thanks,
> > Guenter
> >=20
>=20
> Well, I thought about it. Thing is that the notifier is under CONFIG_=
DYNAMIC,
> and it seems it=E2=80=99s natural to be that way.
>=20
> When we move to always enabling CONFIG_DYNAMIC the change to CONFIG_O=
=46 will be
> part of the conversion.
>=20
Ok.

Thanks,
Guenter
