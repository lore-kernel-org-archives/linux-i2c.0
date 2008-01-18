From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Fri, 18 Jan 2008 02:30:24 -0800
Message-ID: <200801180230.24947.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801141420.49274.david-b@pacbell.net>
	<20080118111401.7ffdccc5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080118111401.7ffdccc5-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 18 January 2008, Jean Delvare wrote:
> > =A0static int i2c_check_addr(struct i2c_adapter *adapter, int addr)
> > =A0{
> > -=A0=A0=A0=A0=A0int rval;
> > -
> > -=A0=A0=A0=A0=A0mutex_lock(&adapter->clist_lock);
> > -=A0=A0=A0=A0=A0rval =3D __i2c_check_addr(adapter, addr);
> > -=A0=A0=A0=A0=A0mutex_unlock(&adapter->clist_lock);
> > -
> > -=A0=A0=A0=A0=A0return rval;
> > +=A0=A0=A0=A0=A0return device_for_each_child(&adapter->dev, &addr, __i2=
c_check_addr);
> > =A0}
> > =A0
> > =A0int i2c_attach_client(struct i2c_client *client)
> =

> With this patch applied, any reason why i2c_new_probed_device() still
> acquires adapter->clist_lock? My understanding is that it was there
> because i2c_check_addr() was originally walking the internal client
> list, but as this is no longer the case, the locking is no longer
> needed, is it?

Doesn't look needed now, no.  It previously called __i2c_check_addr(),
which needed that lock; could have used the non-underscore version
all along.

- Dave


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
