From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Call client_unregister for new-style devices
	too
Date: Mon, 14 Jul 2008 10:02:34 -0700
Message-ID: <200807141002.34600.david-b@pacbell.net>
References: <20080714115613.3d5f608d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080714115613.3d5f608d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 14 July 2008, Jean Delvare wrote:
> We call adapter->client_register for both legacy and new-style i2c
> devices, however we only call adapter->client_unregister for legacy
> drivers. This doesn't make much sense. Usually, drivers will undo
> in client_unregister what they did in client_register, so we should
> call neither or both for every given i2c device.
> 
> In order to ease the transition from legacy to new-style devices, it
> seems preferable to actually call both.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> ---
> David, is this OK with you?

The symmetry point is good; client_unregister() is only
called (for now) in i2c_detach_client() -- a legacy-only
procedure, which I guess is mandatory for legacy drivers
to call at various points.

Did you consider moving the call into i2c_device_remove()
instead?  That'd simplify things by minimizing call sites,
and would ensure that no code path could skip the call.
(The list_del calls could move there too...)

It seems that all users of these adapater callbacks are
in the drivers/media/video subtree, which has an atypical
model for adapters.  A more general notion for this kind
of notification might be useful to non-video adapters,
like a notifier scheme that's usable by third parties.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
