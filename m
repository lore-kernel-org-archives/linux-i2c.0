From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: class_for_each_device() oops
Date: Wed, 23 Jul 2008 16:43:47 -0700
Message-ID: <200807231643.47802.david-b@pacbell.net>
References: <200807231606.48016.david-b@pacbell.net>
	<20080723231859.GB30234@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080723231859.GB30234-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 23 July 2008, Greg KH wrote:
> > In this case adding =

> > =

> > =A0=A0=A0=A0=A0=A0if (!class->p)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;
> > =

> > at the top of class_for_each_device() would prevent such
> > oopses from ever happening.
> =

> Makes sense, care to send a real patch for this?

Here you go ... I noticed another place with the same
type of oops-affinity, and fixed that too.

=3D=3D=3D=3D=3D CUT HERE
From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Anti-oops medicine for the class iterators ... the oops was
observed when a class was implicitly referenced before it
was initialized.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/base/class.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/base/class.c	2008-07-22 15:27:52.000000000 -0700
+++ b/drivers/base/class.c	2008-07-23 16:39:58.000000000 -0700
@@ -292,7 +292,7 @@ int class_for_each_device(struct class *
 	struct device *dev;
 	int error =3D 0;
 =

-	if (!class)
+	if (!class || !class->p)
 		return -EINVAL;
 	mutex_lock(&class->p->class_mutex);
 	list_for_each_entry(dev, &class->p->class_devices, node) {
@@ -341,7 +341,7 @@ struct device *class_find_device(struct =

 	struct device *dev;
 	int found =3D 0;
 =

-	if (!class)
+	if (!class || !class->p)
 		return NULL;
 =

 	mutex_lock(&class->p->class_mutex);


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
