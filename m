From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/6] i2c: Get rid of the legacy binding model
Date: Sat, 2 May 2009 12:03:43 -0700
Message-ID: <200905021203.43974.david-b@pacbell.net>
References: <20090502113856.39940f1e@hyperion.delvare> <20090502114020.41c38247@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090502114020.41c38247-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 02 May 2009, Jean Delvare wrote:
> @@ -100,9 +100,8 @@ extern s32 i2c_smbus_write_i2c_block_dat
> =A0 * @class: What kind of i2c device we instantiate (for detect)
> =A0 * @attach_adapter: Callback for bus addition (for legacy drivers)
> =A0 * @detach_adapter: Callback for bus removal (for legacy drivers)

Remnants of the legacy model still remain ...


> - * @detach_client: Callback for device removal (for legacy drivers)
> - * @probe: Callback for device binding (new-style drivers)
> - * @remove: Callback for device unbinding (new-style drivers)
> + * @probe: Callback for device binding
> + * @remove: Callback for device unbinding
> =A0 * @shutdown: Callback for device shutdown
> =A0 * @suspend: Callback for device suspend
> =A0 * @resume: Callback for device resume
