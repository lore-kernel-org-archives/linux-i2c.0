From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Call client_unregister for new-style devices
	too
Date: Mon, 14 Jul 2008 21:15:24 +0200
Message-ID: <20080714211524.259d5e9f@hyperion.delvare>
References: <20080714115613.3d5f608d@hyperion.delvare>
	<200807141002.34600.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200807141002.34600.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Mon, 14 Jul 2008 10:02:34 -0700, David Brownell wrote:
> On Monday 14 July 2008, Jean Delvare wrote:
> > We call adapter->client_register for both legacy and new-style i2c
> > devices, however we only call adapter->client_unregister for legacy
> > drivers. This doesn't make much sense. Usually, drivers will undo
> > in client_unregister what they did in client_register, so we should
> > call neither or both for every given i2c device.
> > 
> > In order to ease the transition from legacy to new-style devices, it
> > seems preferable to actually call both.
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> > ---
> > David, is this OK with you?
> 
> The symmetry point is good; client_unregister() is only
> called (for now) in i2c_detach_client() -- a legacy-only
> procedure, which I guess is mandatory for legacy drivers
> to call at various points.
> 
> Did you consider moving the call into i2c_device_remove()
> instead?  That'd simplify things by minimizing call sites,
> and would ensure that no code path could skip the call.
> (The list_del calls could move there too...)

I did not consider this, probably because the call to client_register()
isn't in i2c_device_probe(), and after all I was aiming at symmetry. I
admit I am a bit too chicken to move things around as long as both the
legacy and the new i2c models are available. In a not so far future,
i2c_attach_client and i2c_detach client will be gone, so whatever code
duplication exists today, will be gone.

> It seems that all users of these adapater callbacks are
> in the drivers/media/video subtree, which has an atypical
> model for adapters.  A more general notion for this kind
> of notification might be useful to non-video adapters,
> like a notifier scheme that's usable by third parties.

I don't think these qualify as atypical. These media drivers have been
amongst the earliest users of the i2c subsystem, and are probably still
the most popular ones amongst "multimedia" PC users. They need these
notifications because to them, each i2c chip driver is only a small
part of a larger driver set, so the "master" driver needs to have a
reference to every i2c_client that is created on the bus. This is
something the legacy model was particularly bad at, thus the
notification mechanism.

While I prefer to have this notification mechanism still active for
new-style i2c devices to ease the transition, this old model will show
its limits quickly: it tells when i2c devices are created and
destroyed, while what users really want to know is when i2c devices are
bound and unbound to their respective drivers. In the old model devices
were always bound, so we never even considered doing a distinction.

Likewise, i2c_use_client and i2c_release_client are almost useless in
the new model. Callers expect to control whether a given client
_driver_ can be removed or not, while when they get now is control on
the client itself (and they typically don't care at all.)

So in a near future, we will have to come up with a parallel
notification system based on driver binding. I know that the driver
core generates events on driver bind/unbind, so that part is OK, but I
still have to think about how we want to deliver these events to the
target "master" drivers, and what API they need to prevent i2c chip
drivers from being unloaded at inconvenient times. 

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
